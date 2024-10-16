import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/general/converter.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:pinmarker/services/modules/track/queries.dart';

class GetTrackHistoryPeriod extends StatefulWidget {
  const GetTrackHistoryPeriod({super.key});

  @override
  StateGetTrackHistoryPeriod createState() => StateGetTrackHistoryPeriod();
}

class StateGetTrackHistoryPeriod extends State<GetTrackHistoryPeriod> {
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
      child: FutureBuilder(
        future: apiService?.getTrackHistoryPeriod(),
        builder: (BuildContext context,
            AsyncSnapshot<List<LastTrackModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<LastTrackModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<LastTrackModel>? data) {
    int i = 0;
    return SizedBox(
      width: Get.width,
      child: data != null && data.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                      borderRadius:
                          BorderRadius.all(Radius.circular(roundedMini)),
                      color: primaryColor),
                  columnWidths: {
                    0: FixedColumnWidth(Get.width * 0.3),
                    1: const FixedColumnWidth(100),
                    2: const FixedColumnWidth(100),
                    3: const FixedColumnWidth(60),
                    4: const FixedColumnWidth(60),
                    5: const FixedColumnWidth(60),
                    6: const FixedColumnWidth(40),
                    7: const FixedColumnWidth(20),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Datetime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Coordinate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Route',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Distance',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Time Taken',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Speed',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Battery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Maps',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                    ...data.map<TableRow>((dt) {
                      i++;

                      return TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(dt.createdAt,
                                  style: TextStyle(fontSize: textSM)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${dt.trackLat}, ${dt.trackLong}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: textSM)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text("From",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: textSM,
                                          fontWeight: FontWeight.w500)),
                                  Text("${dt.trackLat}, ${dt.trackLong}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textSM)),
                                  Text("To",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: textSM,
                                          fontWeight: FontWeight.w500)),
                                  i < data.length
                                      ? Text(
                                          "${data[i].trackLat}, ${data[i].trackLong}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: textSM))
                                      : Text("-",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: textSM)),
                                ])),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: i < data.length
                                  ? Text(
                                      distanceUnit(calculateDistance(
                                          "${dt.trackLat},${dt.trackLong}",
                                          "${data[i].trackLat},${data[i].trackLong}")),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textMD))
                                  : Text("-",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textSM)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: i < data.length
                                  ? Text(
                                      timeUnit(countDatetimeStrInterval(
                                          dt.createdAt, data[i].createdAt)),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textMD))
                                  : Text("-",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textSM)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: i < data.length
                                  ? Text(
                                      "${((calculateDistance("${dt.trackLat},${dt.trackLong}", "${data[i].trackLat},${data[i].trackLong}") / countDatetimeStrInterval(dt.createdAt, data[i].createdAt)) * 3.6).toStringAsFixed(2)} Km/h",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textMD))
                                  : Text("-",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: textSM)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${dt.batteryIndicator}%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: textMD)),
                            ),
                          ),
                          const TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ComponentButtonPrimary(
                                  icon: FaIcon(
                                    FontAwesomeIcons.mapLocation,
                                    color: whiteColor,
                                  ),
                                )),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          : const ComponentTextTitle(
              text: "No Track Found", type: "content_sub_title"),
    );
  }
}
