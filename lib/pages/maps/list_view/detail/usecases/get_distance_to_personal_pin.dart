import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/detail/index.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetDistanceToPersonalPin extends StatefulWidget {
  const GetDistanceToPersonalPin({super.key, required this.id});
  final String id;

  @override
  StateGetDistanceToPersonalPin createState() =>
      StateGetDistanceToPersonalPin();
}

class StateGetDistanceToPersonalPin extends State<GetDistanceToPersonalPin> {
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
        future: apiService?.getDistanceToMyPersonalPin(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<DistancePersonalModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<DistancePersonalModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<DistancePersonalModel>? data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ComponentTextTitle(
              text: "Distance to My Personal Pin", type: "content_title"),
          SizedBox(
            height: spaceMD,
          ),
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
                        SizedBox(
                          height: spaceSM,
                        ),
                        dt.pinDesc != null && dt.pinDesc != ''
                            ? ComponentTextTitle(
                                text: dt.pinDesc ?? '-', type: "content_body")
                            : const ComponentTextTitle(
                                text: '- No Description Provided -',
                                type: "no_data"),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const ComponentTextTitle(
                                    text: "Created At",
                                    type: "content_sub_title"),
                                ComponentTextTitle(
                                    text: dt.createdAt, type: "content_body"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const ComponentTextTitle(
                                    text: "Distance To",
                                    type: "content_sub_title"),
                                ComponentTextTitle(
                                    text:
                                        "${(dt.distanceToMeters / 1000).toStringAsFixed(2)} Km",
                                    type: "content_body"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.to(() => DetailPinPage(
                                        id: dt.id,
                                      ));
                                },
                                child: const ComponentButtonPrimary(
                                    text: "See Detail")),
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
