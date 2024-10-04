import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/maps/list_view/detail/index.dart';
import 'package:pinmarker/services/modules/pin/commands.dart';

class ToggleFavoritePin extends StatefulWidget {
  const ToggleFavoritePin(
      {super.key, required this.id, required this.isFavorite});
  final String id;
  final bool isFavorite;

  @override
  StateToggleFavoritePin createState() => StateToggleFavoritePin();
}

class StateToggleFavoritePin extends State<ToggleFavoritePin> {
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
          apiService?.toggleFavoritePin(widget.id).then((response) {
            setState(() => {});
            var code = response['code'];
            var message = response['message'];

            if (code == 200) {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      onConfirm: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPinPage(
                                    id: widget.id,
                                    isFavorite:
                                        widget.isFavorite ? false : true)),
                          );
                        });
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
        icon: FaIcon(
            widget.isFavorite
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            color: Colors.black,
            size: textXLG));
  }
}
