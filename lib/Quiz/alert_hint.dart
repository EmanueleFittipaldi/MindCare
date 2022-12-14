import 'package:flutter/material.dart';

class AlertHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: const Text(
          "Mmm, sembra che questa domanda ti abbia messo un po' in difficoltà, vuoi vedere la risposta?"),
      actions: [
        TextButton(
          child: const Text("Si", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text("No", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
