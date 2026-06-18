import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/login/usecases/login_footer.dart';
import 'package:pinmarker/pages/login/usecases/login_form.dart';
import 'package:pinmarker/pages/login/usecases/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => StateLoginPageState();
}

class StateLoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(spaceLG),
        children: [
          LoginHeader(),
          SizedBox(height: spaceJumbo),
          LoginForm(),
          SizedBox(height: spaceJumbo),
          LoginFooter(),
        ],
      )
    );
  }
}
