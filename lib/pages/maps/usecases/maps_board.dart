import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class MapsBoard extends StatefulWidget {
  const MapsBoard({super.key});

  @override
  StateMapsBoard createState() => StateMapsBoard();
}

class StateMapsBoard extends State<MapsBoard> {
  final MapController _mapController = MapController();
  final List<Map<String, dynamic>> _pins = [
    {'id': 1, 'name': 'Pin A', 'lat': -6.2297, 'lng': 106.8295},
  ];

  void zoomIn() {
    final current = _mapController.camera;
    _mapController.move(current.center, current.zoom + 1);
  }

  void zoomOut() {
    final current = _mapController.camera;
    _mapController.move(current.center, current.zoom - 1);
  }

  void moveToMyLocation() {
    _mapController.move(const LatLng(-6.2088, 106.8456), 13);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(-6.2088, 106.8456),
        initialZoom: 13,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.pinmarker',
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
                        child: FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: whiteColor,
                          size: textLG,
                        ),
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
              child: FaIcon(FontAwesomeIcons.xmark,
                  color: greyColor, size: textLG),
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
    final path = ui.Path()..moveTo(0, 0)..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MarkerTailPainter old) => old.color != color;
}