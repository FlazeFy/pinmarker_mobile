import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';

import '../../../components/button/maps_circle_button.dart';
import '../../../components/container/weather_stats_card.dart';

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

  Future<void> _showWeatherModal() async {
    await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.cloud, color: primaryColor, size: textLG),
            SizedBox(width: spaceSM),
            const Text('Current Weather'),
          ],
        ),
        content: SizedBox(
          width: Get.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Temperature",
                      value: "26.3°C",
                      status: "Warm",
                      statusColor: successBG,
                    ),
                  ),
                  SizedBox(width: spaceMD),
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Humidity",
                      value: "92%",
                      status: "Humid",
                      statusColor: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spaceMD),
              Row(
                children: [
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Wind Speed",
                      value: "0.9 km/h",
                      status: "Calm",
                      statusColor: successBG,
                    ),
                  ),
                  SizedBox(width: spaceMD),
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Air Quality",
                      value: "AQI 109",
                      status: "Unhealthy",
                      statusColor: dangerBG,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
            onTap: _showWeatherModal,
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
