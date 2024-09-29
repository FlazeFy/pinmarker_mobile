import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinmarker/helpers/general/validator.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetMapsBoard extends StatefulWidget {
  const GetMapsBoard({super.key});

  @override
  StateGetMapsBoard createState() => StateGetMapsBoard();
}

class StateGetMapsBoard extends State<GetMapsBoard> {
  GoogleMapController? googleMapController;
  Position? position;
  String mylong = "", mylat = "";
  QueriesPinServices? apiService;

  @override
  void initState() {
    checkGps(getLocation());
    super.initState();
    googleMapController;
    apiService = QueriesPinServices();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    mylong = position!.longitude.toString();
    mylat = position!.latitude.toString();

    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getAllPinHeader(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PinModelHeader>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<PinModelHeader>? contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PinModelHeader>? dt) {
    //Maps starting point.
    const initialCameraPosition = CameraPosition(
      target: LatLng(-6.226838579766097, 106.82157923228753),
      zoom: 16,
    );

    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) => googleMapController = controller,
        markers: dt?.map((pin) {
              final coordinates = pin.pinCoordinate.split(',');
              final lat = double.parse(coordinates[0]);
              final lng = double.parse(coordinates[1]);

              return Marker(
                markerId: MarkerId(pin.pinName),
                infoWindow:
                    InfoWindow(title: pin.pinName, snippet: pin.pinDesc),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                position: LatLng(lat, lng),
              );
            }).toSet() ??
            {},
      ),
    );
  }
}
