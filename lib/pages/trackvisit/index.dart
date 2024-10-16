import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/text/title.dart';
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
          appBar: AppBar(
            title: const ComponentTextTitle(
                type: "content_title", text: "Last track : 5 seconds ago"),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: FaIcon(FontAwesomeIcons.satelliteDish),
                  text: "Tracker",
                ),
                Tab(icon: FaIcon(FontAwesomeIcons.car), text: "Visit"),
                Tab(
                  icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
                  text: "History",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[TrackMapPage(), VisitPage(), HistoryPage()],
          ),
          floatingActionButton: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'related_pin_track',
                  onPressed: () {
                    Get.to(const RelatedPinTrackPage());
                  },
                  backgroundColor: Colors.black,
                  child: const FaIcon(
                    FontAwesomeIcons.table,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spaceMD),
                FloatingActionButton(
                  heroTag: 'track_history',
                  onPressed: () {
                    Get.to(const TrackHistoryPage());
                  },
                  backgroundColor: Colors.black,
                  child: const FaIcon(
                    FontAwesomeIcons.rotateLeft,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spaceMD),
              ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
