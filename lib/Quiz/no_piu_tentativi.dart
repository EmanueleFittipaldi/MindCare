import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class CustomDialogNoTentativi extends StatefulWidget {
  final dynamic quesito;
  const CustomDialogNoTentativi({Key? key, required this.quesito})
      : super(key: key);

  @override
  _CustomDialogNoTentativiState createState() =>
      _CustomDialogNoTentativiState();
}

class _CustomDialogNoTentativiState extends State<CustomDialogNoTentativi> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

/*Funzione che ritorna l'opzione corrispondente alla risposta. */
  getRisposta() {
    var risposta = widget.quesito['risposta'];
    //take last character of the string risposta
    var lastChar = risposta?.substring(risposta.length - 1);
    //create switch case on lastChar. if lastChar is 1 return quesito.opzione1 etc...
    switch (lastChar) {
      case "1":
        return widget.quesito['opzione1'];
      case "2":
        return widget.quesito['opzione2'];
      case "3":
        return widget.quesito['opzione3'];
      case "4":
        return widget.quesito['opzione4'];
      default:
        return "Errore";
    }
  }

  contentBox(context) {
    return Container(
      width: 500,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.05, -0.3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: Text(
                  'Risposta sbagliata, non hai più tentativi disponibili',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: Color.fromARGB(255, 39, 39, 39),
                        fontSize: 25,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: widget.quesito['tipologia'] ==
                        'Associa il nome all\'immagine'
                    ? Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          widget.quesito['risposta'],
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 25,
                                  ),
                        ))
                    : Image.network(getRisposta()),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                      text: 'Torna al quiz',
                      options: FFButtonOptions(
                        width: 140,
                        height: 60,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'IBM Plex Sans',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
