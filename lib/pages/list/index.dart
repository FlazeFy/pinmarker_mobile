import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  StateListPage createState() => StateListPage();
}

class StateListPage extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: const []),
    );
  }
}
