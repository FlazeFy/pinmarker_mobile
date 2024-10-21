import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/input/form.dart';
import 'package:pinmarker/components/input/label.dart';
import 'package:pinmarker/components/others/get_dct.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/add/usecases/map_select.dart';
import 'package:pinmarker/pages/maps/list_view/detail/index.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';
import 'package:pinmarker/services/modules/pin/models.dart';

class PostPin extends StatefulWidget {
  const PostPin({super.key});

  @override
  StatePostPin createState() => StatePostPin();
}

class StatePostPin extends State<PostPin> {
  TextEditingController pinNameCtrl = TextEditingController();
  TextEditingController pinLatCtrl = TextEditingController();
  TextEditingController pinLongCtrl = TextEditingController();
  TextEditingController pinDescCtrl = TextEditingController();
  TextEditingController pinAddressCtrl = TextEditingController();
  TextEditingController pinPersonCtrl = TextEditingController();
  TextEditingController pinCallCtrl = TextEditingController();
  TextEditingController pinEmailCtrl = TextEditingController();
  bool isFavorite = false;
  String selectedPinCat = '-';
  bool isLoadPost = false;
  String allMsg = "";
  late PinCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = PinCommandsService();
  }

  postPin(bool isSetDirection) {
    if (isLoadPost == false) {
      setState(() {
        isLoadPost = true;
      });
      bool isValid = true;

      if (pinNameCtrl.text.isEmpty) {
        isValid = false;
        allMsg += 'the pin name cant be empty,';
      }
      if (pinLatCtrl.text.isEmpty) {
        isValid = false;
        allMsg += 'the pin latitude cant be empty,';
      }
      if (pinLongCtrl.text.isEmpty) {
        isValid = false;
        allMsg += 'the pin longitude cant be empty,';
      }
      if (selectedPinCat == '-') {
        isValid = false;
        allMsg += 'the pin category cant be empty,';
      }

      if (isValid) {
        PinModel data = PinModel(
            pinName: pinNameCtrl.text.trim(),
            pinCategory: selectedPinCat,
            pinDesc: pinDescCtrl.text.trim(),
            pinLat: pinLatCtrl.text.trim(),
            pinLong: pinLongCtrl.text.trim(),
            pinAddress: pinAddressCtrl.text.trim(),
            pinCall: pinCallCtrl.text.trim(),
            pinEmail: pinEmailCtrl.text.trim(),
            pinPerson: pinPersonCtrl.text.trim(),
            createdBy: "fcd3f23e-e5aa-11ee-892a-3216422910e9",
            isFavorite: isFavorite ? 1 : 0);
        apiCommand.postPin(data).then((response) {
          setState(() => {});
          Map<String, dynamic> responseData = response as Map<String, dynamic>;
          var status = responseData['code'];
          var msg = responseData['message'];

          if (status != "error" && status != 422) {
            if (!isSetDirection) {
              var res = responseData['data'];
              Get.to(DetailPinPage(id: res['id'], isFavorite: isFavorite));
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
        getInputLabel('Maps', false),
        MapsSelect(pinLatCtrl: pinLatCtrl, pinLongCtrl: pinLongCtrl),
        getInputLabel('Pin Name', true),
        ComponentInput(ctrl: pinNameCtrl, type: 'text', maxLength: 75),
        getInputLabel('Pin Category', true),
        GetAllDctByType(
          type: 'pin_category',
          selected: selectedPinCat,
          action: (val) {
            selectedPinCat = val;
          },
        ),
        SizedBox(height: spaceSM),
        Row(
          children: [
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel('Pin Lat', true),
                    ComponentInput(
                        ctrl: pinLatCtrl, type: 'text', maxLength: 144),
                  ],
                )),
            const Spacer(),
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel('Pin Long', true),
                    ComponentInput(
                        ctrl: pinLongCtrl, type: 'text', maxLength: 144),
                  ],
                ))
          ],
        ),
        getInputLabel('Pin Desc', false),
        ComponentInput(
            ctrl: pinDescCtrl, type: 'text', maxLength: 500, maxLines: 5),
        getInputLabel('Pin Address', false),
        ComponentInput(
            ctrl: pinAddressCtrl, type: 'text', maxLength: 500, maxLines: 5),
        getInputLabel('Pin Person', false),
        ComponentInput(
          ctrl: pinPersonCtrl,
          type: 'text',
          maxLength: 75,
        ),
        getInputLabel('Pin Call', false),
        ComponentInput(
          ctrl: pinCallCtrl,
          type: 'text',
          maxLength: 16,
        ),
        getInputLabel('Pin Email', false),
        ComponentInput(
          ctrl: pinEmailCtrl,
          type: 'text',
          maxLength: 255,
        ),
        ComponentInput(
            ctrl: isFavorite,
            type: 'checkbox',
            hinttext: 'Add To My Favorite',
            action: (val) {
              isFavorite = val!;
            }),
        SizedBox(height: spaceLG),
        Row(
          children: [
            InkWell(
              onTap: () {
                postPin(true);
              },
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
                postPin(false);
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
