import 'dart:async';
import 'dart:ffi';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/dialog/Dialogs/failed.dart';
import 'package:pinmarker/helpers/general/converter.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/track/command_realtime.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:get_storage/get_storage.dart';

class GetCurrentCoor extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    getLocation();
    realtimeService = CommandTrackRealtime();
    getTimer();
  }

  Future<void> getTimer() async {
    int batteryIndicator = await battery.batteryLevel;
    bool isSaveMode = await battery.isInBatterySaveMode;
    int timerInterval = batteryIndicator > 60
        ? checkIntervalTimeHigh
        : batteryIndicator > 30 || isSaveMode
            ? checkIntervalTimeMid
            : checkIntervalTimeLow;

    timer = Timer.periodic(
        Duration(seconds: timerInterval), (Timer t) => getLocation());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> getLocation() async {
    int batteryIndicator = await battery.batteryLevel;
    final box = GetStorage();
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });

    if (currentPosition != null &&
        box.read('last_lat') != null &&
        box.read('last_long') != null) {
      double lastLat = box.read('last_lat');
      double lastLong = box.read('last_long');

      double distance = calculateDistance(
          '${currentPosition?.latitude},${currentPosition?.longitude}',
          '${lastLat},${lastLong}');
      bool isSaveMode = await battery.isInBatterySaveMode;

      int timerInterval = batteryIndicator > 60
          ? checkIntervalTimeHigh
          : batteryIndicator > 30 || isSaveMode
              ? checkIntervalTimeMid
              : checkIntervalTimeLow;
      setState(() {
        lastDistance = '${distance.toStringAsFixed(2)} m';
        double speedRaw = countSpeed(distance, timerInterval);
        lastSpeed = '${speedRaw.toStringAsFixed(2)} Km/h';
        if (topSpeed == null || speedRaw > topSpeed!) {
          topSpeed = speedRaw;
        }
      });

      if (distance > distanceDiffToTrack) {
        box.write('last_lat', currentPosition?.latitude);
        box.write('last_long', currentPosition?.longitude);

        String dateNow = DateTime.now().toIso8601String();
        int batteryIndicator = await battery.batteryLevel;

        AddTrackModel data = AddTrackModel(
            trackLat: currentPosition!.latitude,
            trackLong: currentPosition!.longitude,
            trackType: 'live',
            batteryIndicator: batteryIndicator,
            createdAt: dateNow);

        // Firebase
        try {
          var res = await realtimeService.addTrack(data);
          String realtimeId = res;
          setState(() {
            lastUpdated = dateNow;
          });
        } catch (error) {
          Get.dialog(FailedDialog(text: "Failed to save coordinate"));
        }
      }
    } else if (box.read('last_lat') == null && box.read('last_long') == null) {
      box.write('last_lat', currentPosition?.latitude);
      box.write('last_long', currentPosition?.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(spaceMD),
          width: Get.width,
          margin: EdgeInsets.only(top: spaceMD),
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
          child: Column(
            children: [
              Text(
                'Current Coordinate',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: textLG),
              ),
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
      Container(
          padding: EdgeInsets.all(spaceMD),
          margin: EdgeInsets.only(top: spaceMD),
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
          child: Column(children: [
            Text(
              'Current Speed',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: textLG),
            ),
            Text(
              lastSpeed ?? 'Updating...',
              style:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: textXJumbo),
            ),
            Text(
              'Top Speed',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: textLG),
            ),
            Text(
              topSpeed != null
                  ? '${topSpeed!.toStringAsFixed(2)} Km/h'
                  : 'Updating...',
              style:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: textXJumbo),
            )
          ]))
    ]);
  }
}
