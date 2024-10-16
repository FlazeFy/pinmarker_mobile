import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/stats/models.dart';
import 'package:pinmarker/services/modules/stats/queries_stats.dart';

class GetDashboard extends StatefulWidget {
  const GetDashboard({super.key});

  @override
  StateGetDashboard createState() => StateGetDashboard();
}

class StateGetDashboard extends State<GetDashboard> {
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
      child: FutureBuilder<DashboardModel?>(
        future: apiService?.getDashboard(),
        builder:
            (BuildContext context, AsyncSnapshot<DashboardModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            DashboardModel? content = snapshot.data;
            if (content != null) {
              return _buildContent(content);
            } else {
              return const Center(
                child: Text("No data available"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildContent(DashboardModel dt) {
    getDashStatsBox(String val, String title) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(val,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: textXLG)),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500))
        ],
      );
    }

    return Container(
        padding: EdgeInsets.all(spaceMD),
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(roundedSM))),
        child: Column(
          children: [
            Text('Summary',
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: textXLG)),
            SizedBox(height: spaceMD),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getDashStatsBox(dt.totalMarker.toString(), 'Total Marker'),
                const Spacer(),
                getDashStatsBox(dt.totalFavorite.toString(), 'Total Favorite')
              ],
            ),
            SizedBox(height: spaceSM),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getDashStatsBox(dt.lastVisit, 'Last Visit'),
                const Spacer(),
                getDashStatsBox(dt.mostVisit, 'Most Visit'),
              ],
            ),
            SizedBox(height: spaceSM),
            getDashStatsBox(dt.mostCategory, 'Most Category'),
            SizedBox(height: spaceSM),
            getDashStatsBox(dt.lastAdded, 'Last Added'),
          ],
        ));
  }
}
