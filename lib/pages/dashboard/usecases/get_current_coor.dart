import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:intl/intl.dart';

class GetCurrentCoor extends StatefulWidget {
  @override
  StateGetCurrentCoor createState() => StateGetCurrentCoor();
}

class StateGetCurrentCoor extends State<GetCurrentCoor> {
  Position? currentPosition;
  String? lastUpdated;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    getLocation();
    timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => getLocation());
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
      lastUpdated = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    });
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
