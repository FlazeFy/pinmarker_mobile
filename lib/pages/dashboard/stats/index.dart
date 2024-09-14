import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/dashboard/stats/usecases/get_total_gallery_by_pin.dart';
import 'package:pinmarker/pages/dashboard/stats/usecases/get_total_pin_by_category.dart';
import 'package:pinmarker/pages/dashboard/stats/usecases/get_total_visit_by_category.dart';

class DashboardStatsPage extends StatefulWidget {
  const DashboardStatsPage({super.key});

  @override
  StateDashboardStatsPage createState() => StateDashboardStatsPage();
}

class StateDashboardStatsPage extends State<DashboardStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text('Statistic', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Back to Dashboard',
            onPressed: () {
              Get.to(const BottomBar());
            },
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: const <Widget>[
          GetTotalPinByCategory(),
          GetTotalVisitByCategory(),
          GetTotalGalleryByPin()
        ],
      ),
    );
  }
}
