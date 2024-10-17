import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/text/title.dart';
import 'package:pinmarker/helpers/general/validator.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/list/detail/index.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget _buildListView(List<PinModelHeader>? data) {
    //Maps starting point.
    const initialCameraPosition = CameraPosition(
      target: LatLng(-6.226838579766097, 106.82157923228753),
      zoom: 16,
    );

    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) => googleMapController = controller,
        markers: data?.map((dt) {
              final coordinates = dt.pinCoordinate.split(',');
              final lat = double.parse(coordinates[0]);
              final lng = double.parse(coordinates[1]);

              return Marker(
                markerId: MarkerId(dt.pinName),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                position: LatLng(lat, lng),
                onTap: () {
                  Get.dialog(AlertDialog(
                    content: SizedBox(
                      height: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ComponentTextTitle(
                                  text: dt.pinName, type: 'content_title'),
                              const Spacer(),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.circleXmark,
                                  color: primaryColor,
                                ),
                                tooltip: 'Close Detail',
                                onPressed: () {
                                  Get.back();
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              ComponentButtonPrimary(text: dt.pinCategory)
                            ],
                          ),
                          SizedBox(
                            height: spaceXMD,
                          ),
                          dt.pinDesc != ''
                              ? ComponentTextTitle(
                                  type: 'content_body', text: dt.pinDesc ?? '-')
                              : const ComponentTextTitle(
                                  text: '- No Description Provided -',
                                  type: "no_data"),
                          SizedBox(
                            height: spaceMD,
                          ),
                          const ComponentTextTitle(
                              type: 'content_sub_title',
                              text: 'Person In Touch'),
                          ComponentTextTitle(
                              type: 'content_body', text: dt.pinPerson ?? '-'),
                          SizedBox(
                            height: spaceMD,
                          ),
                          const ComponentTextTitle(
                              type: 'content_sub_title', text: 'Created At'),
                          ComponentTextTitle(
                              type: 'content_body', text: dt.createdAt),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      InkWell(
                          onTap: () {
                            Get.to(() => DetailListPage(id: dt.id));
                          },
                          child: ComponentButtonPrimary(
                            text: "See Detail",
                            icon: FaIcon(
                              size: iconMD,
                              FontAwesomeIcons.circleInfo,
                              color: whiteColor,
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "https://www.google.com/maps/dir/My+Location/${dt.pinCoordinate}"));
                          },
                          child: ComponentButtonPrimary(
                            text: "Set Direction",
                            icon: FaIcon(
                              size: iconMD,
                              FontAwesomeIcons.locationArrow,
                              color: whiteColor,
                            ),
                          ))
                    ],
                  ));
                },
              );
            }).toSet() ??
            {},
      ),
    );
  }
}
