import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/maps_type_toggle.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';
import '../../../components/button/maps_circle_button.dart';

class MapsControl extends StatefulWidget {
  const MapsControl({super.key});

  @override
  StateMapsControl createState() => StateMapsControl();
}

class StateMapsControl extends State<MapsControl> {
  final MapsController mapsController = Get.find<MapsController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showControlModal() async {

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedLG),
        ),
        title: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.filter,
              color: primaryColor,
              size: textLG,
            ),
            SizedBox(width: spaceSM),
            const Text("Current Weather"),
          ],
        ),
        content: SizedBox(
          width: Get.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Map Type", style: TextStyle(fontWeight: FontWeight.w700, color: secondaryColor, fontSize: textXMD)),
              SizedBox(height: spaceMD),
              MapTypeToggle(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapsCircleButton(
      color: primaryColor,
      onTap: _showControlModal,
      child: FaIcon(FontAwesomeIcons.bars,
          color: whiteColor, size: textLG),
    );
  }
}
