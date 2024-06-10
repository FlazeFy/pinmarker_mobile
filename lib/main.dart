import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
