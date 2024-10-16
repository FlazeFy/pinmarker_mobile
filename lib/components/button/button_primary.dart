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
      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        icon != null
            ? Container(margin: EdgeInsets.only(right: spaceXXSM), child: icon)
            : const SizedBox(),
        text != null
            ? Text(text ?? '-', style: const TextStyle(color: Colors.white))
            : const SizedBox(),
      ]),
    );
  }
}
