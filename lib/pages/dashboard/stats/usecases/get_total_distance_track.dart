import 'package:flutter/material.dart';
import 'package:pinmarker/components/charts/line_chart.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/stats/models.dart';
import 'package:pinmarker/services/modules/stats/queries_stats.dart';

class GetTotalDistanceTrack extends StatefulWidget {
  const GetTotalDistanceTrack({super.key});

  @override
  State<GetTotalDistanceTrack> createState() => _GetTotalDistanceTrackState();
}

class _GetTotalDistanceTrackState extends State<GetTotalDistanceTrack> {
  List<PieData> chartData = [];
  QueriesStatsServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesStatsServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTotalDistanceTrack(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];
            List months = [
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December'
            ];
            chartData.clear();

            int idx = 0;
            for (var mon in months) {
              dynamic total = 0;
              for (var dt in contents) {
                if (dt.ctx == idx.toString()) {
                  total = dt.total;
                }
              }
              idx++;

              PieData pieData = PieData(mon.toString(), total);
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
    return Container(
        margin: EdgeInsets.all(spaceSM),
        child: getLineChart(chartData, 'Total Distance Track Yearly', 'km'));
  }
}
