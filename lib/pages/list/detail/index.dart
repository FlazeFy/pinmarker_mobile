import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/list/detail/usecases/get_list_detail.dart';

class DetailListPage extends StatefulWidget {
  const DetailListPage({super.key, required this.id});

  final String id;

  @override
  StateDetailListPage createState() => StateDetailListPage();
}

class StateDetailListPage extends State<DetailListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text('Detail List', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Back to Maps',
            onPressed: () {
              Get.to(const BottomBar());
            },
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: <Widget>[GetListDetail(id: widget.id)],
      ),
    );
  }
}
