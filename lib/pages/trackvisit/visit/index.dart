import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/visit/usecases/get_all_visit.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({super.key});
  @override
  StateVisitPage createState() => StateVisitPage();
}

class StateVisitPage extends State<VisitPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(spaceMD),
      children: const <Widget>[GetAllVisit()],
    );
  }
}
