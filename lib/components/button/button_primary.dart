import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentButtonPrimary extends StatelessWidget {
  final String text;
  final dynamic icon;

  const ComponentButtonPrimary({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spaceMini, horizontal: spaceXSM),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
