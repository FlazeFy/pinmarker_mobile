import 'dart:math';

double toRadians(double degree) {
  return degree * pi / 180;
}

double calculateDistance(coord1, coord2) {
  const double earthRadius = 6371000;

  List<String> coord1Parts = coord1.split(',');
  List<String> coord2Parts = coord2.split(',');

  double lat1 = double.parse(coord1Parts[0]);
  double lon1 = double.parse(coord1Parts[1]);
  double lat2 = double.parse(coord2Parts[0]);
  double lon2 = double.parse(coord2Parts[1]);

  double latRad1 = toRadians(lat1);
  double lonRad1 = toRadians(lon1);
  double latRad2 = toRadians(lat2);
  double lonRad2 = toRadians(lon2);

  double latDiff = latRad2 - latRad1;
  double lonDiff = lonRad2 - lonRad1;

  double a = sin(latDiff / 2) * sin(latDiff / 2) +
      cos(latRad1) * cos(latRad2) * sin(lonDiff / 2) * sin(lonDiff / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;

  return distance;
}

String distanceUnit(double val) {
  String unit = 'm';
  double res = val;

  if (val > 1000) {
    unit = 'km';
    res = res / 1000;
  }

  return "${res.toStringAsFixed(2)} $unit";
}

String timeUnit(int val) {
  if (val < 1000) {
    return "$val ms";
  } else {
    int diffInSeconds = (val / 1000).floor();
    return "${diffInSeconds}s";
  }
}

int countDatetimeStrInterval(String startTime, String endTime) {
  String formattedStartTime = "${startTime.replaceAll(" ", "T")}Z";
  String formattedEndTime = "${endTime.replaceAll(" ", "T")}Z";

  DateTime startDateTime = DateTime.parse(formattedStartTime);
  DateTime endDateTime = DateTime.parse(formattedEndTime);

  Duration diff = endDateTime.difference(startDateTime);

  return diff.inSeconds;
}

double countSpeed(double distance, int time) {
  if (time == 0) {
    return 0.0;
  }
  double speed = (distance * 3600) / (time * 1000);
  return speed;
}

String ucFirst(String val) {
  String res = "";
  if (val.trim() != "") {
    res = val[0].toUpperCase() + val.substring(1);
  }
  return res;
}

String ucAll(String val) {
  List<String> words = val.split(' ');
  words =
      words.map((word) => word[0].toUpperCase() + word.substring(1)).toList();
  return words.join(' ');
}
