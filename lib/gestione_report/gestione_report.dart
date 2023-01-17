import 'dart:io';

import 'package:mindcare/controller/report_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_widgets.dart';
import 'package:mindcare/gestione_report/chart.dart';
import 'package:mindcare/gestione_report/report_medico.dart';
import 'package:mindcare/gestione_report/view_report.dart';
import 'package:mindcare/model/report.dart';
import 'package:csv/csv.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/utente.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../flutter_flow/flutter_flow_calendar.dart';

class ReportQuizStatsWidget extends StatefulWidget {
  final Utente user;

  const ReportQuizStatsWidget({Key? key, required this.user}) : super(key: key);

  @override
  _ReportQuizStatsWidgetState createState() => _ReportQuizStatsWidgetState();
}

class _ReportQuizStatsWidgetState extends State<ReportQuizStatsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageViewController;
  PageController? pageUmoreViewController;
  GroupButtonController? groupButtonController;
  DateTime? startDate;
  DateTime? endDate;
  String? chartType;
  String? dropDownCategory;
  DateTimeRange? calendarSelectedDay;
  Map<String, dynamic>? reportSelectedDay;
  ScrollController? columnController;
  Future getData() async {
    if (startDate == null && endDate == null) {
      endDate = DateTime.now();
      startDate = endDate!.subtract(const Duration(days: 30));
    }

    return ReportController()
        .getReportInRange(widget.user.userID, startDate, endDate);
  }

  getReportSelectData(List<Report> data) {
    reportSelectedDay = {};
    List<Report> listR = [];
    double humorAverage = 0;
    int tempoTotale = 0;
    Set quizCompletati = {};
    for (var report in data) {
      if (report.dataInizio >= calendarSelectedDay!.start &&
          report.dataInizio <= calendarSelectedDay!.end) {
        listR.add(report);
        humorAverage += report.umore;
        tempoTotale += report.tempoImpiegato;
        quizCompletati.add(report.categoria + report.tipologia);
      }
    }

    if (listR.isNotEmpty) {
      humorAverage = (humorAverage / listR.length);
      var stats = {};
      // ignore: prefer_typing_uninitialized_variables
      var image;
      switch (humorAverage.round()) {
        case 0:
          image = 'https://cdn-icons-png.flaticon.com/512/6637/6637186.png';
          break;
        case 1:
          image = 'https://cdn-icons-png.flaticon.com/512/6637/6637163.png';
          break;
        case 2:
          image = 'https://cdn-icons-png.flaticon.com/512/6637/6637207.png';
          break;
        case 3:
          image = 'https://cdn-icons-png.flaticon.com/512/6637/6637188.png';
          break;
        case 4:
          image = 'https://cdn-icons-png.flaticon.com/512/6637/6637197.png';
          break;
      }

      stats['QuizCompletati'] = quizCompletati.length;
      stats['UmoreMedio'] = image;
      stats['TempoGioco'] = tempoTotale;
      reportSelectedDay!['Report'] = listR;
      reportSelectedDay!['Statistiche'] = stats;
    } else {
      reportSelectedDay = null;
    }
  }

  @override
  void initState() {
    groupButtonController = GroupButtonController();
    columnController = ScrollController();
    groupButtonController!.selectIndex(0);
    chartType = 'Grafico a barre';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppbarWidget(
            title: 'Andamento quiz',
          )),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            controller: columnController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () async {
                            var results = await showCalendarDatePicker2Dialog(
                              context: context,
                              initialValue: [startDate, endDate],
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                firstDate: DateTime(0, 0, 0),
                                lastDate: DateTime(
                                  DateTime.now().year + 1,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                                currentDate: DateTime.now(),
                                calendarType: CalendarDatePicker2Type.range,
                                firstDayOfWeek: 1,
                                selectedDayHighlightColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                              dialogSize: const Size(325, 400),
                              borderRadius: BorderRadius.circular(15),
                            );
                            if (results != null && results.length == 2) {
                              setState(() {
                                startDate = results[0];
                                endDate = results[1];
                              });
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Data di inizio:',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                startDate == null
                                    ? 'Data di inizio'
                                    : DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(startDate.toString())),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () async {
                            var results = await showCalendarDatePicker2Dialog(
                              context: context,
                              initialValue: [startDate, endDate],
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                firstDate: DateTime(0, 0, 0),
                                lastDate: DateTime(
                                  DateTime.now().year + 1,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                                currentDate: DateTime.now(),
                                calendarType: CalendarDatePicker2Type.range,
                                firstDayOfWeek: 1,
                                selectedDayHighlightColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                              dialogSize: const Size(325, 400),
                              borderRadius: BorderRadius.circular(15),
                            );
                            if (results != null && results.length == 2) {
                              setState(() {
                                startDate = results[0];
                                endDate = results[1];
                              });
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Data di fine:',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                endDate == null
                                    ? 'Data di inizio'
                                    : DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(endDate.toString())),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [],
                  ),
                ),
                FutureBuilder(
                    future: getData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Report> data = snapshot.data! as List<Report>;

                        if (data.isEmpty) {
                          return Text(
                            'Non ci sono dati!',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: const Color(0xFF101213),
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                    ),
                          );
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 5, 15, 0),
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 12,
                                          color: Color(0x14000000),
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 0,
                                      )),
                                  child: GroupButton(
                                    controller: groupButtonController,
                                    isRadio: true,
                                    onSelected: (value, index, isSelected) {
                                      setState(() {
                                        chartType = value as String;
                                      });
                                    },
                                    buttons: const [
                                      "Grafico a barre",
                                      "Grafico a linee",
                                    ],
                                    options: GroupButtonOptions(
                                        spacing: 0,
                                        buttonWidth: 130,
                                        buttonHeight: 40,
                                        selectedColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                        unselectedColor: Colors.white),
                                  )),
                            ),
                            data.isEmpty == false
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 10),
                                    // ignore: sized_box_for_whitespace
                                    child: Container(
                                        height: 500,
                                        width: double.infinity,
                                        child: PageView(
                                          controller: pageViewController ??=
                                              PageController(initialPage: 0),
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            StatsChart(
                                              data: data,
                                              category: 'Persone',
                                              typeChart: chartType!,
                                              pageViewController:
                                                  pageViewController!,
                                            ),
                                            StatsChart(
                                              data: data,
                                              category: 'Animali',
                                              typeChart: chartType!,
                                              pageViewController:
                                                  pageViewController!,
                                            ),
                                            StatsChart(
                                              data: data,
                                              category: 'Oggetti',
                                              typeChart: chartType!,
                                              pageViewController:
                                                  pageViewController!,
                                            ),
                                            StatsChart(
                                              data: data,
                                              category: 'Altro',
                                              typeChart: chartType!,
                                              pageViewController:
                                                  pageViewController!,
                                            ),
                                          ],
                                        )),
                                  )
                                : Text(
                                    'Non ci sono dati sui quiz!',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: const Color(0xFF101213),
                                          fontSize: 28,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  List<List<dynamic>> csv = [];
                                  csv.add([
                                    'ReportID',
                                    'Categoria',
                                    'Tipologia',
                                    'Risposte Corrette',
                                    'Risposte Errate',
                                    'Precisione',
                                    'Tempo Impiegato',
                                    'Umore',
                                    'Data Completato',
                                    'Mappa Risposte'
                                  ]);
                                  for (var item in data) {
                                    csv.add([
                                      item.reportID,
                                      item.categoria,
                                      item.tipologia,
                                      item.risposteCorrette.toString(),
                                      item.risposteErrate.toString(),
                                      item.precisione.toString(),
                                      item.tempoImpiegato.toString(),
                                      item.umore,
                                      item.dataInizio.toString(),
                                      item.mappaRisposte.toString()
                                    ]);
                                  }

                                  String csvS =
                                      const ListToCsvConverter().convert(csv);

                                  Directory? directory = Platform.isAndroid
                                      ? await getExternalStorageDirectory() //FOR ANDROID
                                      : await getApplicationSupportDirectory(); //FOR iOS
                                  var fname =
                                      'Report_${widget.user.name}_${widget.user.lastname}_P#_${widget.user.userID}_${DateTime.now()}.csv';
                                  File f = File(
                                      "${directory!.absolute.path}/$fname");

                                  f.writeAsString(csvS);

                                  var msg =
                                      'Report quiz [$startDate - $endDate]\nPaziente: ${widget.user.lastname} ${widget.user.name} \nID:#${widget.user.userID}\nCreato il: ${DateTime.now()}\n\nEmesso dal Caregiver:#${Auth().currentUser!.uid}';
                                  // ignore: unused_local_variable
                                  var text = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogSendReport(
                                            msg: msg,
                                            path: f.path,
                                            subject:
                                                'Report Paziente#${widget.user.userID} ${DateTime.now()}');
                                      });
                                },
                                text: 'Invia report al medico',
                                options: FFButtonOptions(
                                  width: 170,
                                  height: 40,
                                  elevation: 0,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                  borderRadius: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 0, 15, 15),
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 12,
                                        color: Color(0x14000000),
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 0,
                                    )),
                                child: FlutterFlowCalendar(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  weekFormat: true,
                                  weekStartsMonday: true,
                                  initialDate: getCurrentTimestamp,
                                  onChange:
                                      (DateTimeRange? newSelectedDate) async {
                                    setState(() {
                                      if (newSelectedDate!.start > endDate! ||
                                          newSelectedDate.end < startDate!) {
                                        PanaraInfoDialog.show(
                                          context,
                                          title: "Errore data",
                                          message:
                                              "Inserisci una data nell\'intervallo selezionato!",
                                          buttonText: "Okay",
                                          onTapDismiss: () {
                                            Navigator.pop(context);
                                          },
                                          panaraDialogType:
                                              PanaraDialogType.warning,
                                          barrierDismissible:
                                              false, // optional parameter (default is true)
                                        );

                                        reportSelectedDay = null;
                                      } else {
                                        calendarSelectedDay = newSelectedDate;
                                        getReportSelectData(data);
                                      }
                                    });
                                    await columnController!.animateTo(
                                      columnController!
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.ease,
                                    );
                                  },
                                  titleStyle: const TextStyle(),
                                  dayOfWeekStyle: const TextStyle(),
                                  dateStyle: const TextStyle(),
                                  selectedDateStyle: const TextStyle(),
                                  inactiveDateStyle: const TextStyle(),
                                ),
                              ),
                            ),
                            reportSelectedDay != null
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 10, 16, 20),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 12,
                                              color: Color(0x14000000),
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 0,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(4, 4, 4, 4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16, 12, 0, 0),
                                              child: Text(
                                                'Resoconto giornaliero',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16, 16, 16, 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Image.network(
                                                          reportSelectedDay![
                                                                  'Statistiche']
                                                              ['UmoreMedio'],
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 22, 0, 0),
                                                          child: Text(
                                                            'Umore medio',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: const Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 0, 12),
                                                          child:
                                                              CircularPercentIndicator(
                                                            percent: reportSelectedDay ==
                                                                    null
                                                                ? 0
                                                                : (1 / 8) *
                                                                    reportSelectedDay![
                                                                            'Statistiche']
                                                                        [
                                                                        'QuizCompletati'],
                                                            radius: 45,
                                                            lineWidth: 12,
                                                            animation: true,
                                                            progressColor:
                                                                const Color(
                                                                    0xFF4B39EF),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFF1F4F8),
                                                            center: Text(
                                                              reportSelectedDay ==
                                                                      null
                                                                  ? ''
                                                                  : '${reportSelectedDay!['Statistiche']['QuizCompletati']}/8',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Quiz completati',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: const Color(
                                                                    0xFF57636C),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16, 16, 16, 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Tempo di gioco:',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                  Text(
                                                    reportSelectedDay == null
                                                        ? ''
                                                        : '${(Duration(seconds: reportSelectedDay!['Statistiche']['TempoGioco']))}'
                                                            .split('.')[0]
                                                            .padLeft(8, '0'),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                // ignore: avoid_unnecessary_containers
                                : Container(
                                    child: Text(
                                        'Non ci sono report in questo giorno!',
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 22)),
                                  ),
                            reportSelectedDay != null
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            50, 0, 50, 20),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewReport(
                                                        user: widget.user,
                                                        data:
                                                            reportSelectedDay![
                                                                'Report'])));
                                      },
                                      text: 'Visualizza report ',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 40,
                                        elevation: 0,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                        borderRadius: 30,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.data, this.value);
  final DateTime data;
  final double? value;
}
