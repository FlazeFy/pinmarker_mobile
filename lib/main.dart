import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  StateMyApp createState() => StateMyApp();
}

class StateMyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PinMarker',
      home: BottomBar(),
    );
  }
}
