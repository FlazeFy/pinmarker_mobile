import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/related_pin/usecases/get_all_related_pin_track.dart';

class RelatedPinTrackPage extends StatefulWidget {
  const RelatedPinTrackPage({super.key});

  @override
  StateRelatedPinTrackPage createState() => StateRelatedPinTrackPage();
}

class StateRelatedPinTrackPage extends State<RelatedPinTrackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Related Pin x Track',
            style: TextStyle(color: whiteColor)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to List',
            onPressed: () {
              selectedIndexBottomBar = 3;
              Get.to(const BottomBar());
            },
            color: whiteColor,
          ),
        ],
      ),
      drawer: const LeftBar(),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: const <Widget>[GetAllRelatedPinTrack()],
      ),
    );
  }
}
