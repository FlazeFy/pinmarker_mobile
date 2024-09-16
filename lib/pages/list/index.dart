import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/list/usecases/get_global_search.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  StateListPage createState() => StateListPage();
}

class StateListPage extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: EdgeInsets.only(
              top: Get.height * 0.05, left: spaceMD, right: spaceMD),
          children: const [GetGlobalSearch()]),
    );
  }
}
