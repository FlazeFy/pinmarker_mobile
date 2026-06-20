import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';

import '../../../components/button/maps_circle_button.dart';

class MapsToolbar extends StatefulWidget {
  const MapsToolbar({super.key});

  @override
  StateMapsToolbar createState() => StateMapsToolbar();
}

class StateMapsToolbar extends State<MapsToolbar> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceXSM),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: spaceMD, vertical: spaceSM),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(roundedSM),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Search By Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textXMD,
                      ),
                    ),
                    SizedBox(height: spaceXSM),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name...',
                        hintStyle: TextStyle(
                            color: Colors.grey[400], fontSize: textMD),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: spaceMD, vertical: spaceSM),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(roundedSM),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spaceXSM),
            Column(
              children: [
                MapsCircleButton(
                  color: primaryColor,
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: FaIcon(FontAwesomeIcons.bars,
                      color: whiteColor, size: textLG),
                ),
                SizedBox(height: spaceXXSM),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MapsCircleButton(
                      color: primaryColor,
                      onTap: () => Get.to(() => const MapsListViewPage()),
                      child: FaIcon(FontAwesomeIcons.tableCells,
                          color: whiteColor, size: textLG),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: FaIcon(FontAwesomeIcons.minus,
                              color: whiteColor, size: textMini),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}