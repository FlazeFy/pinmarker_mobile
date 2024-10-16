import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/list/detail/index.dart';
import 'package:pinmarker/pages/list/usecases/search_list.dart';
import 'package:pinmarker/services/modules/global/models.dart';
import 'package:pinmarker/services/modules/global/queries.dart';

class GetGlobalSearch extends StatefulWidget {
  const GetGlobalSearch({super.key});
  @override
  StateGetGlobalSearch createState() => StateGetGlobalSearch();
}

class StateGetGlobalSearch extends State<GetGlobalSearch> {
  QueriesGlobalListServices? apiService;
  final box = GetStorage();
  late String _searchKey = "";

  @override
  void initState() {
    super.initState();
    apiService = QueriesGlobalListServices();
  }

  void refreshSearch(String val) {
    setState(() {
      _searchKey = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (box.hasData('search_key')) {
      _searchKey = box.read('search_key');
    }
    if (_searchKey.trim() != "") {
      return SafeArea(
        maintainBottomViewPadding: false,
        child: FutureBuilder<List<GlobalListSearchModel>>(
          future: apiService?.getAllGlobalSearch(_searchKey),
          builder: (BuildContext context,
              AsyncSnapshot<List<GlobalListSearchModel>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<GlobalListSearchModel>? contents = snapshot.data;
              if (contents == null || contents.isEmpty) {
                return Column(children: [
                  SearchList(refreshSearch: refreshSearch),
                  const Center(child: Text('No data available.'))
                ]);
              }
              return _buildContent(contents);
            } else {
              return Column(children: [
                SearchList(refreshSearch: refreshSearch),
                const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              ]);
            }
          },
        ),
      );
    } else {
      return Column(children: [
        SearchList(refreshSearch: refreshSearch),
        const Center(child: Text('No data available.'))
      ]);
    }
  }

  Widget _buildContent(List<GlobalListSearchModel> data) {
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchList(refreshSearch: refreshSearch),
          Column(
              children: data.map<Widget>((dt) {
            return Container(
              padding: EdgeInsets.all(spaceMD),
              margin: EdgeInsets.only(bottom: spaceSM),
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
                      InkWell(
                          onTap: () {
                            Get.to(() => DetailListPage(id: dt.id));
                          },
                          child: ComponentButtonPrimary(
                            text: "See Detail",
                            icon: FaIcon(
                              size: iconMD,
                              FontAwesomeIcons.circleInfo,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        width: spaceSM,
                      ),
                      ComponentButtonPrimary(
                        text: "Share",
                        icon: FaIcon(
                          size: iconMD,
                          FontAwesomeIcons.paperPlane,
                          color: Colors.white,
                        ),
                      ),
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
