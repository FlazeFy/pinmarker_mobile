import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_current_coor.dart';

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
        children: <Widget>[GetCurrentCoor()],
      ),
    );
  }
}
