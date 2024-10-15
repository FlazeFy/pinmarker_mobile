import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/track_history/usecases/get_track_history_period.dart';

class TrackHistoryPage extends StatefulWidget {
  const TrackHistoryPage({super.key});

  @override
  StateTrackHistoryPage createState() => StateTrackHistoryPage();
}

class StateTrackHistoryPage extends State<TrackHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title:
            const Text('Track History', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to List',
            onPressed: () {
              selectedIndex = 3;
              Get.to(const BottomBar());
            },
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: const <Widget>[GetTrackHistoryPeriod()],
      ),
    );
  }
}
