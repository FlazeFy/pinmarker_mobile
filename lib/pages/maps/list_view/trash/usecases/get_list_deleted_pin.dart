import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_icon.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetTrashPin extends StatefulWidget {
  const GetTrashPin({super.key});

  @override
  StateGetTrashPin createState() => StateGetTrashPin();
}

class StateGetTrashPin extends State<GetTrashPin> {
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
      child: FutureBuilder(
        future: apiService?.getTrashPin(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PinTrashModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<PinTrashModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PinTrashModel>? data) {
    return SizedBox(
      width: Get.width,
      child: data != null && data.isNotEmpty
          ? SingleChildScrollView(
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
                    1: const FixedColumnWidth(90),
                    2: const FixedColumnWidth(140),
                    3: const FixedColumnWidth(80),
                    4: const FixedColumnWidth(80),
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Total Visit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Props',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(spaceMD),
                          child: const Text(
                            'Recover',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        TableCell(
                          child: Container(
                              color: Colors.black,
                              padding: EdgeInsets.all(spaceMD),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    ),
                    ...data.map<TableRow>((dt) {
                      return TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(dt.pinName),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${dt.totalVisit} Visit"),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Created At",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textMD,
                                          fontWeight: FontWeight.bold)),
                                  Text(dt.createdAt,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textSM)),
                                  Text("Updated At",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textMD,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      dt.updatedAt != ''
                                          ? dt.updatedAt ?? '-'
                                          : '-',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textSM)),
                                  Text("Deleted At",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textMD,
                                          fontWeight: FontWeight.bold)),
                                  Text(dt.deletedAt,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: textSM))
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                              child: Container(
                                  margin: EdgeInsets.all(spaceMD),
                                  child: const ComponentButtonIcon(
                                      color: Colors.green,
                                      icon: FontAwesomeIcons.rotateLeft))),
                          TableCell(
                              child: Container(
                                  margin: EdgeInsets.all(spaceMD),
                                  child: const ComponentButtonIcon(
                                      color: Colors.red,
                                      icon: FontAwesomeIcons.trash))),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          : const ComponentTextTitle(
              text: "No Pin Found", type: "content_sub_title"),
    );
  }
}