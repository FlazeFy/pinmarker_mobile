import 'package:flutter/material.dart';
import 'package:pinmarker/components/charts/pie_chart.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/stats/models.dart';
import 'package:pinmarker/services/modules/stats/queries_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTotalGalleryByPin extends StatefulWidget {
  const GetTotalGalleryByPin({super.key});

  @override
  State<GetTotalGalleryByPin> createState() => _GetTotalGalleryByPinState();
}

class _GetTotalGalleryByPinState extends State<GetTotalGalleryByPin> {
  List<PieData> chartData = [];
  QueriesStatsServices? apiService;
  String backupKey = "total-gallery-by-pin-sess";
  String? lastHit;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    apiService = QueriesStatsServices();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastHit = prefs.getString("last-hit-$backupKey");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTotalGalleryByPin(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int total = content.total;
              PieData pieData = PieData(label, total);
              chartData.add(pieData);
            }

            return _buildListView(chartData);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PieData> contents) {
    return Column(children: [
      SizedBox(height: spaceMD),
      const ComponentTextTitle(
          type: 'content_title', text: 'Total Gallery By Pin'),
      ComponentTextTitle(
          type: 'content_sub_title', text: "Last updated : ${lastHit ?? '-'}"),
      Container(
          margin: EdgeInsets.all(spaceSM), child: getPieChart(chartData, null))
    ]);
  }
}
