import 'package:flutter/material.dart';
import 'package:pinmarker/components/charts/bar_chart.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/stats/models.dart';
import 'package:pinmarker/services/modules/stats/queries_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTotalDistanceTrackHourly extends StatefulWidget {
  const GetTotalDistanceTrackHourly({super.key});

  @override
  State<GetTotalDistanceTrackHourly> createState() =>
      _GetTotalDistanceTrackHourlyState();
}

class _GetTotalDistanceTrackHourlyState
    extends State<GetTotalDistanceTrackHourly> {
  List<PieData> chartData = [];
  QueriesStatsServices? apiService;
  String backupKey = "total-distance-track-hourly-sess";
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
        future: apiService?.getTotalDistanceTrackHourly(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];
            double getCategoryTotal(List data, int minContext, int maxContext) {
              return data
                  .where((el) =>
                      int.parse(el.ctx) >= minContext &&
                      int.parse(el.ctx) < maxContext)
                  .fold(0.0, (acc, el) => acc + el.total);
            }

            double timeCatOneTotal = getCategoryTotal(contents, 0, 4);
            double timeCatTwoTotal = getCategoryTotal(contents, 4, 8);
            double timeCatThreeTotal = getCategoryTotal(contents, 8, 12);
            double timeCatFourTotal = getCategoryTotal(contents, 12, 16);
            double timeCatFiveTotal = getCategoryTotal(contents, 16, 20);
            double timeCatSixthTotal = getCategoryTotal(contents, 20, 24);
            chartData.clear();

            chartData.add(PieData("00:00 - 03:59", timeCatOneTotal));
            chartData.add(PieData("04:00 - 07:59", timeCatTwoTotal));
            chartData.add(PieData("08:00 - 11:59", timeCatThreeTotal));
            chartData.add(PieData("12:00 - 15:59", timeCatFourTotal));
            chartData.add(PieData("16:00 - 19:59", timeCatFiveTotal));
            chartData.add(PieData("20:00 - 23:59", timeCatSixthTotal));

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
          type: 'content_title', text: 'Total Distance Track Hourly'),
      ComponentTextTitle(
          type: 'content_sub_title', text: "Last updated : ${lastHit ?? '-'}"),
      Container(
          margin: EdgeInsets.all(spaceSM),
          child: getBarChart(chartData, null, 'km'))
    ]);
  }
}
