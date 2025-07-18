import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/input/form.dart';
import 'package:pinmarker/components/input/label.dart';
import 'package:pinmarker/components/others/get_dct.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/trackvisit/add_visit/usecases/get_all_pin_name.dart';
import 'package:pinmarker/services/modules/visit/commands.dart';
import 'package:pinmarker/services/modules/visit/models.dart';

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
  late VisitCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = VisitCommandsService();
  }

  postVisit(bool isSetDirection) {
    if (isLoadPost == false) {
      setState(() {
        isLoadPost = true;
      });
      bool isValid = true;

      // if (pinNameCtrl.text.isEmpty) {
      //   isValid = false;
      //   allMsg += 'the pin name cant be empty,';
      // }
      if (visitDescCtrl.text.isEmpty) {
        isValid = false;
        allMsg += 'the visit desc cant be empty,';
      }
      if (visitWithCtrl.text.isEmpty) {
        isValid = false;
        allMsg += 'the visit with cant be empty,';
      }

      if (isValid) {
        VisitModel data = VisitModel(
            pinId: selectedPinId,
            visitBy: selectedVisitBy,
            visitDesc: visitDescCtrl.text.trim(),
            visitWith: visitWithCtrl.text.trim(),
            createdAt: selectedVisitAt.toString(),
            createdBy: "fcd3f23e-e5aa-11ee-892a-3216422910e9");
        apiCommand.postVisit(data).then((response) {
          setState(() => {});
          Map<String, dynamic> responseData = response as Map<String, dynamic>;
          var status = responseData['code'];
          var msg = responseData['message'];

          if (status != "error" && status != 422) {
            if (!isSetDirection) {
              selectedIndexBottomBar = 3;
              Get.to(const BottomBar());
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.success,
                      title: "Success",
                      text: msg));
            } else {}
          } else {
            if (msg is! String) {
              for (var el in msg) {
                allMsg += el['message'];
              }
            } else {
              allMsg = msg;
            }
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "Failed",
                    text: allMsg));
          }
        });
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger, title: "Failed", text: allMsg));
      }

      setState(() {
        allMsg = "";
        isLoadPost = false;
      });
    }
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
              onTap: () {
                postVisit(false);
              },
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
