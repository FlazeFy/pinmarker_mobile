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
    } else if (type == 'content_title') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: TextStyle(fontSize: textLG, fontWeight: FontWeight.w500)));
    } else if (type == 'content_sub_title') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: TextStyle(fontSize: textMD, fontWeight: FontWeight.w500)));
    } else if (type == 'content_body') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: TextStyle(
                  fontSize: textSM,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(255, 92, 92, 92))));
    } else if (type == 'content_tag') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 82, 82, 82),
              borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
          padding: EdgeInsets.all(spaceXSM),
          child: Text(text,
              style: TextStyle(
                  fontSize: textXSM,
                  fontWeight: FontWeight.w500,
                  color: whiteColor)));
    } else if (type == 'no_data') {
      return Container(
          margin: EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: TextStyle(
                  fontSize: textSM,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(255, 92, 92, 92))));
    } else {
      return const Text("Default Title");
    }
  }
}
