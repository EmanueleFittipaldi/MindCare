import 'package:flutter/material.dart';

class AlertRisposta extends StatelessWidget {
  final String risposta;
  AlertRisposta(this.risposta);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(risposta),
      actions: [
        TextButton(
          child: const Text("Torna al quiz", style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
