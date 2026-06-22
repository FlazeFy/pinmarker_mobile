import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';

class MapTypeToggle extends StatelessWidget {
  final MapsController mapsController = Get.find<MapsController>();
  MapTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Expanded(
            child: _item("Default", MapType.defaultMap),
          ),
          Expanded(
            child: _item("Satellite", MapType.satellite),
          ),
          Expanded(
            child: _item("Terrain", MapType.terrain),
          ),
        ],
      ),
    );
  }

  Widget _item(String title, MapType type) {
    return Obx(() {
      final active = mapsController.mapType.value == type;

      return GestureDetector(
        onTap: () => mapsController.changeMapType(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color: active ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: active
                ? [
              BoxShadow(
                color: primaryColor.withOpacity(.3),
                blurRadius: 8,
              )
            ]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: active ? whiteColor : secondaryColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}