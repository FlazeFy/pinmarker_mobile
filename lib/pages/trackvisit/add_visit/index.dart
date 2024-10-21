import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/add/usecases/post_pin.dart';
import 'package:pinmarker/pages/trackvisit/add_visit/usecases/post_visit.dart';

class AddVisitPage extends StatefulWidget {
  const AddVisitPage({super.key});

  @override
  StateAddVisitPage createState() => StateAddVisitPage();
}

class StateAddVisitPage extends State<AddVisitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Add Visit', style: TextStyle(color: whiteColor)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to Track & Visit',
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
        children: const <Widget>[PostVisit()],
      ),
    );
  }
}
