import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/input/form.dart';
import 'package:pinmarker/components/input/label.dart';
import 'package:pinmarker/components/others/get_dct.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/add_visit/usecases/get_all_pin_name.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';

class PostVisit extends StatefulWidget {
  const PostVisit({super.key});

  @override
  StatePostVisit createState() => StatePostVisit();
}

class StatePostVisit extends State<PostVisit> {
  TextEditingController pinNameCtrl = TextEditingController();
  TextEditingController visitDescCtrl = TextEditingController();
  TextEditingController visitWithCtrl = TextEditingController();
  DateTime selectedVisitAt = DateTime.now();
  bool isFavorite = false;
  String selectedVisitBy = '-';
  String selectedPinId = '-';
  bool isLoadPost = false;
  String allMsg = "";
  late PinCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = PinCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getInputLabel('Pin Name', true),
        GetAllPinName(
            selected: selectedPinId,
            action: (val) {
              selectedPinId = val;
            }),
        SizedBox(height: spaceMD),
        getInputLabel('Visit By', true),
        GetAllDctByType(
          type: 'visit_by',
          selected: selectedVisitBy,
          action: (val) {
            selectedVisitBy = val;
          },
        ),
        SizedBox(height: spaceSM),
        Row(
          children: [
            getInputLabel('Visit At', true),
            const Spacer(),
            ComponentInput(
                ctrl: selectedVisitAt,
                type: 'datetime',
                action: (date) {
                  setState(() {
                    selectedVisitAt = date;
                  });
                }),
          ],
        ),
        getInputLabel('Visit Desc', false),
        ComponentInput(
          ctrl: visitDescCtrl,
          type: 'text',
          maxLength: 255,
          maxLines: 5,
        ),
        getInputLabel('Visit With', false),
        ComponentInput(
          ctrl: visitWithCtrl,
          type: 'text',
          maxLength: 500,
          maxLines: 5,
        ),
        SizedBox(height: spaceLG),
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: ComponentButtonPrimary(
                color: whiteColor,
                isBig: true,
                text: 'Save & Set Direction',
                icon: FaIcon(FontAwesomeIcons.locationArrow,
                    color: primaryColor, size: textLG),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: ComponentButtonPrimary(
                color: successBG,
                isBig: true,
                text: 'Save',
                icon: FaIcon(FontAwesomeIcons.floppyDisk,
                    color: whiteColor, size: textLG),
              ),
            )
          ],
        )
      ],
    );
  }
}
