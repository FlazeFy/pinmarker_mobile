import 'package:firebase_database/firebase_database.dart';
import 'package:pinmarker/services/modules/track/models.dart';

class CommandTrackRealtime {
  String userId = "fcd3f23e-e5aa-11ee-892a-3216422910e9";

  Future<String> addTrack(AddTrackModel dt) async {
    try {
      DatabaseReference database =
          FirebaseDatabase.instance.ref().child('track_live_$userId');
      DatabaseReference doc = database.push();
      await doc.set({
        'track_lat': dt.trackLat,
        'track_long': dt.trackLong,
        'track_type': dt.trackType,
        'battery_indicator': dt.batteryIndicator,
        'created_at': dt.createdAt,
        'created_by': userId,
      });
      return doc.key!;
    } catch (err) {
      return err.toString();
    }
  }
}
