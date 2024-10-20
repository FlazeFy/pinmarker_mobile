import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pinmarker/components/button/button_primary.dart';
import 'package:pinmarker/components/input/form.dart';
import 'package:pinmarker/components/input/label.dart';
import 'package:pinmarker/components/others/get_dct.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/add/usecases/map_select.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getInputLabel('Maps', false),
        const MapsSelect(),
        getInputLabel('Pin Name', true),
        ComponentInput(ctrl: pinNameCtrl, type: 'text', maxLength: 75),
        getInputLabel('Pin Category', false),
        GetAllDctByType(type: 'pin_category', selected: selectedPinCat),
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
        ComponentInput(ctrl: pinDescCtrl, type: 'text', maxLength: 500),
        getInputLabel('Pin Address', false),
        ComponentInput(
          ctrl: pinAddressCtrl,
          type: 'text',
          maxLength: 500,
        ),
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
