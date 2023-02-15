import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/todo_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/model/todo.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../model/utente.dart';

class CreazioneAttivita extends StatefulWidget {
  final Utente user;
  final ToDo? item;
  final DateTime data;
  const CreazioneAttivita(
      {Key? key, required this.user, required this.item, required this.data})
      : super(key: key);

  @override
  _CreazioneAttivitaState createState() => _CreazioneAttivitaState();
}

class _CreazioneAttivitaState extends State<CreazioneAttivita> {
  String imagContatto = '';
  DateTime? datePicked;
  TextEditingController? descrizioneController;
  TextEditingController? controllerData;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    descrizioneController = TextEditingController();
    controllerData = TextEditingController();
    if (widget.item != null) {
      descrizioneController!.text = widget.item!.text;
      datePicked = widget.item!.data;
      controllerData!.text = datePicked == null
          ? 'Ore'
          : DateFormat('HH:mm').format(DateTime.parse(datePicked.toString()));
    }
  }

  @override
  void dispose() {
    descrizioneController?.dispose();
    controllerData?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var confirmDialogResponse = await PanaraConfirmDialog.show(
          context,
          title: "Creazione attività",
          message:
              "Vuoi davvero annullare la creazione? Tutti i dati verranno persi!",
          confirmButtonText: "Conferma",
          cancelButtonText: "Annulla",
          onTapCancel: () {
            Navigator.of(context).pop(false);
          },
          onTapConfirm: () {
            Navigator.of(context).pop(true);
          },
          panaraDialogType: PanaraDialogType.normal,

          barrierDismissible: false, // optional parameter (default is true)
        );
        if (confirmDialogResponse) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Attività',
            style: FlutterFlowTheme.of(context).title2,
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                buttonSize: 48,
                icon: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 30,
                ),
                onPressed: () async {
                  var confirmDialogResponse = await PanaraConfirmDialog.show(
                    context,
                    title: "Creazione attività",
                    message:
                        "Vuoi davvero annullare la creazione? Tutti i dati verranno persi!",
                    confirmButtonText: "Conferma",
                    cancelButtonText: "Annulla",
                    onTapCancel: () {
                      Navigator.of(context).pop(false);
                    },
                    onTapConfirm: () {
                      Navigator.of(context).pop(true);
                    },
                    panaraDialogType: PanaraDialogType.normal,

                    barrierDismissible:
                        false, // optional parameter (default is true)
                  );
                  if (confirmDialogResponse) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Informazioni Attività',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Inserisci una breve descrizione';
                                          }
                                          var val = value.replaceAll(' ', '');
                                          if (val.isEmpty ||
                                              value.isEmpty ||
                                              value.length > 100) {
                                            return 'Inserisci una descrizione valida di max 100 caratteri';
                                          }

                                          return null;
                                        },
                                        controller: descrizioneController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Descrizione',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        maxLines: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 10, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Inserisci un\'orario di completamento';
                                          }
                                          return null;
                                        },
                                        controller: controllerData,
                                        autofocus: true,
                                        readOnly: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Orario completamento',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await DatePicker.showTimePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (date) {
                                        if (date
                                            .difference(DateTime.now())
                                            .isNegative) {
                                          PanaraInfoDialog.show(
                                            context,
                                            title: "Orario completamento",
                                            message:
                                                "Non puoi inserire un'orario precedente a quello corrente!",
                                            buttonText: "Okay",
                                            onTapDismiss: () {
                                              Navigator.pop(context);
                                            },
                                            panaraDialogType:
                                                PanaraDialogType.warning,
                                            barrierDismissible:
                                                false, // optional parameter (default is true)
                                          );
                                        } else {
                                          setState(() {
                                            datePicked = date;

                                            controllerData!.text = datePicked ==
                                                    null
                                                ? 'Ore'
                                                : DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                        datePicked.toString()));
                                          });
                                        }
                                      },
                                          currentTime:
                                              datePicked ?? widget.data);
                                    },
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      color: Color(0xFF57636C),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                      child: FFButtonWidget(
                        onPressed: () async {
                          //Controlli sui campi riempiti
                          if (formKey.currentState == null ||
                              !formKey.currentState!.validate()) {
                            return;
                          }

                          if (widget.item != null) {
                            ToDoController().updateToDo(
                                widget.user.userID,
                                descrizioneController!.text,
                                datePicked!,
                                widget.item!.todoID,
                                widget.item!.oraCompleted,
                                widget.item!.completed);
                            Navigator.of(context).pop();
                          } else {
                            ToDoController().createToDo(widget.user.userID,
                                descrizioneController!.text, datePicked!);
                            Navigator.of(context).pop();
                          }
                        },
                        text: 'Salva',
                        options: FFButtonOptions(
                          width: 150,
                          height: 65,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: Colors.white,
                                  ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
