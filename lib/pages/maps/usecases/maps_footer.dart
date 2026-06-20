import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class MapsFooter extends StatefulWidget {
  const MapsFooter({super.key});

  @override
  StateMapsFooter createState() => StateMapsFooter();
}

class StateMapsFooter extends State<MapsFooter> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        top: false,
        child: Container(
          margin: EdgeInsets.fromLTRB(spaceMD, 0, spaceMD, spaceMD),
          padding: EdgeInsets.symmetric(horizontal: spaceXMD, vertical: spaceSM),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(FontAwesomeIcons.wifi,
                  color: successBG, size: textXLG),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('TIME',
                      style: TextStyle(
                          fontSize: textXSM,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1)),
                  Text('7:22 PM',
                      style: TextStyle(
                        color: Colors.grey[700],
                          fontSize: textXMD, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(roundedXLG)),
                  padding: EdgeInsets.symmetric(
                      horizontal: spaceXLG, vertical: spaceMD),
                  elevation: 0,
                ),
                child: Text('Start',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: textXMD)),
              ),
              GestureDetector(
                onTap: () {},
                child: FaIcon(FontAwesomeIcons.locationCrosshairs,
                    color: Colors.grey[700], size: textXLG),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: dangerBG,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.xmark,
                        color: whiteColor, size: textXMD),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}