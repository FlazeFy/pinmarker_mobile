import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/pages/maps/usecases/maps_board.dart';
import 'package:pinmarker/pages/maps/usecases/maps_footer.dart';
import 'package:pinmarker/pages/maps/usecases/maps_toolbar.dart';
import 'package:pinmarker/pages/maps/usecases/maps_weather.dart';
import 'package:pinmarker/services/controllers/maps_controller.dart';

import '../../components/button/maps_zoom_button.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  StateMapsPage createState() => StateMapsPage();
}

class StateMapsPage extends State<MapsPage> {
  final MapsController mapsController = Get.put(MapsController());
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const LeftBar(),
      body: Stack(
        children: [
          const MapsBoard(),
          MapsToolbar(),
          MapsWeather(),
          MapsFooter(),
          MapsZoomButton()
        ],
      ),
    );
  }
}