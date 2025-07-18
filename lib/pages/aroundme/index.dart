import 'dart:async';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/general/converter.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/aroundme/usecases/get_nearest_pin.dart';
import 'package:pinmarker/services/modules/track/command_realtime.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:pinmarker/services/sqlite/helper.dart';

class AroundMePage extends StatefulWidget {
  const AroundMePage({super.key});

  @override
  StateAroundMePage createState() => StateAroundMePage();
}

class StateAroundMePage extends State<AroundMePage> {
  Position? currentPosition;
  late CommandTrackRealtime realtimeService;
  late Timer timer;
  var battery = Battery();

  @override
  void initState() {
    super.initState();
    getLocation();
    realtimeService = CommandTrackRealtime();
    getTimer();
  }

  // Set timer interval based on battery level and power saving mode
  Future<void> getTimer() async {
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
        double speedRaw = countSpeed(distance, timerInterval);

        // Warn if speed exceeds limit
        if (speedRaw > 120) {
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
      if (distance > 0) {
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
    return Scaffold(
      drawer: const LeftBar(),
      appBar: AppBar(
        title:
            const ComponentTextTitle(type: "content_title", text: "Around Me"),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleInfo),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.info,
                      title: "Information!",
                      text:
                          "This will show nearest marker around you up to 10 KM"));
            },
          )
        ],
      ),
      body: ListView(padding: EdgeInsets.all(spaceMD), children: [
        if (currentPosition != null)
          GetNearestPin(
            lat: currentPosition!.latitude.toString(),
            long: currentPosition!.longitude.toString(),
          )
        else
          const Center(child: Text('Current position not available')),
      ]),
    );
  }
}
