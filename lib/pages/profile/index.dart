import 'package:flutter/material.dart';
import 'package:pinmarker/components/bars/left_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  StateProfilePage createState() => StateProfilePage();
}

class StateProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftBar(),
      body: ListView(children: const []),
    );
  }
}
