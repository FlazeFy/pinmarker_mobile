import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';

class MapsFocusButton extends StatefulWidget {
  final double userLat;
  final double userLng;

  const MapsFocusButton({
    super.key,
    required this.userLat,
    required this.userLng
  });

  @override
  StateMapsFocusButton createState() => StateMapsFocusButton();
}

class StateMapsFocusButton extends State<MapsFocusButton> {
  final MapsController mapsController = Get.find<MapsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mapsController.moveToMyLocation(widget.userLat, widget.userLng),
      child: FaIcon(FontAwesomeIcons.locationCrosshairs,
          color: Colors.grey[700], size: textXLG),
    );
  }
}
