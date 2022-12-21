import 'package:flutter/material.dart';
import 'package:mindcare/flutter_flow/flutter_flow_theme.dart';
import 'package:mindcare/model/quesito.dart';

class AlertRisposta extends StatelessWidget {
  final dynamic quesito;
  AlertRisposta(this.quesito);

/*Funzione che ritorna l'opzione corrispondente alla risposta. */
  getRisposta() {
    var risposta = quesito['risposta'];
    //take last character of the string risposta
    var lastChar = risposta?.substring(risposta.length - 1);
    //create switch case on lastChar. if lastChar is 1 return quesito.opzione1 etc...
    switch (lastChar) {
      case "1":
        return quesito['opzione1'];
      case "2":
        return quesito['opzione2'];
      case "3":
        return quesito['opzione3'];
      case "4":
        return quesito['opzione4'];
      default:
        return "Errore";
    }
  }

  @override
  Widget build(BuildContext context) {
    var risposta = getRisposta();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      title: quesito['tipologia'] == 'Associa il nome all\'immagine'
          ? Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Text(
                risposta,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 25,
                    ),
              ))
          : Image.network(risposta),
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
