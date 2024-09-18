import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/pages/maps/usecases/get_maps_board.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  StateMapsPage createState() => StateMapsPage();
}

class StateMapsPage extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const GetMapsBoard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const MapsListViewPage());
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
      ),
    );
  }
}
