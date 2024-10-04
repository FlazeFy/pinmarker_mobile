import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/button/button_icon.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/index.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';

class RecoverPin extends StatefulWidget {
  const RecoverPin({super.key, required this.id});
  final String id;

  @override
  StateRecoverPin createState() => StateRecoverPin();
}

class StateRecoverPin extends State<RecoverPin> {
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
            color: Colors.green,
            icon: FontAwesomeIcons.rotateLeft,
            func: () {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      showCancelBtn: true,
                      cancelButtonColor: Colors.red,
                      type: ArtSweetAlertType.warning,
                      confirmButtonColor: Colors.green,
                      onConfirm: () async {
                        apiService?.recoverPin(widget.id).then((response) {
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
                      confirmButtonText: "Yes, recover it!",
                      title: "Are you sure?",
                      text: "Want to recover this pin?"));
            }));
  }
}
