import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  final MapController mapController = MapController();
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  void updateLocation({
    required double latitude,
    required double longitude,
  }) {
    this.latitude.value = latitude;
    this.longitude.value = longitude;
  }

  void zoomIn() {
    final camera = mapController.camera;
    mapController.move(
      camera.center,
      camera.zoom + 1,
    );
  }

  void zoomOut() {
    final camera = mapController.camera;
    mapController.move(
      camera.center,
      camera.zoom - 1,
    );
  }

  void moveToMyLocation(double userLat, double userLng) {
    mapController.move(LatLng(userLat, userLng), 13);
  }
}