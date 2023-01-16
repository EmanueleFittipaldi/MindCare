import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/controller/todo_controller.dart';
import 'package:mindcare/gestione_todolist/creazione_attivit%C3%A0.dart';
import 'package:mindcare/model/todo.dart';
import 'package:mindcare/model/utente.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';

class ToDoListWidget extends StatefulWidget {
  final Utente user;
  const ToDoListWidget({Key? key, required this.user}) : super(key: key);

  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  DateTimeRange? calendarSelectedDay;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFECF4FF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Da Fare',
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12,
                          color: Color(0x14000000),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FlutterFlowCalendar(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      weekFormat: true,
                      weekStartsMonday: true,
                      initialDate: getCurrentTimestamp,
                      onChange: (DateTimeRange? newSelectedDate) {
                        setState(() => calendarSelectedDay = newSelectedDate);
                      },
                      titleStyle: const TextStyle(),
                      dayOfWeekStyle: const TextStyle(),
                      dateStyle: const TextStyle(),
                      selectedDateStyle: const TextStyle(),
                      inactiveDateStyle: const TextStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(
                          'Attività',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'IBM Plex Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 40,
                        fillColor: FlutterFlowTheme.of(context).primaryColor,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          size: 22,
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreazioneAttivita(
                                    user: widget.user,
                                    item: null,
                                    data: calendarSelectedDay!.start,
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(Auth().currentUser?.uid)
                            .collection('Pazienti')
                            .doc(widget.user.userID)
                            .collection('ToDoList')
                            .where('data',
                                isLessThanOrEqualTo: Timestamp.fromDate(
                                    calendarSelectedDay!.end))
                            .where('data',
                                isGreaterThanOrEqualTo: Timestamp.fromDate(
                                    calendarSelectedDay!.start))
                            .orderBy('data', descending: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = [];
                            snapshot.data?.docs.forEach((doc) {
                              //iterazione sui singoli documenti
                              Map<String, dynamic>? todoMap =
                                  doc.data(); //mappatura dei dati
                              data.add(todoMap);
                            });
                            if (data.isNotEmpty) {
                              return ListView(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  for (var item in data)
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              15, 0, 15, 8),
                                      child: Container(
                                        width: double.infinity,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x14000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              item['completed'] == false
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 10, 0, 0),
                                                      child: Icon(
                                                        Icons.clear_rounded,
                                                        color:
                                                            Color(0xFFAB2B40),
                                                        size: 40,
                                                      ),
                                                    )
                                                  : const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 10, 0, 0),
                                                      child: Icon(
                                                        Icons.check_rounded,
                                                        color:
                                                            Color(0xFF17901E),
                                                        size: 40,
                                                      ),
                                                    ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                16, 12, 0, 0),
                                                        child: AutoSizeText(
                                                          item['text'],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: const Color(
                                                                    0xFF101213),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 5, 0, 0),
                                                      child: Text(
                                                        'Ora attività:  ${DateFormat('HH:mm').format(DateTime.parse((item['data'] as Timestamp).toDate().toString()))}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 5, 0, 0),
                                                      child: Text(
                                                        item['completed'] ==
                                                                false
                                                            ? 'Completato: --:--'
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            : 'Completato: ' +
                                                                item[
                                                                    'oraCompleted'],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 45,
                                                      icon: const Icon(
                                                        Icons.mode_edit,
                                                        color:
                                                            Color(0xFF8E8E8E),
                                                        size: 25,
                                                      ),
                                                      onPressed: () {
                                                        if (!item[
                                                            'completed']) {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CreazioneAttivita(
                                                                            user:
                                                                                widget.user,
                                                                            item: ToDo(
                                                                                todoID: item['todoID'],
                                                                                text: item['text'],
                                                                                oraCompleted: item['oraCompleted'],
                                                                                completed: item['completed'],
                                                                                data: (item['data'] as Timestamp).toDate()),
                                                                            data:
                                                                                calendarSelectedDay!.start,
                                                                          )));
                                                        } else {
                                                          PanaraInfoDialog.show(
                                                            context,
                                                            title:
                                                                "Modifica attività",
                                                            message:
                                                                "L'attività è stata già completata!",
                                                            buttonText: "Okay",
                                                            onTapDismiss: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            panaraDialogType:
                                                                PanaraDialogType
                                                                    .warning,
                                                            barrierDismissible:
                                                                false, // optional parameter (default is true)
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 45,
                                                      icon: const Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        color:
                                                            Color(0xFF8E8E8E),
                                                        size: 25,
                                                      ),
                                                      onPressed: () async {
                                                        if (!item[
                                                            'completed']) {
                                                          var confirmDialogResponse =
                                                              await PanaraConfirmDialog
                                                                  .show(
                                                            context,
                                                            title:
                                                                "Eliminazione attività",
                                                            message:
                                                                "Vuoi davvero eliminare l'attività? L'azione non è riversibile!",
                                                            confirmButtonText:
                                                                "Conferma",
                                                            cancelButtonText:
                                                                "Annulla",
                                                            onTapCancel: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                            },
                                                            onTapConfirm: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(true);
                                                            },
                                                            panaraDialogType:
                                                                PanaraDialogType
                                                                    .normal,

                                                            barrierDismissible:
                                                                false, // optional parameter (default is true)
                                                          );

                                                          if (confirmDialogResponse) {
                                                            ToDoController()
                                                                .deleteToDo(
                                                                    widget.user
                                                                        .userID,
                                                                    Auth()
                                                                        .currentUser!
                                                                        .uid,
                                                                    item[
                                                                        'todoID']);
                                                          }
                                                        } else {
                                                          PanaraInfoDialog.show(
                                                            context,
                                                            title:
                                                                "Elimina attività",
                                                            message:
                                                                "L'attività è stata già completata!",
                                                            buttonText: "Okay",
                                                            onTapDismiss: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            panaraDialogType:
                                                                PanaraDialogType
                                                                    .warning,
                                                            barrierDismissible:
                                                                false, // optional parameter (default is true)
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Non ci sono attività in questa giornata!',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color: const Color(0xFF57636C),
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ]));
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
