import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/aroundme/index.dart';
import 'package:pinmarker/pages/dashboard/stats/index.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_current_coor.dart';
import 'package:pinmarker/pages/dashboard/usecases/get_dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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
        children: const <Widget>[
          GetCurrentCoor(),
          GetDashboard(),
        ],
      ),
      drawer: const LeftBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: floatingActionButtonSize,
                width: floatingActionButtonSize,
                child: FloatingActionButton(
                  heroTag: 'stats_page',
                  onPressed: () {
                    Get.to(() => const DashboardStatsPage());
                  },
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.pie_chart,
                    color: whiteColor,
                    size:
                        floatingActionButtonSize - floatingActionButtonSize / 2,
                  ),
                )),
            SizedBox(height: spaceXSM),
            SizedBox(
                height: floatingActionButtonSize,
                width: floatingActionButtonSize,
                child: FloatingActionButton(
                  heroTag: 'aroundme_page',
                  onPressed: () {
                    Get.to(() => const AroundMePage());
                  },
                  backgroundColor: primaryColor,
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: whiteColor,
                    size:
                        floatingActionButtonSize - floatingActionButtonSize / 2,
                  ),
                )),
          ]),
    );
  }
}
