import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/pages/maps/list_view/trash/usecases/get_list_deleted_pin.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  StateTrashPage createState() => StateTrashPage();
}

class StateTrashPage extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Trash', style: TextStyle(color: whiteColor)),
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
        children: const <Widget>[GetTrashPin()],
      ),
    );
  }
}
