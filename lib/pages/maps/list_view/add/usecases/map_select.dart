import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinmarker/helpers/general/validator.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class MapsSelect extends StatefulWidget {
  const MapsSelect(
      {super.key, required this.pinLatCtrl, required this.pinLongCtrl});
  final TextEditingController pinLatCtrl;
  final TextEditingController pinLongCtrl;

  @override
  StateMapsSelect createState() => StateMapsSelect();
}

class StateMapsSelect extends State<MapsSelect> {
  GoogleMapController? googleMapController;
  Position? position;
  String mylong = "", mylat = "";
  Marker? _coordinate;

  @override
  void initState() {
    checkGps(getLocation());
    super.initState();
    googleMapController;
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
    //Maps starting point.
    const initialCameraPosition = CameraPosition(
      target: LatLng(-6.226838579766097, 106.82157923228753),
      zoom: 16,
    );

    return Container(
      width: Get.width,
      height: Get.height / 2,
      padding: EdgeInsets.all(spaceMini),
      margin: EdgeInsets.only(bottom: spaceMD),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(roundedMD)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(roundedMD)),
        child: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) => googleMapController = controller,
          markers: _coordinate != null ? {_coordinate!} : {},
          onTap: ((LatLng pos) async {
            setState(() {
              _coordinate = Marker(
                markerId: const MarkerId('origin'),
                infoWindow: InfoWindow(title: 'Selected Location'.tr),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                position: pos,
              );
              widget.pinLatCtrl.text = pos.latitude.toString();
              widget.pinLongCtrl.text = pos.longitude.toString();
            });
          }),
        ),
      ),
    );
  }
}
