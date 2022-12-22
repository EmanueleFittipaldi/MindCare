import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/gestione_report/view_domande.dart';
import 'package:mindcare/model/utente.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/model/report.dart';

class ViewReport extends StatefulWidget {
  final Utente user;
  final List<Report> data;

  const ViewReport({
    Key? key,
    required this.user,
    required this.data,
  }) : super(key: key);

  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  createChart(List<ChartData> selectedData) {
    return SfCircularChart(
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            padding: 2,
            itemPadding: 10,
            orientation: LegendItemOrientation.horizontal),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
              dataSource: selectedData,
              xValueMapper: (ChartData data, _) => data.type,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelSettings: DataLabelSettings(
                  // Renders the data label
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  useSeriesColor: true,
                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'IBM Plex Sans',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 12)))
        ]);
  }

  getEmoticon(umore) {
    String image = '';
    switch (umore) {
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
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Report',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var item in widget.data)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Color(0x14000000),
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 5, 0, 0),
                                            child: Text(
                                              'Categoria:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            '${item.categoria}',
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 5, 0, 0),
                                            child: Text(
                                              'Tipologia:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            '${item.tipologia}',
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 5, 0, 0),
                                            child: Text(
                                              'Data completato:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 5, 0, 0),
                                          child: Text(
                                            DateFormat('dd-MM-yyyy HH:mm')
                                                .format(item.dataInizio)
                                                .toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 5, 16, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tempo impiegato:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF101213),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                              ),
                                              Text(
                                                '${(Duration(seconds: item.tempoImpiegato))}'
                                                    .split('.')[0]
                                                    .padLeft(8, '0'),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF101213),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 5, 0, 0),
                                            child: Text(
                                              'Totale domande:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            (item.risposteCorrette +
                                                    item.risposteErrate)
                                                .toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 200,
                                            height: 50,
                                            child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 5,
                                                                    0, 0),
                                                        child: Text(
                                                          'Umore:',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: Color(
                                                                    0xFF101213),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Image.network(
                                                      getEmoticon(item.umore),
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ])),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 15, 0, 0),
                                            child: Container(
                                                width: 200,
                                                height: 150,
                                                child: createChart([
                                                  ChartData('Corrette',
                                                      item.risposteCorrette),
                                                  ChartData('Sbagliate',
                                                      item.risposteErrate),
                                                ]))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ViewDomande(
                                                uid: widget.user.userID,
                                                mappaRisposte:
                                                    item.mappaRisposte)));
                                  },
                                  text: 'Visualizza domande',
                                  options: FFButtonOptions(
                                    width: 160,
                                    height: 50,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 0,
                                    ),
                                    elevation: 0,
                                    borderRadius: 30,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.type, this.value);
  final String type;
  final int value;
}
