import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:pinmarker/services/modules/track/queries.dart';

class GetAllRelatedPinTrack extends StatefulWidget {
  const GetAllRelatedPinTrack({super.key});

  @override
  StateGetAllRelatedPinTrack createState() => StateGetAllRelatedPinTrack();
}

class StateGetAllRelatedPinTrack extends State<GetAllRelatedPinTrack> {
  QueriesTrackServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesTrackServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: apiService?.getRelatedPinXTrackPin(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              LastTrackModel track = snapshot.data!['data_track'];
              List<RelatedPinModel> pins = snapshot.data!['data_related_pin'];
              return _buildListView(track, pins);
            } else {
              return const Center(child: Text("No data found"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(LastTrackModel track, List<RelatedPinModel> pins) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: Get.width,
              padding: EdgeInsets.all(spaceSM),
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
                    const ComponentTextTitle(
                        type: "content_title", text: "Last Track"),
                    Row(
                      children: [
                        const ComponentTextTitle(
                            type: "content_sub_title",
                            text: "Battery Indicator"),
                        const Spacer(),
                        ComponentTextTitle(
                            type: "content_body",
                            text: "${track.batteryIndicator}%")
                      ],
                    ),
                    Row(
                      children: [
                        const ComponentTextTitle(
                            type: "content_sub_title", text: "Coordinate"),
                        const Spacer(),
                        ComponentTextTitle(
                            type: "content_body",
                            text: "${track.trackLat}, ${track.trackLong}")
                      ],
                    ),
                    Row(
                      children: [
                        const ComponentTextTitle(
                            type: "content_sub_title", text: "Record At"),
                        const Spacer(),
                        ComponentTextTitle(
                            type: "content_body", text: track.createdAt)
                      ],
                    )
                  ])),
          SizedBox(
            height: spaceMD,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: Get.width * 1.3,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                    borderRadius:
                        BorderRadius.all(Radius.circular(roundedMini)),
                    color: Colors.black),
                columnWidths: {
                  0: FixedColumnWidth(Get.width * 0.3),
                  1: const FixedColumnWidth(50),
                  2: const FixedColumnWidth(140),
                  3: const FixedColumnWidth(80),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(spaceMD),
                        child: const Text(
                          'Pin Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(spaceMD),
                        child: const Text(
                          'Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(spaceMD),
                        child: const Text(
                          'Coordinate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(spaceMD),
                        child: const Text(
                          'Distance',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ],
                  ),
                  ...pins.map<TableRow>((dt) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dt.pinName,
                                style: TextStyle(fontSize: textMD)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dt.pinCat,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: textMD)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${dt.pinLat}, ${dt.pinLong}",
                                style: TextStyle(fontSize: textMD)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${dt.distance} m",
                                style: TextStyle(fontSize: textMD)),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
