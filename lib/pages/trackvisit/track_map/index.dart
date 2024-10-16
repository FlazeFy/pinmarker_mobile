import 'package:flutter/material.dart';
import 'package:pinmarker/pages/trackvisit/track_map/usecases/get_maps_track_board.dart';

class TrackMapPage extends StatefulWidget {
  const TrackMapPage({super.key});
  @override
  StateTrackMapPage createState() => StateTrackMapPage();
}

class StateTrackMapPage extends State<TrackMapPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[GetMapsTrackBoard()],
    );
  }
}
