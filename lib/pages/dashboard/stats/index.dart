import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/pages/dashboard/stats/usecases/get_total_distance_track.dart';
import 'package:pinmarker/pages/dashboard/stats/usecases/get_total_distance_track_hourly.dart';
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
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const ComponentTextTitle(
                type: "content_title", text: "Statistic"),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: FaIcon(FontAwesomeIcons.satelliteDish),
                  text: "Tracker",
                ),
                Tab(
                  icon: FaIcon(FontAwesomeIcons.mapLocation),
                  text: "Pin",
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.circleInfo),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.info,
                          title: "Information!",
                          text:
                              "Statistic will refresh every ${(statsFetchRestTime / 60).ceil()} minutes after last time you access the page"));
                },
              )
            ],
          ),
          drawer: const LeftBar(),
          body: TabBarView(
            children: <Widget>[
              Center(
                  child: ListView(
                children: const [
                  GetTotalDistanceTrack(),
                  GetTotalDistanceTrackHourly()
                ],
              )),
              Center(
                  child: ListView(
                children: const [
                  GetTotalPinByCategory(),
                  GetTotalVisitByCategory(),
                  GetTotalGalleryByPin(),
                ],
              ))
            ],
          ),
        ));
  }
}
