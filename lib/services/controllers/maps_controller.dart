import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinmarker/helpers/variables/global.dart';

class MapsController extends GetxController {
  final MapController mapController = MapController();
  final mapType = MapType.defaultMap.obs;
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

  void changeMapType(MapType type) {
    mapType.value = type;
  }

  String get tileUrl {
    switch (mapType.value) {
      case MapType.satellite:
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
      case MapType.terrain:
        return 'https://tile.opentopomap.org/{z}/{x}/{y}.png';
      case MapType.defaultMap:
      default:
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  String get attribution {
    switch (mapType.value) {
      case MapType.satellite:
        return '&copy; Esri';
      case MapType.terrain:
        return '&copy; OpenTopoMap';
      default:
        return '&copy; OpenStreetMap contributors';
    }
  }
}