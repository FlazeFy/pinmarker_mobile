import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
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
      drawer: const LeftBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const MapsListViewPage());
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.list,
          color: whiteColor,
        ),
      ),
    );
  }
}
