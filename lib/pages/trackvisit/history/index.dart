import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/history/usecases/get_all_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  StateHistoryPage createState() => StateHistoryPage();
}

class StateHistoryPage extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(spaceMD),
      children: const <Widget>[GetAllHistory()],
    );
  }
}
