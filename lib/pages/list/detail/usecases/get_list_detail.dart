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
      child: FutureBuilder<GlobalListDetailModel?>(
        future: apiService?.getMyGlobalListDetail(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<GlobalListDetailModel?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return _buildListView(snapshot.data!);
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

  Widget _buildListView(GlobalListDetailModel data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComponentTextTitle(type: "content_title", text: data.listName),
          data.listTag.isNotEmpty
              ? Wrap(
                  runSpacing: -spaceWrap,
                  spacing: spaceWrap,
                  children: data.listTag.map<Widget>((tg) {
                    return ComponentButtonPrimary(text: "#${tg.tagName}");
                  }).toList(),
                )
              : const SizedBox(),
          SizedBox(
            height: spaceMD,
          ),
          data.listDesc != ''
              ? ComponentTextTitle(
                  type: "content_body", text: data.listDesc ?? '-')
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
                  ComponentTextTitle(text: data.createdAt, type: "content_body")
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
                      type: "content_body", text: data.updatedAt ?? '-')
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
                text: "@${data.createdBy}", type: "content_sub_title"),
          )
        ],
      ),
    );
  }
}
