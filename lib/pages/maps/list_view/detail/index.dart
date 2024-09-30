import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/detail/usecases/get_detail.dart';
import 'package:pinmarker/pages/maps/list_view/detail/usecases/get_total_visit_by_cat_by_pin.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';

class DetailPinPage extends StatefulWidget {
  const DetailPinPage({super.key, required this.id});
  final String id;

  @override
  StateDetailPinPage createState() => StateDetailPinPage();
}

class StateDetailPinPage extends State<DetailPinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title:
            const Text('Detail Marker', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to Marker',
            onPressed: () {
              Get.to(const MapsListViewPage());
            },
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spaceMD),
        children: <Widget>[
          GetDetailPin(
            id: widget.id,
          ),
          GetTotalVisitByCategoryByPin(id: widget.id)
        ],
      ),
    );
  }
}
