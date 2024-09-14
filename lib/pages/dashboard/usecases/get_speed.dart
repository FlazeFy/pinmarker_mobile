import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class GetSpeed extends StatefulWidget {
  final String? lastSpeed;
  final double? topSpeed;

  const GetSpeed({super.key, this.lastSpeed, this.topSpeed});

  @override
  StateGetCurrentCoor createState() => StateGetCurrentCoor();
}

class StateGetCurrentCoor extends State<GetSpeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(spaceMD),
        margin: EdgeInsets.only(top: spaceMD),
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
        child: Column(children: [
          const ComponentTextTitle(
              text: "Current Speed", type: "section_title"),
          Text(
            widget.lastSpeed ?? 'Updating...',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: textXJumbo),
          ),
          const ComponentTextTitle(text: "Top Speed", type: "section_title"),
          Text(
            widget.topSpeed != null
                ? '${widget.topSpeed!.toStringAsFixed(2)} Km/h'
                : 'Updating...',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: textXJumbo),
          )
        ]));
  }
}
