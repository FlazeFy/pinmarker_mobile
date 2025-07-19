import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/container/container_track_history.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/sqlite/helper.dart';

class GetLastCoor extends StatefulWidget {
  const GetLastCoor({super.key});

  @override
  StateGetCurrentCoor createState() => StateGetCurrentCoor();
}

class StateGetCurrentCoor extends State<GetLastCoor> {
  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getAllLastTracker(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        final trackers = snapshot.data!;

        return SizedBox(
            height: Get.height * 0.5,
            child: ListView.builder(
              itemCount: trackers.length,
              padding: EdgeInsets.zero,
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
            ));
      },
    );
  }
}
