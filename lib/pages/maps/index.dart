import 'package:flutter/material.dart';
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
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
      ),
    );
  }
}
