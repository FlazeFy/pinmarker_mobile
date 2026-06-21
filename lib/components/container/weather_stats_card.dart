import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class WeatherStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String status;
  final Color statusColor;

  const WeatherStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(roundedMD),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: textXSM,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: greyColor,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: textXMD,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: value),
                TextSpan(
                  text: " ($status)",
                  style: TextStyle(color: statusColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}