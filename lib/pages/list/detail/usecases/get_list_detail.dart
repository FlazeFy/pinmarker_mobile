import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/global/models.dart';
import 'package:pinmarker/services/modules/global/queries.dart';

class GetListDetail extends StatefulWidget {
  const GetListDetail({super.key, required this.id});

  final String id;

  @override
  StateGetListDetail createState() => StateGetListDetail();
}

class StateGetListDetail extends State<GetListDetail> {
  QueriesGlobalListServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesGlobalListServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: apiService?.getMyGlobalListDetail(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              GlobalListDetailModel detail = snapshot.data!['detail'];
              List<GlobalListRelPinModel> pins = snapshot.data!['data'];
              return _buildListView(detail, pins);
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

  Widget _buildListView(
      GlobalListDetailModel detail, List<GlobalListRelPinModel> pins) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComponentTextTitle(type: "section_title", text: detail.listName),
          detail.listTag.isNotEmpty
              ? Wrap(
                  runSpacing: -spaceWrap,
                  spacing: spaceWrap,
                  children: detail.listTag.map<Widget>((tg) {
                    return ComponentButtonPrimary(text: "#${tg.tagName}");
                  }).toList(),
                )
              : const SizedBox(),
          SizedBox(
            height: spaceMD,
          ),
          detail.listDesc != ''
              ? ComponentTextTitle(
                  type: "content_body", text: detail.listDesc ?? '-')
              : const ComponentTextTitle(
                  text: '- No Description Provided -', type: "no_data"),
          SizedBox(
            height: spaceMD,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ComponentTextTitle(
                      type: "content_sub_title", text: "Created At"),
                  ComponentTextTitle(
                      text: detail.createdAt, type: "content_body")
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ComponentTextTitle(
                      type: "content_sub_title", text: "Updated At"),
                  ComponentTextTitle(
                      type: "content_body", text: detail.updatedAt ?? '-')
                ],
              )
            ],
          ),
          const ComponentTextTitle(
              type: "content_sub_title", text: "Created By"),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: spaceMini, horizontal: spaceXSM),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 215, 215),
              borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
            ),
            child: ComponentTextTitle(
                text: "@${detail.createdBy}", type: "content_sub_title"),
          ),
          SizedBox(
            height: spaceMD,
          ),
          const ComponentTextTitle(text: "List Marker", type: "content_title"),
          detail.listTag.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: pins.map<Widget>((dt) {
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
                          const ComponentTextTitle(
                              text: "Added At", type: "content_sub_title"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ComponentTextTitle(
                                  text: "${dt.createdAt} by",
                                  type: "content_body"),
                              SizedBox(
                                width: spaceSM,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: spaceMini, horizontal: spaceXSM),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 215, 215, 215),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(roundedSM)),
                                ),
                                child: ComponentTextTitle(
                                    text: "@${dt.createdBy}",
                                    type: "content_sub_title"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: spaceMD,
                          ),
                          Row(
                            children: [
                              const ComponentButtonPrimary(
                                  text: "Save to My Pin"),
                              SizedBox(width: spaceXSM),
                              const ComponentButtonPrimary(text: "Remove"),
                              SizedBox(width: spaceXSM),
                              const ComponentButtonPrimary(
                                  text: "Set Direction")
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
