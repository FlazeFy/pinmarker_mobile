import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentButtonPrimary extends StatelessWidget {
  final String? text;
  final dynamic icon;
  final dynamic color;

  const ComponentButtonPrimary({super.key, this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spaceMini, horizontal: spaceXSM),
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
      ),
      child: Row(children: [
        text != null
            ? Text(text ?? '-', style: const TextStyle(color: Colors.white))
            : const SizedBox(),
        icon != null
            ? Container(padding: EdgeInsets.all(spaceMini - 0.2), child: icon)
            : const SizedBox()
      ]),
    );
  }
}
