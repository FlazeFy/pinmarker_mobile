import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/track_history/index.dart';
import 'package:pinmarker/services/modules/track/command.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:pinmarker/services/sqlite/helper.dart';

class PostSycnTrack extends StatefulWidget {
  const PostSycnTrack({super.key});

  @override
  StatePostSycnTrack createState() => StatePostSycnTrack();
}

class StatePostSycnTrack extends State<PostSycnTrack> {
  late TrackCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = TrackCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      tooltip: 'Sync All',
      onPressed: () {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                showCancelBtn: true,
                cancelButtonColor: dangerBG,
                type: ArtSweetAlertType.warning,
                confirmButtonColor: successBG,
                onConfirm: () async {
                  try {
                    final dbHelper = DatabaseHelper();
                    final List<Map<String, dynamic>> unsyncedTracks =
                        await dbHelper.getReadySaveTracker();

                    if (unsyncedTracks.isEmpty) return;

                    List<AddTrackModelGin> dataList = unsyncedTracks.map((row) {
                      final dt = DateTime.parse(row['created_at']).toLocal();
                      final offset = dt.timeZoneOffset;
                      final offsetStr =
                          '${offset.isNegative ? '-' : '+'}${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes.abs() % 60).toString().padLeft(2, '0')}';
                      final createdAtFormatted =
                          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").format(dt) +
                              offsetStr;

                      return AddTrackModelGin(
                        trackLat: row['track_lat'].toString(),
                        trackLong: row['track_long'].toString(),
                        trackType: row['track_type'],
                        batteryIndicator: row['battery_indicator'],
                        createdAt: createdAtFormatted,
                        userId: "fcd3f23e-e5aa-11ee-892a-3216422910e9",
                      );
                    }).toList();

                    List<Map<String, dynamic>> jsonList =
                        dataList.map((e) => e.toJson()).toList();

                    var response = await apiCommand.postTrack(jsonList);

                    if (response['code'] == 201) {
                      for (var row in unsyncedTracks) {
                        await dbHelper.updateTrackerSyncStatus(row['id'], true);
                      }
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TrackHistoryPage()));
                      });
                    } else {
                      var msg = response['message'] ?? 'Unknown error';
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.danger,
                            title: "Failed",
                            text: msg),
                      );
                    }
                  } catch (err) {
                    if (mounted) {
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.danger,
                            title: "Failed!",
                            text: err.toString()),
                      );
                    }
                  }
                },
                confirmButtonText: "Yes, sync it!",
                title: "Are you sure?",
                text: "Want to sync all tracks?"));
      },
      color: whiteColor,
    );
  }
}
