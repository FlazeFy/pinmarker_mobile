import 'dart:async';
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

class GetCurrentCoor extends StatefulWidget {
  @override
  StateGetCurrentCoor createState() => StateGetCurrentCoor();
}

class StateGetCurrentCoor extends State<GetCurrentCoor> {
  Position? currentPosition;
  String? lastUpdated;
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

    if (currentPosition != null) {
      double distance = calculateDistance(
          '${currentPosition?.latitude},${currentPosition?.longitude}',
          '${position.latitude},${position.longitude}');

      if (distance > distanceDiffToTrack) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(spaceMD),
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
            Row(
              children: [
                Text(
                  "Last Updated : ${lastUpdated ?? 'Updating...'}",
                  style:
                      TextStyle(fontStyle: FontStyle.italic, fontSize: textXSM),
                )
              ],
            )
          ],
        ));
  }
}
