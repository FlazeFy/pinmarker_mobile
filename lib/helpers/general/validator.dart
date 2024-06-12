import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/global.dart';

Future checkGps(var func) async {
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission permission;

  servicestatus = await Geolocator.isLocationServiceEnabled();
  if (servicestatus) {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Alert", 'Location permissions are denied',
            backgroundColor: Colors.white);
      } else if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Alert", 'Location permissions are permanently denied',
            backgroundColor: Colors.white);
      } else {
        haspermission = true;
      }
    } else {
      haspermission = true;
    }

    if (haspermission) {
      func;
    }
  } else {
    if (!isShownOffLocationPop) {
      Get.snackbar("Alert", 'GPS Service is not enabled, turn on GPS location',
          backgroundColor: Colors.white);
      isShownOffLocationPop = true;
    }
  }
}
