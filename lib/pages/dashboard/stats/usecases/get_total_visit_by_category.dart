import 'package:flutter/material.dart';
import 'package:pinmarker/components/charts/pie_chart.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/stats/models.dart';
import 'package:pinmarker/services/modules/stats/queries_stats.dart';

class GetTotalVisitByCategory extends StatefulWidget {
  const GetTotalVisitByCategory({super.key});

  @override
  State<GetTotalVisitByCategory> createState() =>
      _GetTotalVisitByCategoryState();
}

class _GetTotalVisitByCategoryState extends State<GetTotalVisitByCategory> {
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
        future: apiService?.getTotalVisitByCategory(),
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
    return Container(
        margin: EdgeInsets.all(spaceSM),
        child: getPieChart(chartData, 'Total Visit By Category'));
  }
}
