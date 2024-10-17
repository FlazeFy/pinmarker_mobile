import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/trash/index.dart';
import 'package:pinmarker/pages/maps/list_view/usecases/get_list_marker.dart';

class MapsListViewPage extends StatefulWidget {
  const MapsListViewPage({super.key});

  @override
  StateMapsListViewPage createState() => StateMapsListViewPage();
}

class StateMapsListViewPage extends State<MapsListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: const Text('My Marker', style: TextStyle(color: whiteColor)),
          actions: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.solidTrashCan,
                  color: whiteColor, size: textXLG),
              tooltip: 'Trash',
              onPressed: () {
                Get.to(const TrashPage());
              },
              color: whiteColor,
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.circleInfo,
                color: whiteColor,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.info,
                        title: "Information!",
                        text:
                            "My Marker list will refresh every ${(allPinFetchRestTime / 60).ceil()} minutes after last time you access the page"));
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Back to Maps',
              onPressed: () {
                Get.to(const BottomBar());
              },
              color: whiteColor,
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(spaceMD),
          children: const <Widget>[GetListMarker()],
        ),
        drawer: const LeftBar());
  }
}
