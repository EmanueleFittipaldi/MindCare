import 'dart:io';

import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/src/widgets/panara_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class DialogSendReport extends StatefulWidget {
  final String subject;
  final String msg;
  final String path;
  const DialogSendReport(
      {Key? key, required this.subject, required this.msg, required this.path})
      : super(key: key);

  @override
  _DialogSendReport createState() => _DialogSendReport();
}

class _DialogSendReport extends State<DialogSendReport> {
  final textColor = const Color(0xFF707070);

  final buttonTextColor = Colors.white;
  TextEditingController? textControllerEmail;
  TextEditingController? textControllerOggetto;
  TextEditingController? textControllerMessaggio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textControllerEmail = TextEditingController();
    textControllerOggetto = TextEditingController();
    textControllerMessaggio = TextEditingController();
    textControllerOggetto!.text = widget.subject;
    textControllerMessaggio!.text = widget.msg;
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
              const Text(
                'Invia report al medico',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                child: TextFormField(
                  controller: textControllerEmail,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'E-mail medico:',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    hintStyle: FlutterFlowTheme.of(context).bodyText2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 15),
                child: TextFormField(
                  controller: textControllerOggetto,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Oggetto',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    hintStyle: FlutterFlowTheme.of(context).bodyText2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 15),
                child: TextFormField(
                  controller: textControllerMessaggio,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Messaggio:',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    hintStyle: FlutterFlowTheme.of(context).bodyText2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  maxLines: 6,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.fileCsv,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          widget.path.split('/').last,
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 10, 0),
                            child: PanaraButton(
                              buttonTextColor: Colors.white,
                              text: 'Annulla',
                              onTap: () async {
                                Navigator.of(context).pop('Ciao');
                              },
                              bgColor:
                                  FlutterFlowTheme.of(context).primaryColor,
                              isOutlined: false,
                            ))),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 0, 0),
                            child: PanaraButton(
                              buttonTextColor: Colors.white,
                              text: 'Invia',
                              onTap: () async {
                                final Email email = Email(
                                  body: textControllerMessaggio!.text,
                                  subject: textControllerOggetto!.text,
                                  recipients: [textControllerEmail!.text],
                                  attachmentPaths: [widget.path],
                                  isHTML: false,
                                );

                                await FlutterEmailSender.send(email);
                                Navigator.of(context).pop('Ciao');
                              },
                              bgColor:
                                  FlutterFlowTheme.of(context).primaryColor,
                              isOutlined: false,
                            ))),
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
