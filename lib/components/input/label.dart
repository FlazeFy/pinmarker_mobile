import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

Widget getInputLabel(String title, bool isMandatory) {
  return Container(
      margin: EdgeInsets.only(bottom: spaceMini),
      child: RichText(
        text: TextSpan(
          children: [
            if (isMandatory)
              TextSpan(
                  text: "* ",
                  style: TextStyle(
                      color: dangerBG,
                      fontWeight: FontWeight.w500,
                      fontSize: textXMD)),
            TextSpan(
                text: title,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: textXMD + 1)),
          ],
        ),
      ));
}
