
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helpers/variables/style.dart';

class MapsZoomButton extends StatefulWidget {
  const MapsZoomButton({super.key});

  @override
  StateMapsZoomButton createState() => StateMapsZoomButton();
}

class StateMapsZoomButton extends State<MapsZoomButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: spaceMD,
      child: Column(
        children: [
          _ZoomButton(
            icon: FontAwesomeIcons.plus,
            onTap: () {},
          ),
          Container(height: 1, width: 36, color: greyColor),
          _ZoomButton(
            icon: FontAwesomeIcons.minus,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: secondaryColor.withOpacity(0.15),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: FaIcon(icon, size: textXMD, color: secondaryColor),
        ),
      ),
    );
  }
}