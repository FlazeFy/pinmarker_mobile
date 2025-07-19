import 'package:flutter/material.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/container/container_track_history.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/sqlite/helper.dart';

class GetTrackHistoryPeriod extends StatefulWidget {
  const GetTrackHistoryPeriod({super.key});

  @override
  StateGetTrackHistoryPeriod createState() => StateGetTrackHistoryPeriod();
}

class StateGetTrackHistoryPeriod extends State<GetTrackHistoryPeriod> {
  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getAllTracker(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        final trackers = snapshot.data!;

        return ListView.builder(
          itemCount: trackers.length,
          padding: EdgeInsets.all(spaceMD),
          itemBuilder: (context, index) {
            final tracker = trackers[index];

            return ComponentContainerTrackHistory(
              batteryIndicator: tracker['battery_indicator'],
              trackLat: tracker['track_lat'],
              trackLong: tracker['track_long'],
              createdAt: tracker['created_at'],
              isSync: tracker['is_sync'],
            );
          },
        );
      },
    );
  }
}
