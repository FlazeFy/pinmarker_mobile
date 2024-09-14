import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentTextTitle extends StatelessWidget {
  final String type;
  final String text;

  const ComponentTextTitle({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    if (type == 'section_title') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style:
                  TextStyle(fontSize: textXLG, fontWeight: FontWeight.bold)));
    } else {
      return const Text("Default Title");
    }
  }
}
