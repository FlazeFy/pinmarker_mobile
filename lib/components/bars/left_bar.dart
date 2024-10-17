import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/login/index.dart';

class LeftBar extends StatefulWidget {
  const LeftBar({key}) : super(key: key);

  @override
  LeftBarState createState() => LeftBarState();
}

class LeftBarState extends State<LeftBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text('PinMarker', style: TextStyle(color: whiteColor)),
          ),
          ListTile(
            title: const Text('My Profile'),
            selected: selectedIndexLeftBar == 0,
            onTap: () {},
          ),
          ListTile(
            title: const Text('Setting'),
            selected: selectedIndexLeftBar == 1,
            onTap: () {},
          ),
          ListTile(
            title: const Text('Help Center'),
            selected: selectedIndexLeftBar == 2,
            onTap: () {},
          ),
          ListTile(
            title: const Text('Feedback'),
            selected: selectedIndexLeftBar == 3,
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sign In'),
            selected: selectedIndexLeftBar == 4,
            onTap: () {
              Get.to(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
