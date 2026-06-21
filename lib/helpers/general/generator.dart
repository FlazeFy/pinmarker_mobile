import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:pinmarker/helpers/variables/style.dart';

String generateTempDataKey() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
  return formattedDate;
}

String getTemperatureLabel(double temp) {
  if (temp <= 15) return "Cold";
  if (temp <= 25) return "Cool";
  if (temp <= 32) return "Warm";
  return "Hot";
}

Color getTemperatureColor(double temp) {
  if (temp <= 15) return primaryColor;
  if (temp <= 25) return infoBG;
  if (temp <= 32) return successBG;
  return dangerBG;
}

String getHumidityLabel(int humidity) {
  if (humidity < 30) return "Dry";
  if (humidity <= 60) return "Normal";
  return "Humid";
}

Color getHumidityColor(int humidity) {
  if (humidity < 30) return warningBG;
  if (humidity <= 60) return successBG;
  return infoBG;
}

String getWindLabel(double wind) {
  if (wind <= 5) return "Calm";
  if (wind <= 20) return "Breezy";
  return "Danger";
}

Color getWindColor(double wind) {
  if (wind <= 5) return successBG;
  if (wind <= 20) return warningBG;
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
  if (aqi <= 100) return warningBG;
  if (aqi <= 150) return dangerBG;
  return dangerBG;
}