import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/gestione_report/view_domande.dart';
import 'package:mindcare/model/umore.dart';
import 'package:mindcare/model/utente.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ViewUmore extends StatefulWidget {
  final Utente user;
  final List<Umore> data;

  const ViewUmore({
    Key? key,
    required this.user,
    required this.data,
  }) : super(key: key);

  @override
  _ViewUmoreState createState() => _ViewUmoreState();
}

class _ViewUmoreState extends State<ViewUmore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
          title: 'Risposte umore',
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
                                              'Tipologia risposta:',
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
                                            '${item.type}',
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
                                              'Data risposta:',
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
                                                .format(item.data)
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
                                                'Score:',
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
                                                '${item.score}',
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
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 130,
                                          child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Text(
                                                        'Risposta:',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                  item.type == 'quiz'
                                                      ? Image.network(
                                                          getEmoticon(
                                                              item.score),
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      5, 0, 0),
                                                          child: AutoSizeText(
                                                            '${item.text}',
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
                                                ]),
                                          ),
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
