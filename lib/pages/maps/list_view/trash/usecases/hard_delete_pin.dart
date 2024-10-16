import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_icon.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';

class HardDeletePin extends StatefulWidget {
  const HardDeletePin({super.key, required this.id});
  final String id;

  @override
  StateHardDeletePin createState() => StateHardDeletePin();
}

class StateHardDeletePin extends State<HardDeletePin> {
  PinCommandsService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = PinCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(spaceMD),
        child: ComponentButtonIcon(
            color: dangerBG,
            icon: FontAwesomeIcons.trash,
            func: () {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      showCancelBtn: true,
                      cancelButtonColor: dangerBG,
                      type: ArtSweetAlertType.warning,
                      confirmButtonColor: successBG,
                      onConfirm: () async {
                        apiService?.hardDeletePin(widget.id).then((response) {
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
                      text: "Want to permanentally delete this pin?"));
            }));
  }
}
