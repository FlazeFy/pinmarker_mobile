import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentButtonPrimary extends StatelessWidget {
  final String? text;
  final dynamic icon;
  final dynamic color;
  final bool? isBig;

  const ComponentButtonPrimary(
      {super.key, this.text, this.icon, this.color, this.isBig});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: isBig != null && isBig == true ? spaceSM + 2 : spaceMini,
          horizontal: isBig != null && isBig == true ? textXMD + 2 : spaceXSM),
      decoration: BoxDecoration(
        color: color ?? primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
        border: Border.all(
            color: color != whiteColor && color != null ? color : primaryColor,
            width: 1.5),
      ),
      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        icon != null
            ? Container(margin: EdgeInsets.only(right: spaceXXSM), child: icon)
            : const SizedBox(),
        text != null
            ? Text(text ?? '-',
                style: TextStyle(
                  color: color == whiteColor ? primaryColor : whiteColor,
                  fontSize:
                      isBig != null && isBig == true ? textXMD + 2 : textXMD,
                ))
            : const SizedBox(),
      ]),
    );
  }
}
