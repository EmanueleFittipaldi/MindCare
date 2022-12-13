import 'package:flutter/material.dart';

class AlertHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(
          "Mmm, sembra che questa domanda ti abbia messo un po' in difficoltà, vuoi vedere la risposta?"),
      actions: [
        TextButton(
          child: Text("Si", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: Text("No", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
