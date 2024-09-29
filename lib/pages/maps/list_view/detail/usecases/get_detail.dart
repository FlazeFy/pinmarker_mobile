import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/pages/maps/list_view/usecases/get_list_marker.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetDetailPin extends StatefulWidget {
  const GetDetailPin({super.key, required this.id});
  final String id;

  @override
  StateGetDetailPin createState() => StateGetDetailPin();
}

class StateGetDetailPin extends State<GetDetailPin> {
  QueriesPinServices? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesPinServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: apiService?.getDetailPin(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              PinDetailModel detail = snapshot.data!['detail'];
              List<VisitHistoryModel> pins = snapshot.data!['history'];
              return _buildListView(detail, pins);
            } else {
              return const Center(child: Text("No data found"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(PinDetailModel detail, List<VisitHistoryModel> pins) {
    int indexHistory = 0;
    return Container(
      padding: EdgeInsets.all(spaceMD),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                detail.pinName,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: textXLG),
              ),
              const Spacer(),
              ComponentButtonPrimary(text: detail.pinCategory)
            ],
          ),
          SizedBox(
            height: spaceXLG,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latitude",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: textLG),
                  ),
                  Text(
                    detail.pinLat,
                    style: TextStyle(fontSize: textXMD),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Longitude",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: textLG),
                  ),
                  Text(
                    detail.pinLong,
                    style: TextStyle(fontSize: textXMD),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: spaceMD,
          ),
          Text(
            "Person In Touch",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          Text(
            detail.pinPerson == '' ? '-' : detail.pinPerson ?? '-',
            style: TextStyle(fontSize: textXMD),
          ),
          SizedBox(
            height: spaceMD,
          ),
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          Text(
            detail.pinEmail == '' ? '-' : detail.pinEmail ?? '-',
            style: TextStyle(fontSize: textXMD),
          ),
          SizedBox(
            height: spaceMD,
          ),
          Text(
            "Phone Number",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          Text(
            detail.pinCall == '' ? '-' : detail.pinCall ?? '-',
            style: TextStyle(fontSize: textXMD),
          ),
          SizedBox(
            height: spaceMD,
          ),
          Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          Text(
            detail.pinAddress == '' ? '-' : detail.pinAddress ?? '-',
            style: TextStyle(fontSize: textXMD),
          ),
          SizedBox(
            height: spaceMD,
          ),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          Text(
            detail.pinDesc == ''
                ? '- No Description Provided -'
                : detail.pinDesc ?? '- No Description Provided -',
            style: TextStyle(fontSize: textXMD),
          ),
          SizedBox(
            height: spaceXLG,
          ),
          Text(
            "Visit History",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          pins.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: pins.map<Widget>((dt) {
                    indexHistory++;
                    return Text(
                        "$indexHistory. ${dt.visitDesc?.isNotEmpty == true ? "${dt.visitDesc} " : ''}using ${dt.visitBy}${dt.visitWith?.isNotEmpty == true ? " with ${dt.visitWith}" : ''}");
                  }).toList(),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
