import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/Quiz/report.dart';

import 'package:mindcare/flutter_flow/flutter_flow_drop_down.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/auth.dart';
import 'package:mindcare/utente.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ReportStatsWidget extends StatefulWidget {
  final Utente user;

  const ReportStatsWidget({Key? key, required this.user}) : super(key: key);

  @override
  _ReportStatsWidgetState createState() => _ReportStatsWidgetState();
}

class _ReportStatsWidgetState extends State<ReportStatsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior3;
  late TooltipBehavior _tooltipBehavior4;
  late ZoomPanBehavior _zoomPanBehavior;
  DateTime? startDate;
  DateTime? endDate;
  String? dropDownChart;
  @override
  void initState() {
    _tooltipBehavior1 = TooltipBehavior(
      enable: true,
    );
    _tooltipBehavior2 = TooltipBehavior(
      enable: true,
    );
    _tooltipBehavior3 = TooltipBehavior(
      enable: true,
    );
    _tooltipBehavior4 = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    super.initState();
  }

  getData() async {
    if (startDate == null && endDate == null) {
      endDate = DateTime.now();
      startDate = endDate!.subtract(const Duration(days: 30));
    }

    var fIstance = FirebaseFirestore.instance.collection('user');

    QuerySnapshot docSnapshot = await fIstance
        .doc(Auth().currentUser!.uid)
        .collection('Pazienti')
        .doc(widget.user.userID)
        .collection('Report')
        .where('dataInizio', isLessThanOrEqualTo: Timestamp.fromDate(endDate!))
        .where('dataInizio',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate!))
        .orderBy('dataInizio', descending: false)
        .get();

    List<Report> reportData = [];

    for (var j = 0; j < docSnapshot.docs.length; j++) {
      var report = docSnapshot.docs[j].data() as Map<String, dynamic>?;
      reportData.add(Report(
          mappaRisposte: Map.from(report!['mappaRisposte']),
          tempoImpiegato: report['tempoImpiegato'],
          dataInizio: (report['dataInizio'] as Timestamp).toDate(),
          risposteCorrette: report['risposteCorrette'],
          risposteErrate: report['risposteErrate'],
          precisione: report['precisione'],
          reportID: report['reportID'],
          tipologia: report['tipologia'],
          categoria: report['categoria']));
    }

    if (reportData.isEmpty) {
      return null;
    }
    return reportData;
  }

  createChart(String categoria, List<Report> data) {
    List<Report> dataCategory = [];

    data.forEach((d) {
      if (d.categoria == categoria) {
        dataCategory.add(d);
      }
    });

    if (dataCategory.isEmpty) {
      return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
          child: Text('Non ci sono dati per questa categoria!',
              style: FlutterFlowTheme.of(context).bodyText2.override(
                    fontFamily: 'IBM Plex Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )));
    }
    Color color = Colors.black;
    TooltipBehavior tooltipBehavior = _tooltipBehavior1;
    switch (categoria) {
      case 'Persone':
        color = const Color(0xFF4589FF);
        tooltipBehavior = _tooltipBehavior1;
        break;
      case 'Animali':
        color = const Color(0xFF24A148);
        tooltipBehavior = _tooltipBehavior2;
        break;
      case 'Oggetti':
        color = const Color(0xFFEE5396);
        tooltipBehavior = _tooltipBehavior3;
        break;
      case 'Altro':
        color = const Color(0xFFA56EFF);
        tooltipBehavior = _tooltipBehavior4;
        break;
    }

    return SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        palette: <Color>[color],
        onTooltipRender: (tooltipArgs) {
          var dataCurrent = dataCategory[tooltipArgs.pointIndex!.toInt()];
          tooltipArgs.header = dataCurrent.categoria;
          var domandeTotali =
              dataCurrent.risposteCorrette + dataCurrent.risposteErrate;
          tooltipArgs.text =
              'Data: ${DateFormat('dd-MM-yyyy hh:mm aaa').format(dataCurrent.dataInizio).toString()}\nCorrette: ${dataCurrent.risposteCorrette}\nTotali: $domandeTotali';
        },
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
            maximumLabels: 6,
            visibleMaximum: 10,
            arrangeByIndex: true,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelStyle:
                const TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 10)),
        primaryYAxis: NumericAxis(
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
          maximumLabels: 2,
          maximum: 1.1,
        ),
        tooltipBehavior: tooltipBehavior,
        series: <ChartSeries>[
          dropDownChart == 'Grafico a barre'
              ? ColumnSeries<Report, String>(
                  dataSource: dataCategory,
                  xValueMapper: (Report data, _) =>
                      DateFormat('dd-MM-yyyy hh:mm aaa')
                          .format(DateTime.parse(data.dataInizio.toString()))
                          .toString(),
                  yValueMapper: (Report data, _) =>
                      double.parse((data.precisione.toStringAsFixed(2))),
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      useSeriesColor: true,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 12)))
              : LineSeries<Report, String>(
                  dataSource: dataCategory,
                  xValueMapper: (Report data, _) =>
                      DateFormat('dd-MM-yyyy hh:mm aaa')
                          .format(DateTime.parse(data.dataInizio.toString()))
                          .toString(),
                  yValueMapper: (Report data, _) =>
                      double.parse((data.precisione.toStringAsFixed(2))),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    useSeriesColor: true,
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 12),
                  ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70), child: AppbarcaregiverWidget()),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: SelectionArea(
                      child: Text(
                    "${widget.user.name} ${widget.user.lastname}",
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: SelectionArea(
                            child: Text(
                          'Invia report al medico:',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200,
                                  ),
                        )),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.email,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                    child: SelectionArea(
                        child: Text(
                      'Seleziona intervallo:',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'IBM Plex Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                          ),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFCFD4DB),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 5, 12, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    startDate == null
                                        ? 'Data di inizio'
                                        : DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(
                                                startDate.toString())),
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: const Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (date) {
                                        setState(() {
                                          startDate = date;
                                        });
                                      },
                                          currentTime: getCurrentTimestamp,
                                          minTime: DateTime(0, 0, 0),
                                          maxTime: DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                          ));
                                    },
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      color: Color(0xFF57636C),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFCFD4DB),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 5, 12, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  endDate == null
                                      ? 'Data di fine'
                                      : DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(endDate.toString())),
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: const Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                      setState(() {
                                        endDate = date;
                                      });
                                    },
                                        currentTime: getCurrentTimestamp,
                                        minTime: startDate,
                                        maxTime: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day + 1,
                                        ));
                                  },
                                  child: const Icon(
                                    Icons.date_range_outlined,
                                    color: Color(0xFF57636C),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                  child: FlutterFlowDropDown(
                    initialOption: dropDownChart ??= 'Grafico a barre',
                    options: const ['Grafico a linee', 'Grafico a barre'],
                    onChanged: (val) async {
                      setState(() {
                        dropDownChart = val;
                      });
                    },
                    width: double.infinity,
                    height: 50,
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                    fillColor: Colors.white,
                    elevation: 2,
                    borderColor: FlutterFlowTheme.of(context).borderColor,
                    borderWidth: 1,
                    borderRadius: 10,
                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                    hidesUnderline: true,
                  ),
                ),
                FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Report> data = snapshot.data as List<Report>;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Andamento Persone',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color: const Color(0xFF101213),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Container(
                                          decoration: const BoxDecoration(),
                                          clipBehavior: Clip.antiAlias,
                                          width: double.infinity,
                                          height: 400,
                                          child: createChart('Persone', data)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Andamento Animali',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color: const Color(0xFF101213),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Container(
                                          decoration: const BoxDecoration(),
                                          clipBehavior: Clip.antiAlias,
                                          width: double.infinity,
                                          height: 400,
                                          child: createChart('Animali', data)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Andamento Oggetti',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color: const Color(0xFF101213),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Container(
                                          decoration: const BoxDecoration(),
                                          clipBehavior: Clip.antiAlias,
                                          width: double.infinity,
                                          height: 400,
                                          child: createChart('Oggetti', data)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Andamento Altro',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color: const Color(0xFF101213),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Container(
                                          decoration: const BoxDecoration(),
                                          clipBehavior: Clip.antiAlias,
                                          width: double.infinity,
                                          height: 400,
                                          child: createChart('Altro', data)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.8, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: SelectionArea(
                                    child: Text(
                                  'Report quiz',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                )),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  for (var item in data)
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x55000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 16, 10, 16),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        'Categoria',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      item.categoria,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: const Color(
                                                                    0xFF101213),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        'Data',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat(
                                                              'dd-MM-yyyy hh:mm aaa')
                                                          .format(
                                                              item.dataInizio)
                                                          .toString(),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: const Color(
                                                                    0xFF101213),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        '#Corrette',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${item.risposteCorrette}/${item.risposteCorrette + item.risposteErrate}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: const Color(
                                                                    0xFF101213),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        'Tempo',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${(Duration(seconds: item.tempoImpiegato))}'
                                                          .split('.')[0]
                                                          .padLeft(8, '0'),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: const Color(
                                                                    0xFF101213),
                                                                fontSize: 13,
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
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
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
