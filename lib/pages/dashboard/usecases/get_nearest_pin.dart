import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetNearestPin extends StatefulWidget {
  const GetNearestPin({super.key, required this.lat, required this.long});

  final String lat;
  final String long;

  @override
  StateGetNearestPin createState() => StateGetNearestPin();
}

class StateGetNearestPin extends State<GetNearestPin> {
  QueriesPinServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesPinServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder<List<PinModelNearestHeader>>(
        future: apiService?.getAllNearestPinHeader(widget.lat, widget.long),
        builder: (BuildContext context,
            AsyncSnapshot<List<PinModelNearestHeader>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<PinModelNearestHeader>? contents = snapshot.data;
            if (contents == null || contents.isEmpty) {
              return Container(
                  padding: EdgeInsets.all(spaceMD),
                  margin: EdgeInsets.only(top: spaceMD),
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
                  ),
                  child: const Center(
                    child: Text("No pin found in radius 3 Km"),
                  ));
            }
            return _buildContent(contents);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }

  Widget _buildContent(List<PinModelNearestHeader> data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      margin: EdgeInsets.only(top: spaceMD),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ComponentTextTitle(text: "Nearest Pin", type: "section_title"),
          Column(
              children: data.map<Widget>((dt) {
            return Container(
              width: Get.width,
              padding: EdgeInsets.all(spaceSM),
              margin: EdgeInsets.only(bottom: spaceSM),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(roundedMD)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.35),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ComponentTextTitle(
                          type: 'content_sub_title', text: dt.pinName),
                      const Spacer(),
                      ComponentTextTitle(
                          type: 'content_tag', text: dt.pinCategory),
                    ],
                  ),
                  ComponentTextTitle(
                      type: 'content_body',
                      text:
                          "The distance about ${dt.distance.toStringAsFixed(2)} m")
                ],
              ),
            );
          }).toList())
        ],
      ),
    );
  }
}
