import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

                return Container(
                  margin: EdgeInsets.only(bottom: spaceMD),
                  padding: EdgeInsets.all(spaceMD),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: spaceMini / 2.5, color: primaryColor),
                      borderRadius:
                          BorderRadius.all(Radius.circular(roundedSM))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Battery Indicator: ${tracker['battery_indicator']}%'),
                      Text(
                          'Coordinate: ${tracker['track_lat']}, ${tracker['track_long']}'),
                      Text('Record At: ${tracker['created_at']}'),
                      Text(
                          'Is Sync: ${tracker['is_sync'] == 1 ? "Yes" : "No"}'),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
