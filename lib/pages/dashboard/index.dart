import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/dashboard/stats/index.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_current_coor.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_dashboard.dart';

class DashboardPage extends StatefulWidget {
  @override
  StateDashboardPage createState() => StateDashboardPage();
}

class StateDashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: Get.height * 0.05, left: spaceMD, right: spaceMD),
        children: <Widget>[
          GetCurrentCoor(),
          const GetDashboard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => DashboardStatsPage());
        },
        child: const Icon(
          Icons.pie_chart,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
