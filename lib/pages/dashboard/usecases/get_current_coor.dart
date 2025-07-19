import 'dart:async';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/general/converter.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_last_coor.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_speed.dart';
import 'package:pinmarker/services/modules/track/command.dart';
import 'package:pinmarker/services/modules/track/command_realtime.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinmarker/services/sqlite/helper.dart';

class GetCurrentCoor extends StatefulWidget {
  const GetCurrentCoor({super.key});

  @override
  StateGetCurrentCoor createState() => StateGetCurrentCoor();
}

class StateGetCurrentCoor extends State<GetCurrentCoor> {
  Position? currentPosition;
  String? lastUpdated;
  String? lastDistance;
  String? lastSpeed;
  double? topSpeed;
  late CommandTrackRealtime realtimeService;
  late Timer timer;
  var battery = Battery();
  late TrackCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = TrackCommandsService();
    getLocation();
    realtimeService = CommandTrackRealtime();
    getTimerTrackingToSqlite();
    getTimerSqliteToRestAPI();
    getTimerResetExpiredTrack();
  }

  // Set timer interval based on battery level and power saving mode
  Future<void> getTimerTrackingToSqlite() async {
    int batteryIndicator = await battery.batteryLevel;
    bool isSaveMode = await battery.isInBatterySaveMode;
    int timerInterval = batteryIndicator > 60
        ? checkIntervalTimeHigh
        : batteryIndicator > 30 || isSaveMode
            ? checkIntervalTimeMid
            : checkIntervalTimeLow;

    // Start periodic timer to fetch location
    timer = Timer.periodic(
        Duration(seconds: timerInterval), (Timer t) => getLocation());
  }

  Future<void> getTimerSqliteToRestAPI() async {
    int batteryLevel = await battery.batteryLevel;
    bool isSaveMode = await battery.isInBatterySaveMode;
    int interval = batteryLevel > 30 || !isSaveMode ? 30 : 60;

    timer = Timer.periodic(Duration(seconds: interval), (timer) async {
      try {
        final dbHelper = DatabaseHelper();
        final List<Map<String, dynamic>> unsyncedTracks =
            await dbHelper.getReadySaveTracker();

        if (unsyncedTracks.isEmpty) return;

        List<AddTrackModelGin> dataList = unsyncedTracks.map((row) {
          final dt = DateTime.parse(row['created_at']).toLocal();
          final offset = dt.timeZoneOffset;
          final offsetStr =
              '${offset.isNegative ? '-' : '+'}${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes.abs() % 60).toString().padLeft(2, '0')}';
          final createdAtFormatted =
              DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").format(dt) + offsetStr;

          return AddTrackModelGin(
            trackLat: row['track_lat'].toString(),
            trackLong: row['track_long'].toString(),
            trackType: row['track_type'],
            batteryIndicator: row['battery_indicator'],
            createdAt: createdAtFormatted,
            userId: "fcd3f23e-e5aa-11ee-892a-3216422910e9",
          );
        }).toList();

        List<Map<String, dynamic>> jsonList =
            dataList.map((e) => e.toJson()).toList();

        var response = await apiCommand.postTrack(jsonList);

        if (response['code'] == 201) {
          for (var row in unsyncedTracks) {
            await dbHelper.updateTrackerSyncStatus(row['id'], true);
          }
        } else {
          var msg = response['message'] ?? 'Unknown error';
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger, title: "Failed", text: msg),
          );
        }
      } catch (err) {
        if (mounted) {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Failed!",
                text: err.toString()),
          );
        }
      }
    });
  }

  Future<void> getTimerResetExpiredTrack() async {
    timer = Timer.periodic(Duration(seconds: checkIntervalRunExpiredTrackTime),
        (timer) async {
      try {
        final dbHelper = DatabaseHelper();
        await dbHelper.deleteExpiredSyncedTrackers(expiredTrackTime);
      } catch (err) {
        if (mounted) {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Failed!",
                text: err.toString()),
          );
        }
      }
    });
  }

  Future<void> getLocation() async {
    int batteryIndicator = await battery.batteryLevel;
    final box = GetStorage();
    bool serviceEnabled;
    LocationPermission permission;

    // Check location permission
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Ask location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // Permission denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (!mounted) return;

    setState(() {
      currentPosition = position;
    });

    // If previous coordinates exist, calculate distance
    if (currentPosition != null &&
        box.read('last_lat') != null &&
        box.read('last_long') != null) {
      double lastLat = box.read('last_lat');
      double lastLong = box.read('last_long');

      // Distance calculate
      double distance = calculateDistance(
          '${currentPosition?.latitude},${currentPosition?.longitude}',
          '$lastLat,$lastLong');
      bool isSaveMode = await battery.isInBatterySaveMode;

      // Recalculate timer interval based on updated battery
      int timerInterval = batteryIndicator > 60
          ? checkIntervalTimeHigh
          : batteryIndicator > 30 || isSaveMode
              ? checkIntervalTimeMid
              : checkIntervalTimeLow;
      if (!mounted) return;

      // Calculate and update speed and distance
      setState(() {
        lastDistance = '${distance.toStringAsFixed(2)} m';
        double speedRaw = countSpeed(distance, timerInterval);
        lastSpeed = '${speedRaw.toStringAsFixed(2)} Km/h';
        if (topSpeed == null || speedRaw > topSpeed!) {
          topSpeed = speedRaw;
        }

        // Warn if speed exceeds limit
        if (speedRaw > speedLimitWarning) {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.warning,
                  title: "Be Carefull!",
                  text: "Keep driving safe and don't use your phone"));
        }
      });

      // If moved, store new position locally and save to SQLite
      // if (distance > generalFetchRestDistance) {
      if (distance >= 0) {
        box.write('last_lat', currentPosition?.latitude);
        box.write('last_long', currentPosition?.longitude);

        // Prepare model
        String dateNow = DateTime.now().toIso8601String();
        int batteryIndicator = await battery.batteryLevel;
        AddTrackModel data = AddTrackModel(
            trackLat: currentPosition!.latitude,
            trackLong: currentPosition!.longitude,
            trackType: 'live',
            batteryIndicator: batteryIndicator,
            createdAt: dateNow);

        try {
          final dbHelper = DatabaseHelper();

          // Insert to local SQLite database
          await dbHelper.insertTracker(
            batteryIndicator: data.batteryIndicator,
            trackLat: data.trackLat,
            trackLong: data.trackLong,
            trackType: data.trackType,
            createdAt: data.createdAt,
            isSync: false,
          );

          if (!mounted) return;
          setState(() {
            lastUpdated = dateNow;
          });
        } catch (error) {
          if (mounted) {
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Failed!",
                  text: "Failed to save coordinate"),
            );
          }
        }
      }
    } else if (box.read('last_lat') == null && box.read('last_long') == null) {
      String dateNow = DateTime.now().toIso8601String();
      setState(() {
        lastUpdated = dateNow;
      });

      // Save first coordinate
      box.write('last_lat', currentPosition?.latitude);
      box.write('last_long', currentPosition?.longitude);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  title: null,
                  customColumns: [
                    const ComponentTextTitle(
                        text: 'Last Coordinate', type: "section_title"),
                    const GetLastCoor(),
                  ],
                  text: null));
        },
        child: Container(
            padding: EdgeInsets.all(spaceMD),
            width: Get.width,
            margin: EdgeInsets.only(top: spaceMD),
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
            child: Column(
              children: [
                const ComponentTextTitle(
                    text: 'Current Coordinate', type: "section_title"),
                if (currentPosition != null)
                  Text(
                    'Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}',
                  )
                else
                  const Text('Get current location...'),
                SizedBox(height: spaceSM),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Last Updated : ${lastUpdated ?? 'Updating...'}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: textSM),
                    ),
                    Text(
                      "Last Distance : ${lastDistance ?? 'Updating...'}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: textSM),
                    ),
                  ],
                )
              ],
            )),
      ),
      GetSpeed(
        lastSpeed: lastSpeed,
        topSpeed: topSpeed,
      ),
    ]);
  }
}
