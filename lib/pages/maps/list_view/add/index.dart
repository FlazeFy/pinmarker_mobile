import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/add/usecases/post_pin.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/pages/maps/list_view/trash/usecases/get_list_deleted_pin.dart';

class AddMarkerPage extends StatefulWidget {
  const AddMarkerPage({super.key});

  @override
  StateAddMarkerPage createState() => StateAddMarkerPage();
}

class StateAddMarkerPage extends State<AddMarkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Add Marker', style: TextStyle(color: whiteColor)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to List',
            onPressed: () {
              Get.to(const MapsListViewPage());
            },
            color: whiteColor,
          ),
        ],
      ),
      drawer: const LeftBar(),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: const <Widget>[PostPin()],
      ),
    );
  }
}
