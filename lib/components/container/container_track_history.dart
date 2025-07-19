import 'package:flutter/material.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentContainerTrackHistory extends StatelessWidget {
  final int batteryIndicator;
  final double trackLat;
  final double trackLong;
  final String createdAt;
  final int isSync;

  const ComponentContainerTrackHistory(
      {super.key,
      required this.batteryIndicator,
      required this.trackLat,
      required this.trackLong,
      required this.createdAt,
      required this.isSync});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: spaceMD),
      padding: EdgeInsets.all(spaceMD),
      decoration: BoxDecoration(
          border: Border.all(width: spaceMini / 2.5, color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Battery Indicator: $batteryIndicator%'),
          Text('Coordinate: $trackLat, $trackLong'),
          Text('Record At: $createdAt'),
          Row(
            children: [
              const Text('Is Sync:'),
              SizedBox(width: spaceSM),
              isSync == 1
                  ? const ComponentButtonPrimary(
                      text: "Yes", icon: null, color: successBG, isBig: false)
                  : const ComponentButtonPrimary(
                      text: "No", icon: null, color: dangerBG, isBig: false)
            ],
          ),
        ],
      ),
    );
  }
}
