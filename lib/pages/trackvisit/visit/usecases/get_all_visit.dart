import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/visit/models.dart';
import 'package:pinmarker/services/modules/visit/queries.dart';

class GetAllVisit extends StatefulWidget {
  const GetAllVisit({super.key});

  @override
  StateGetAllVisit createState() => StateGetAllVisit();
}

class StateGetAllVisit extends State<GetAllVisit> {
  QueriesVisitServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesVisitServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getAllVisit(),
        builder:
            (BuildContext context, AsyncSnapshot<List<VisitModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<VisitModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<VisitModel>? data) {
    return SizedBox(
      width: Get.width,
      child: data != null && data.isNotEmpty
          ? Column(
              children: data.map<Widget>((dt) {
              String visitWith = "";
              if (dt.visitWith != "") {
                visitWith = " with ${dt.visitWith}";
              }

              return Container(
                width: Get.width,
                padding: EdgeInsets.all(spaceSM),
                margin: EdgeInsets.only(bottom: spaceSM),
                decoration: BoxDecoration(
                  color: whiteColor,
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
                child: ComponentTextTitle(
                    type: 'content_body',
                    text:
                        "Visit at ${dt.pinName != '' ? dt.pinName : dt.visitDesc} using ${dt.visitBy}${dt.pinName != '' ? dt.visitDesc : ''}$visitWith at ${dt.createdAt}"),
              );
            }).toList())
          : const ComponentTextTitle(
              text: "No visit found", type: "content_sub_title"),
    );
  }
}
