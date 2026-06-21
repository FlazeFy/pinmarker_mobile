import 'package:get/get.dart';

class MapsController extends GetxController {
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  void updateLocation({
    required double latitude,
    required double longitude,
  }) {
    this.latitude.value = latitude;
    this.longitude.value = longitude;
  }
}