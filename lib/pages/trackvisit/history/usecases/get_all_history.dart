import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/history/models.dart';
import 'package:pinmarker/services/modules/history/queries.dart';

class GetAllHistory extends StatefulWidget {
  const GetAllHistory({super.key});

  @override
  StateGetAllHistory createState() => StateGetAllHistory();
}

class StateGetAllHistory extends State<GetAllHistory> {
  QueriesHistoryServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesHistoryServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getAllHistory(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HistoryModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<HistoryModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<HistoryModel>? data) {
    return SizedBox(
      width: Get.width,
      child: data != null && data.isNotEmpty
          ? Column(
              children: data.map<Widget>((dt) {
              return Container(
                width: Get.width,
                height: 75,
                padding: EdgeInsets.all(spaceSM),
                margin: EdgeInsets.only(bottom: spaceSM),
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
                    ComponentTextTitle(
                        type: 'content_sub_title',
                        text: "${dt.historyType} | ${dt.historyContext}"),
                    const Spacer(),
                    ComponentTextTitle(
                        type: 'content_body', text: dt.createdAt),
                  ],
                ),
              );
            }).toList())
          : const ComponentTextTitle(
              text: "No history found for past 30 days",
              type: "content_sub_title"),
    );
  }
}
