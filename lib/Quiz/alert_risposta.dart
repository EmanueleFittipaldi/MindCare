import 'package:flutter/material.dart';

/*Modify this code by changing the class name to Alert Risposta removing the button "no", changing the text of button "si" with "torna al quiz" and changing
the Title with the parameter i've passed to AlertRisposta */
class AlertRisposta extends StatelessWidget {
  final String risposta;
  AlertRisposta(this.risposta);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(risposta),
      actions: [
        TextButton(
          child: Text("Torna al quiz", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
