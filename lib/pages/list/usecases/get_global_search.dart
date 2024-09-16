import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/global/models.dart';
import 'package:pinmarker/services/modules/global/queries.dart';

class GetGlobalSearch extends StatefulWidget {
  const GetGlobalSearch({super.key});
  @override
  StateGetGlobalSearch createState() => StateGetGlobalSearch();
}

class StateGetGlobalSearch extends State<GetGlobalSearch> {
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
      child: FutureBuilder<List<GlobalListSearchModel>>(
        future: apiService?.getAllGlobalSearch("jakarta"),
        builder: (BuildContext context,
            AsyncSnapshot<List<GlobalListSearchModel>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<GlobalListSearchModel>? contents = snapshot.data;
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

  Widget _buildContent(List<GlobalListSearchModel> data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ComponentTextTitle(
              text: "Search result : jakarta", type: "section_title"),
          Column(
              children: data.map<Widget>((dt) {
            return Container(
              padding: EdgeInsets.all(spaceMD),
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(roundedSM)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComponentTextTitle(text: dt.listName, type: "content_title"),
                  ComponentTextTitle(text: dt.listDesc, type: "content_body"),
                  const ComponentTextTitle(
                      text: "List Marker", type: "content_sub_title"),
                  ComponentTextTitle(text: dt.pinList, type: "content_body"),
                  const ComponentTextTitle(
                      text: "Created At", type: "content_sub_title"),
                  Row(
                    children: [
                      ComponentTextTitle(
                          text: "${dt.createdAt} by", type: "content_body"),
                      SizedBox(
                        width: spaceSM,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: spaceMini, horizontal: spaceXSM),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 215, 215, 215),
                          borderRadius:
                              BorderRadius.all(Radius.circular(roundedSM)),
                        ),
                        child: ComponentTextTitle(
                            text: "@${dt.createdBy}",
                            type: "content_sub_title"),
                      )
                    ],
                  ),
                  SizedBox(height: spaceSM),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: spaceMini, horizontal: spaceXSM),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(roundedSM)),
                        ),
                        child: const Text("See Detail",
                            style: const TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        width: spaceSM,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: spaceMini, horizontal: spaceXSM),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(roundedSM)),
                        ),
                        child: const Text("Share",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList())
        ],
      ),
    );
  }
}
