import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class ComponentInput extends StatelessWidget {
  final dynamic ctrl;
  final String type;
  final String? hinttext;
  final bool? secure;
  final int? maxLength;
  final int? minLength;
  final dynamic action;
  final int? maxLines;

  const ComponentInput(
      {super.key,
      required this.ctrl,
      required this.type,
      this.hinttext,
      this.secure,
      this.maxLength,
      this.minLength,
      this.action,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    if (type != 'checkbox') {
      return TextFormField(
        obscureText: secure ?? false,
        cursorColor: primaryColor,
        controller: ctrl,
        maxLines: maxLines ?? 1,
        keyboardType:
            type == 'number' ? TextInputType.number : TextInputType.text,
        maxLength: maxLength ?? 255,
        style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: textXMD),
        decoration: InputDecoration(
          hintStyle:
              const TextStyle(color: primaryColor, fontStyle: FontStyle.italic),
          helperStyle: const TextStyle(color: primaryColor),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2.5, color: primaryColor),
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: primaryColor,
            fillColor: MaterialStateProperty.all(Colors.transparent),
            value: ctrl,
            side: const BorderSide(color: primaryColor, width: 1.25),
            activeColor: primaryColor,
            onChanged: action,
          ),
          hinttext != null
              ? Text(
                  hinttext ?? '',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: textMD,
                      fontWeight: FontWeight.w500),
                )
              : const SizedBox(),
        ],
      );
    }
  }
}
