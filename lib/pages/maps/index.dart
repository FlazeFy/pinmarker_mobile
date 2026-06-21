import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
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

class _CircleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final double size;

  const _CircleButton({
    required this.color,
    required this.onTap,
    required this.child,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}