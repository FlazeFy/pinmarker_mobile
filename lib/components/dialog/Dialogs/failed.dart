import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class FailedDialog extends StatefulWidget {
  FailedDialog({this.text});
  var text;

  @override
  _FailedDialog createState() => _FailedDialog();
}

class _FailedDialog extends State<FailedDialog> {
  @override
  Widget build(BuildContext context) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: const Text('Error'),
      content: SizedBox(
        width: fullWidth,
        height: 300,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset('assets/sorry.png', width: 200),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textMD,
                          fontWeight: FontWeight.w500)))
            ]),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.black),
          ),
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
