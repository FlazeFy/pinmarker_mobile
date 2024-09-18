import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries_stats.dart';

class GetListMarker extends StatefulWidget {
  const GetListMarker({super.key});

  @override
  StateGetListMarker createState() => StateGetListMarker();
}

class StateGetListMarker extends State<GetListMarker> {
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
        future: apiService?.getAllPinHeader(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PinModelHeader>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<PinModelHeader>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PinModelHeader>? data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data != null && data.isNotEmpty
              ? Column(
                  children: data.map<Widget>((dt) {
                  return Container(
                    padding: EdgeInsets.all(spaceMD),
                    width: Get.width,
                    margin: EdgeInsets.only(bottom: spaceMD),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.circular(roundedSM)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ComponentTextTitle(
                                text: dt.pinName, type: "content_title"),
                          ],
                        ),
                        ComponentButtonPrimary(
                          text: dt.pinCategory,
                        ),
                        SizedBox(
                          height: spaceMD,
                        ),
                        dt.pinDesc != null && dt.pinDesc != ''
                            ? ComponentTextTitle(
                                text: dt.pinDesc ?? '-', type: "content_body")
                            : const ComponentTextTitle(
                                text: '- No Description Provided -',
                                type: "no_data"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const ComponentTextTitle(
                                    text: "Person In Touch",
                                    type: "content_sub_title"),
                                ComponentTextTitle(
                                    text: dt.pinPerson != ''
                                        ? dt.pinPerson ?? '-'
                                        : '-',
                                    type: "content_body"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const ComponentTextTitle(
                                      text: "Total Visit",
                                      type: "content_sub_title"),
                                  ComponentTextTitle(
                                      text: dt.totalVisit.toString(),
                                      type: "content_body"),
                                ])
                          ],
                        ),
                        const ComponentTextTitle(
                            text: "Last Visit", type: "content_sub_title"),
                        ComponentTextTitle(
                            text:
                                dt.lastVisit != '' ? dt.lastVisit ?? '-' : '-',
                            type: "content_body"),
                        SizedBox(
                          height: spaceMD,
                        ),
                        Row(
                          children: [
                            const ComponentButtonPrimary(text: "See Detail"),
                            SizedBox(width: spaceSM),
                            const ComponentButtonPrimary(text: "Set Direction")
                          ],
                        )
                      ],
                    ),
                  );
                }).toList())
              : const ComponentTextTitle(
                  text: "No Pin Found", type: "content_sub_title")
        ],
      ),
    );
  }
}
