import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';
import 'package:pinmarker/services/modules/location/model/current_weather.dart';
import '../../../components/button/maps_circle_button.dart';
import '../../../components/container/weather_stats_card.dart';
import '../../../services/modules/location/service/queries.dart';

class MapsWeather extends StatefulWidget {
  const MapsWeather({super.key});

  @override
  StateMapsWeather createState() => StateMapsWeather();
}

class StateMapsWeather extends State<MapsWeather> {
  final MapsController mapsController = Get.find<MapsController>();
  CurrentWeatherModel? weatherData;
  DateTime? lastUpdate;
  bool isLoading = true;
  Timer? timer;
  final WeatherServices weatherServices = WeatherServices();

  @override
  void initState() {
    super.initState();
    _loadWeather();
    // Periodic fetch
    timer = Timer.periodic(const Duration(minutes: 10), (_) => _loadWeather());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _loadWeather() async {
    // Call service
    final result = await weatherServices.getCurrentWeather(
      latitude: mapsController.latitude.value,
      longitude: mapsController.longitude.value,
    );
    final update = await weatherServices.getLastUpdate("weather-last-update");
    if (!mounted) return;

    setState(() {
      weatherData = result;
      lastUpdate = update;
      isLoading = false;
    });
  }

  String getTemperatureLabel(double temp) {
    if (temp <= 15) return "Cold";
    if (temp <= 25) return "Cool";
    if (temp <= 32) return "Warm";
    return "Hot";
  }

  Color getTemperatureColor(double temp) {
    if (temp <= 15) return Colors.blue;
    if (temp <= 25) return Colors.lightBlue;
    if (temp <= 32) return successBG;
    return dangerBG;
  }

  String getHumidityLabel(int humidity) {
    if (humidity < 30) return "Dry";
    if (humidity <= 60) return "Normal";
    return "Humid";
  }

  Color getHumidityColor(int humidity) {
    if (humidity < 30) return Colors.orange;
    if (humidity <= 60) return successBG;
    return Colors.lightBlue;
  }

  String getWindLabel(double wind) {
    if (wind <= 5) return "Calm";
    if (wind <= 20) return "Breezy";
    return "Danger";
  }

  Color getWindColor(double wind) {
    if (wind <= 5) return successBG;
    if (wind <= 20) return Colors.orange;
    return dangerBG;
  }

  String getAqiLabel(int aqi) {
    if (aqi <= 50) return "Good";
    if (aqi <= 100) return "Moderate";
    if (aqi <= 150) return "Unhealthy";
    return "Bad";
  }

  Color getAqiColor(int aqi) {
    if (aqi <= 50) return successBG;
    if (aqi <= 100) return Colors.orange;
    if (aqi <= 150) return dangerBG;
    return dangerBG;
  }

  bool get hasDangerWeather {
    if (weatherData == null) return false;

    final temp = weatherData!.weather.temperature;
    final wind = weatherData!.weather.windSpeed;
    final aqi = weatherData!.air.aqi;

    return temp > 32 || wind > 20 || aqi > 100;
  }

  Future<void> _showWeatherModal() async {
    if (weatherData == null) {
      Get.snackbar(
        "Information",
        "Weather data unavailable",
      );
      return;
    }

    final weather = weatherData!.weather;
    final air = weatherData!.air;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedLG),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.cloud,
                  color: primaryColor,
                  size: textLG,
                ),
                SizedBox(width: spaceSM),
                const Text("Current Weather"),
              ],
            ),
            if (lastUpdate != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "Last update: ${lastUpdate.toString()}",
                  style: TextStyle(
                    fontSize: textSM,
                    color: greyColor,
                  ),
                ),
              ),
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
                      value:
                      "${weather.temperature.toStringAsFixed(1)}${weather.unit}",
                      status: getTemperatureLabel(
                        weather.temperature,
                      ),
                      statusColor: getTemperatureColor(
                        weather.temperature,
                      ),
                    ),
                  ),
                  SizedBox(width: spaceMD),
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Humidity",
                      value: "${weather.humidity}%",
                      status: getHumidityLabel(
                        weather.humidity,
                      ),
                      statusColor: getHumidityColor(
                        weather.humidity,
                      ),
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
                      value:
                      "${weather.windSpeed.toStringAsFixed(1)} km/h",
                      status: getWindLabel(
                        weather.windSpeed,
                      ),
                      statusColor: getWindColor(
                        weather.windSpeed,
                      ),
                    ),
                  ),
                  SizedBox(width: spaceMD),
                  Expanded(
                    child: WeatherStatsCard(
                      title: "Air Quality",
                      value: "AQI ${air.aqi}",
                      status: getAqiLabel(
                        air.aqi,
                      ),
                      statusColor: getAqiColor(
                        air.aqi,
                      ),
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
