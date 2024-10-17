import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/history/index.dart';
import 'package:pinmarker/pages/trackvisit/related_pin/index.dart';
import 'package:pinmarker/pages/trackvisit/track_history/index.dart';
import 'package:pinmarker/pages/trackvisit/track_map/index.dart';
import 'package:pinmarker/pages/trackvisit/visit/index.dart';

class TrackVisit extends StatefulWidget {
  const TrackVisit({super.key});

  @override
  StateTrackVisit createState() => StateTrackVisit();
}

class StateTrackVisit extends State<TrackVisit> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            padding: EdgeInsets.only(top: Get.height * 0.05),
            tabs: const <Widget>[
              Tab(
                icon: FaIcon(
                  FontAwesomeIcons.satelliteDish,
                  color: primaryColor,
                ),
                text: "Tracker",
              ),
              Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.car,
                    color: primaryColor,
                  ),
                  text: "Visit"),
              Tab(
                icon: FaIcon(
                  FontAwesomeIcons.clockRotateLeft,
                  color: primaryColor,
                ),
                text: "History",
              ),
            ],
          ),
          body: const TabBarView(
            children: <Widget>[TrackMapPage(), VisitPage(), HistoryPage()],
          ),
          drawer: const LeftBar(),
          floatingActionButton: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'related_pin_track',
                  onPressed: () {
                    Get.to(const RelatedPinTrackPage());
                  },
                  backgroundColor: primaryColor,
                  child: const FaIcon(
                    FontAwesomeIcons.table,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: spaceMD),
                FloatingActionButton(
                  heroTag: 'track_history',
                  onPressed: () {
                    Get.to(const TrackHistoryPage());
                  },
                  backgroundColor: primaryColor,
                  child: const FaIcon(
                    FontAwesomeIcons.rotateLeft,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: spaceSM),
              ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ));
  }
}
