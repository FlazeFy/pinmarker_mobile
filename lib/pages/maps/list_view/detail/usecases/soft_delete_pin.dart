import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';

class SoftDelPin extends StatefulWidget {
  const SoftDelPin({super.key, required this.id});
  final String id;

  @override
  StateSoftDelPin createState() => StateSoftDelPin();
}

class StateSoftDelPin extends State<SoftDelPin> {
  PinCommandsService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = PinCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  showCancelBtn: true,
                  cancelButtonColor: dangerBG,
                  type: ArtSweetAlertType.warning,
                  confirmButtonColor: successBG,
                  onConfirm: () async {
                    apiService?.softDeletePin(widget.id).then((response) {
                      setState(() => {});
                      var code = response['code'];
                      var message = response['message'];

                      if (code == 200) {
                        ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                                onConfirm: () {
                                  Get.to(() => const MapsListViewPage());
                                },
                                type: ArtSweetAlertType.success,
                                title: "Success!",
                                text: message));
                      } else {
                        ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.danger,
                                title: "Failed!",
                                text: "Something wrong happen"));
                      }
                    });
                  },
                  confirmButtonText: "Yes, delete it!",
                  title: "Are you sure?",
                  text: "Want to delete this pin?"));
        },
        icon: FaIcon(FontAwesomeIcons.solidTrashCan,
            color: dangerBG, size: textXLG));
  }
}
