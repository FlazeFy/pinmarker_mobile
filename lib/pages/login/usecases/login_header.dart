import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({super.key});

  @override
  State<LoginHeader> createState() => StateLoginHeaderState();
}

class StateLoginHeaderState extends State<LoginHeader> {
  static const _primary = Color(0xFF635BFF);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: spaceJumbo * 1.5),
        Text(
          'PinMarker',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: _primary,
          ),
        ),
        const Text(
          'Marks Your World',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ]
    );
  }
}
