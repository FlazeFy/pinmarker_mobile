import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';

class MapsBoard extends StatefulWidget {
  const MapsBoard({super.key});

  @override
  StateMapsBoard createState() => StateMapsBoard();
}

class StateMapsBoard extends State<MapsBoard> {
  final MapsController mapsController = Get.find<MapsController>();
  StreamSubscription<Position>? _locationSub;
  double? _userLat;
  double? _userLng;

  final List<Map<String, dynamic>> _pins = [
    {'id': 1, 'name': 'Pin A', 'lat': -6.2297, 'lng': 106.8295},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _requestLocation());
  }

  @override
  void dispose() {
    _locationSub?.cancel();
    super.dispose();
  }

  Future<void> _requestLocation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.locationDot, color: primaryColor, size: textXMD),
            SizedBox(width: spaceSM),
            const Text('Location Access'),
          ],
        ),
        content: const Text(
          'PinMarker needs your location to show nearby pins and your position on the map.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Deny', style: TextStyle(color: greyColor)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedXLG)),
              elevation: 0,
            ),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final status = await Permission.location.request();

    if (status.isGranted) {
      _startTracking();
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  void _startTracking() {
    Geolocator.getCurrentPosition().then(_updateUserLocation);

    _locationSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // update every 10 meters moved
      ),
    ).listen(_updateUserLocation);
  }

  void _updateUserLocation(Position position) {
    _locationSub = Geolocator.getPositionStream().listen((position) {
      setState(() {
        _userLat = position.latitude;
        _userLng = position.longitude;
      });

      mapsController.updateLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });

    mapsController.mapController.move(LatLng(position.latitude, position.longitude), 12);
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Permission Denied'),
        content: const Text(
            'Location permission is permanently denied. Please enable it in app settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: greyColor)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              elevation: 0,
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapsController.mapController,
      options: const MapOptions(
        initialCenter: LatLng(-6.2088, 106.8456),
        initialZoom: 13,
        interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.pinmarker',
        ),

        if (_userLat != null && _userLng != null)
          CircleLayer(
            circles: [
              CircleMarker(
                point: LatLng(_userLat!, _userLng!),
                radius: 5000,
                useRadiusInMeter: true,
                color: primaryColor.withOpacity(0.12),
                borderColor: primaryColor,
                borderStrokeWidth: 3,
              ),
            ],
          ),

        MarkerLayer(
          markers: _pins.map((pin) {
            return Marker(
              point: LatLng(pin['lat'], pin['lng']),
              width: 40,
              height: 50,
              child: GestureDetector(
                onTap: () => _showPinInfo(context, pin),
                child: Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.locationDot,
                            color: whiteColor, size: textLG),
                      ),
                    ),
                    CustomPaint(
                      size: const Size(12, 10),
                      painter: _MarkerTailPainter(color: primaryColor),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        if (_userLat != null && _userLng != null)
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(_userLat!, _userLng!),
                width: 24,
                height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: whiteColor,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _showPinInfo(BuildContext context, Map<String, dynamic> pin) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FaIcon(FontAwesomeIcons.locationDot,
                    color: whiteColor, size: textLG),
              ),
            ),
            SizedBox(width: spaceMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(pin['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: textXMD)),
                  Text(
                    'Lat: ${pin['lat']}, Lng: ${pin['lng']}',
                    style: TextStyle(color: greyColor, fontSize: textSM),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child:
              FaIcon(FontAwesomeIcons.xmark, color: greyColor, size: textLG),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarkerTailPainter extends CustomPainter {
  final Color color;
  const _MarkerTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MarkerTailPainter old) => old.color != color;
}