import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/usecases/get_list_marker.dart';

class MapsListViewPage extends StatefulWidget {
  const MapsListViewPage({super.key});

  @override
  StateMapsListViewPage createState() => StateMapsListViewPage();
}

class StateMapsListViewPage extends State<MapsListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text('My Marker', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Back to Maps',
            onPressed: () {
              Get.to(const BottomBar());
            },
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: const <Widget>[GetListMarker()],
      ),
    );
  }
}
