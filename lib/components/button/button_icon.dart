import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentButtonIcon extends StatelessWidget {
  final dynamic color;
  final dynamic icon;

  const ComponentButtonIcon(
      {super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      icon: FaIcon(
        icon,
        size: textMD,
        color: Colors.white,
      ),
      color: color,
      onPressed: () {},
    );
  }
}
