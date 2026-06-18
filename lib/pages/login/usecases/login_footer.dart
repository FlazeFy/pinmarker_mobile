import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class LoginFooter extends StatefulWidget {
  const LoginFooter({super.key});

  @override
  State<LoginFooter> createState() => StateLoginFooterState();
}

class StateLoginFooterState extends State<LoginFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: spaceLG, vertical: spaceMD),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(roundedXLG),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline, size: iconMD, color: Colors.grey),
              SizedBox(width: spaceXXSM),
              Text('Help Center', style: TextStyle(fontSize: textMD, fontWeight: FontWeight.w600, color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(height: spaceXLG),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Privacy Policy', style: TextStyle(fontSize: textSM, color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spaceXXSM),
              child: Text('•', style: TextStyle(color: Colors.grey)),
            ),
            Text('Terms of Service', style: TextStyle(fontSize: textSM, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
