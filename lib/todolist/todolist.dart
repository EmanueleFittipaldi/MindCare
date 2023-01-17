// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/todo_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_calendar.dart';
import 'package:mindcare/model/utente.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ToDoListPazienteWidget extends StatefulWidget {
  final Utente user;
  final String caregiverID;
  const ToDoListPazienteWidget(
      {Key? key, required this.user, required this.caregiverID})
      : super(key: key);

  @override
  _ToDoListPazienteWidgetState createState() => _ToDoListPazienteWidgetState();
}

class _ToDoListPazienteWidgetState extends State<ToDoListPazienteWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange? calendarSelectedDay;
  bool toogleIcon = false;
  final month = [
    'Gennaio',
    'Febbraio',
    'Marzo',
    'Aprile',
    'Maggio',
    'Giugno',
    'Luglio',
    'Agosto',
    'Settembre',
    'Ottobre',
    'Novembre',
    'Dicembre'
  ];
  final day = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    super.initState();
  }

  getColor(DateTime oraScadenza, bool completed) {
    DateTime now = DateTime.now();
    if (completed) {
      return Colors.green;
    }
    if (oraScadenza.difference(now).isNegative) {
      return const Color(0xFFAB2B40);
    } else if (oraScadenza.difference(now).inMinutes < 30) {
      return const Color(0xFFFF8B17);
    }
    return const Color(0xFF101213);
  }

  getCheckDeadlineActiviy(DateTime oraScadenza, bool completed) {
    DateTime now = DateTime.now();
    if (oraScadenza.difference(now).isNegative) {
      return false;
    }
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
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x14000000),
                        offset: Offset(0, 5),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 5),
                                child: SelectionArea(
                                    child: AutoSizeText(
                                  DateTime.now().day.toString(),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300,
                                      ),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 5),
                                child: SelectionArea(
                                    child: AutoSizeText(
                                  month[(DateTime.now().month) - 1],
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w300,
                                      ),
                                )),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 5),
                                child: SelectionArea(
                                    child: AutoSizeText(
                                  day[(DateTime.now().weekday) - 1],
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w300,
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 5),
                        child: SelectionArea(
                            child: AutoSizeText(
                          'Da questa schermata puoi gestire le tue attività giornaliere',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  ),
                        )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(widget.caregiverID)
                          .collection('Pazienti')
                          .doc(widget.user.userID)
                          .collection('ToDoList')
                          .where('data',
                              isLessThanOrEqualTo:
                                  Timestamp.fromDate(calendarSelectedDay!.end))
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
                            Map<String, dynamic>? todoMap = doc.data();
                            //mappatura dei dati
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
                                      height: 110,
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
                                        borderRadius: BorderRadius.circular(30),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                              child: ToggleIcon(
                                                onPressed: () async {
                                                  TimeOfDay t = TimeOfDay.now();
                                                  setState(() {
                                                    DateTime now =
                                                        DateTime.now();
                                                    DateTime oraScadenza =
                                                        (item['data']
                                                                as Timestamp)
                                                            .toDate();

                                                    if (oraScadenza
                                                            .difference(now)
                                                            .isNegative &&
                                                        now
                                                                .difference(
                                                                    oraScadenza)
                                                                .inMinutes >
                                                            60) {
                                                      PanaraInfoDialog.show(
                                                        context,
                                                        title:
                                                            "Completa attività",
                                                        message:
                                                            "L'attività è scaduta! Non l'hai completata entro la scadenza indicata!",
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
                                                    } else if (!item[
                                                        'completed']) {
                                                      ToDoController()
                                                          .updateCompleted(
                                                              widget
                                                                  .user.userID,
                                                              widget
                                                                  .caregiverID,
                                                              item['todoID'],
                                                              '${t.hour}:${t.minute}',
                                                              true);
                                                    }
                                                  });
                                                },
                                                value: item['completed'],
                                                onIcon: const Icon(
                                                  Icons.check_box,
                                                  color: Color(0xFF17901E),
                                                  size: 30,
                                                ),
                                                offIcon: Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 20, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 20, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        16,
                                                                        10,
                                                                        0,
                                                                        10),
                                                                child:
                                                                    AutoSizeText(
                                                                  item['text'],
                                                                  style: FlutterFlowTheme.of(context).subtitle1.override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: const Color(
                                                                          0xFF101213),
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                      decoration: item['completed'] ==
                                                                              true
                                                                          ? TextDecoration
                                                                              .lineThrough
                                                                          : TextDecoration
                                                                              .none),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 0, 0, 10),
                                                      child: AutoSizeText(
                                                        'ore ${DateFormat('HH:mm').format(DateTime.parse((item['data'] as Timestamp).toDate().toString()))}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: getColor(
                                                                      (item['data']
                                                                              as Timestamp)
                                                                          .toDate(),
                                                                      item[
                                                                          'completed']),
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

                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
