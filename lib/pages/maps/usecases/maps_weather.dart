import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/helpers/variables/style.dart';

import '../../../components/button/maps_circle_button.dart';

class MapsWeather extends StatefulWidget {
  const MapsWeather({super.key});

  @override
  StateMapsWeather createState() => StateMapsWeather();
}

class StateMapsWeather extends State<MapsWeather> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: spaceMD,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          MapsCircleButton(
            color: primaryColor,
            size: 52,
            onTap: () {},
            child: FaIcon(FontAwesomeIcons.cloud,
                color: whiteColor, size: textXLG),
          ),
          Positioned(
            bottom: -4,
            right: -4,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: dangerBG,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FaIcon(FontAwesomeIcons.triangleExclamation,
                    color: whiteColor, size: textXSM),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
