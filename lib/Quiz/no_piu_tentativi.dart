import 'dart:io';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/src/widgets/panara_button.dart';

class CustomDialogNoTentativi extends StatefulWidget {
  final dynamic quesito;
  final String title;
  final String message;
  const CustomDialogNoTentativi(
      {Key? key,
      required this.quesito,
      required this.title,
      required this.message})
      : super(key: key);

  @override
  _CustomDialogNoTentativiState createState() =>
      _CustomDialogNoTentativiState();
}

class _CustomDialogNoTentativiState extends State<CustomDialogNoTentativi> {
  final textColor = const Color(0xFF707070);
  final color = const Color(0xFFFF4D17);
  final buttonTextColor = Colors.white;

  /*Funzione che ritorna l'opzione corrispondente alla risposta. */
  getRisposta() {
    var risposta = widget.quesito['risposta'];
    //take last character of the string risposta
    var lastChar = risposta.replaceAll(new RegExp(r'[^0-9]'), '');
    return widget.quesito['opzione' + lastChar];
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 340,
          ),
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.message,
                style: TextStyle(
                  color: textColor,
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              widget.quesito['tipologia'] == 'Associa il nome all\'immagine'
                  ? Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        getRisposta(),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBM Plex Sans',
                              fontSize: 25,
                            ),
                      ))
                  : Image.network(
                      getRisposta(),
                      width: 150,
                      height: 200,
                    ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: PanaraButton(
                  buttonTextColor: Colors.white,
                  text: 'Torna al quiz',
                  onTap: () => Navigator.of(context).pop(true),
                  bgColor: color,
                  isOutlined: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
