import 'package:flutter/material.dart';
import 'package:pinmarker/pages/maps/usecases/get_maps_board.dart';

class MapsPage extends StatefulWidget {
  @override
  StateMapsPage createState() => StateMapsPage();
}

class StateMapsPage extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetMapsBoard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
