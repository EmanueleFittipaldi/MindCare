import 'dart:io';

import 'package:mindcare/controller/report_controller.dart';
import 'package:mindcare/controller/umore_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_widgets.dart';
import 'package:mindcare/gestione_report/humore_chart.dart';
import 'package:mindcare/gestione_report/report_medico.dart';
import 'package:mindcare/gestione_report/view_umore.dart';
import 'package:mindcare/model/report.dart';
import 'package:csv/csv.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/umore.dart';
import 'package:mindcare/model/utente.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:path_provider/path_provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../flutter_flow/flutter_flow_calendar.dart';

class UmoreStatsWidget extends StatefulWidget {
  final Utente user;

  const UmoreStatsWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UmoreStatsWidgetState createState() => _UmoreStatsWidgetState();
}

class _UmoreStatsWidgetState extends State<UmoreStatsWidget> {
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

  Future getHumorData() async {
    if (startDate == null && endDate == null) {
      endDate = DateTime.now();
      startDate = endDate!.subtract(const Duration(days: 30));
    }

    return UmoreController()
        .getUmoreDataInRange(widget.user.userID, startDate, endDate);
  }

  getUmoreSelectedData(List<Umore> data) {
    reportSelectedDay = {};
    List<Umore> listR = [];
    double humorAverage = 0;
    int countQuiz = 0;

    int countPositive = 0;
    int countNegative = 0;
    int countNormal = 0;

    for (var umore in data) {
      if (umore.data >= calendarSelectedDay!.start &&
          umore.data <= calendarSelectedDay!.end) {
        listR.add(umore);
        if (umore.type == 'quiz') {
          if (umore.score > 2) {
            countPositive += 1;
          } else if (umore.score < 2) {
            countNegative += 1;
          } else {
            countNormal += 1;
          }
          humorAverage += umore.score;
          countQuiz += 1;
        } else {
          if (umore.score > 1) {
            countPositive += 1;
          } else if (umore.score < 0) {
            countNegative += 1;
          } else {
            countNormal += 1;
          }
        }
      }
    }

    if (listR.isNotEmpty) {
      var image = '';
      var stats = {};
      if (countQuiz > 0) {
        humorAverage = (humorAverage / countQuiz);

        switch (humorAverage.round()) {
          case 0:
            image = 'assets/images/angry.png';
            break;
          case 1:
            image = 'assets/images/sad.png';
            break;
          case 2:
            image = 'assets/images/neutral.png';
            break;
          case 3:
            image = 'assets/images/happy.png';
            break;
          case 4:
            image = 'assets/images/excited.png';
            break;
        }
      }

      stats['UmoreMedio'] = image;
      stats['Positive'] = countPositive;
      stats['Normal'] = countNormal;
      stats['Negative'] = countNegative;
      reportSelectedDay!['Umore'] = listR;
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
            title: 'Andamento umore',
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
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [],
                  ),
                ),
                FutureBuilder(
                    future: Future.wait([getData(), getHumorData()]),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        List<Report> data = snapshot.data![0] as List<Report>;
                        List<Umore> dataUmore =
                            snapshot.data![1] as List<Umore>;

                        for (var item in data) {
                          dataUmore.add(Umore(
                              text: '',
                              score: item.umore,
                              comparative: 0,
                              data: item.dataInizio,
                              umoreID: '',
                              type: 'quiz'));
                        }
                        if (dataUmore.isEmpty) {
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
                                  0, 5, 0, 5),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  List<List<dynamic>> csv = [];
                                  csv.add([
                                    'UmoreID',
                                    'Data Risposta',
                                    'Tipologia',
                                    'Comparative',
                                    'Score',
                                    'Risposta',
                                  ]);
                                  for (var item in dataUmore) {
                                    csv.add([
                                      item.umoreID,
                                      item.data.toString(),
                                      item.type,
                                      item.comparative.toString(),
                                      item.score.toString(),
                                      item.text
                                    ]);
                                  }

                                  String csvS =
                                      const ListToCsvConverter().convert(csv);

                                  Directory? directory = Platform.isAndroid
                                      ? await getExternalStorageDirectory() //FOR ANDROID
                                      : await getApplicationSupportDirectory(); //FOR iOS
                                  var fname =
                                      'Report_UMORE_${widget.user.name}_${widget.user.lastname}_P#_${widget.user.userID}_${DateTime.now()}.csv';
                                  File f = File(
                                      "${directory!.absolute.path}/$fname");

                                  f.writeAsString(csvS);

                                  var msg =
                                      'Report umore [$startDate - $endDate]\nPaziente: ${widget.user.lastname} ${widget.user.name} \nID:#${widget.user.userID}\nCreato il: ${DateTime.now()}\n\nEmesso dal Caregiver:#${Auth().currentUser!.uid}';
                                  // ignore: unused_local_variable
                                  var text = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogSendReport(
                                            msg: msg,
                                            path: f.path,
                                            subject:
                                                'Report Umore Paziente#${widget.user.userID} ${DateTime.now()}');
                                      });
                                },
                                text: 'Invia andamento al medico',
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
                            dataUmore.isEmpty == false
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 10),
                                    // ignore: sized_box_for_whitespace
                                    child: Container(
                                        height: 500,
                                        width: double.infinity,
                                        child: PageView(
                                          controller:
                                              pageUmoreViewController ??=
                                                  PageController(
                                                      initialPage: 0),
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 0, 10),
                                                    child: Text(
                                                      'Score ottenuto da sentiment analysis. \nMaggiore è lo score migliore è l\'umore del paziente.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: HumorStatsChart(
                                                      data: dataUmore,
                                                      tipoUmore: 'giornaliero',
                                                      typeChart:
                                                          "Grafico a linee",
                                                      pageViewController:
                                                          pageUmoreViewController!,
                                                    ),
                                                  ),
                                                ]),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 0, 10),
                                                  child: Text(
                                                    'Score ottenuto da sentiment analysis. \nMaggiore è lo score migliore è l\'umore del paziente.',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: HumorStatsChart(
                                                    data: dataUmore,
                                                    tipoUmore: 'ricordi',
                                                    typeChart:
                                                        "Grafico a linee",
                                                    pageViewController:
                                                        pageUmoreViewController!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 0, 10),
                                                  child: Text(
                                                    'Score ottenuto dalla emoticon selezionata dopo aver completato il quiz.',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: HumorStatsChart(
                                                    data: dataUmore,
                                                    tipoUmore: 'quiz',
                                                    typeChart:
                                                        "Grafico a linee",
                                                    pageViewController:
                                                        pageUmoreViewController!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )
                                : Text(
                                    'Non ci sono dati sull\'umore!',
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
                                              "Inserisci una data nell'intervallo selezionato!",
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
                                        getUmoreSelectedData(dataUmore);
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
                                                        reportSelectedDay![
                                                                        'Statistiche']
                                                                    [
                                                                    'UmoreMedio'] ==
                                                                ''
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        22,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  'NaN',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: const Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            30,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                reportSelectedDay![
                                                                        'Statistiche']
                                                                    [
                                                                    'UmoreMedio'],
                                                                width: 80,
                                                                height: 80,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 22, 0, 0),
                                                          child: Text(
                                                            'Umore medio quiz',
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
                                                                  0, 0, 0, 5),
                                                          child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Umore positivo: ',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      reportSelectedDay!['Statistiche']
                                                                              [
                                                                              'Positive']
                                                                          .toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 0, 5),
                                                          child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Umore neutro: ',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      reportSelectedDay!['Statistiche']
                                                                              [
                                                                              'Normal']
                                                                          .toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 0, 5),
                                                          child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Umore negativo: ',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      reportSelectedDay!['Statistiche']
                                                                              [
                                                                              'Negative']
                                                                          .toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                const Color(0xFF57636C),
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
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
                                                builder: (context) => ViewUmore(
                                                    user: widget.user,
                                                    data: reportSelectedDay![
                                                        'Umore'])));
                                      },
                                      text: 'Visualizza risposte',
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
