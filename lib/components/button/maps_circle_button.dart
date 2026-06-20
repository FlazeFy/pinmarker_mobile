import 'dart:ui';
import 'package:flutter/material.dart';
import '../../helpers/variables/style.dart';

class MapsCircleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final double size;

  const MapsCircleButton({
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
              color: secondaryColor.withOpacity(0.2),
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