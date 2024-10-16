import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/general/validator.dart';
import 'package:pinmarker/services/modules/track/models.dart';
import 'package:pinmarker/services/modules/track/queries.dart';

class GetMapsTrackBoard extends StatefulWidget {
  const GetMapsTrackBoard({super.key});

  @override
  StateGetMapsTrackBoard createState() => StateGetMapsTrackBoard();
}

class StateGetMapsTrackBoard extends State<GetMapsTrackBoard> {
  GoogleMapController? googleMapController;
  Position? position;
  String mylong = "", mylat = "";
  QueriesTrackServices? apiService;

  @override
  void initState() {
    checkGps(getLocation());
    super.initState();
    googleMapController;
    apiService = QueriesTrackServices();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    mylong = position!.longitude.toString();
    mylat = position!.latitude.toString();

    if (!mounted) return;
    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTrackJourney(),
        builder: (BuildContext context,
            AsyncSnapshot<List<LastTrackModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<LastTrackModel>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<LastTrackModel>? data) {
    //Maps starting point.
    const initialCameraPosition = CameraPosition(
      target: LatLng(-6.226838579766097, 106.82157923228753),
      zoom: 16,
    );
    int i = 0;

    return SizedBox(
      width: Get.width,
      height: Get.height - 210,
      child: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) => googleMapController = controller,
        markers: data?.map((dt) {
              i++;
              return Marker(
                markerId: MarkerId(i.toString()),
                onTap: () {
                  Get.dialog(AlertDialog(
                    title: ComponentTextTitle(
                        text: "Type : ${dt.trackType}", type: 'content_title'),
                    content: SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ComponentTextTitle(
                              type: 'content_body',
                              text: "Battery Status : ${dt.batteryIndicator}%"),
                          ComponentTextTitle(
                              type: 'content_body',
                              text: "Track At : ${dt.createdAt}"),
                        ],
                      ),
                    ),
                  ));
                },
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                position: LatLng(dt.trackLat, dt.trackLong),
              );
            }).toSet() ??
            {},
      ),
    );
  }
}
