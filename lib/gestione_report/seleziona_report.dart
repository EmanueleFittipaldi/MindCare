import 'package:mindcare/gestione_report/gestione_report.dart';
import 'package:mindcare/gestione_report/gestione_umore.dart';
import 'package:mindcare/model/utente.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelezionaReportWidget extends StatefulWidget {
  final Utente user;
  const SelezionaReportWidget({Key? key, required this.user}) : super(key: key);

  @override
  _SelezionaReportWidgetState createState() => _SelezionaReportWidgetState();
}

class _SelezionaReportWidgetState extends State<SelezionaReportWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFECF4FF),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).secondaryText),
        automaticallyImplyLeading: true,
        title: Text(
          'Report',
          style: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'IBM Plex Sans',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                  child: Text(
                    'Seleziona l\'andamento di interesse',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ReportQuizStatsWidget(user: widget.user)));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 100,
                              height: 200,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReportQuizStatsWidget(
                                                                user: widget
                                                                    .user)));
                                              },
                                              child: SelectionArea(
                                                  child: AutoSizeText(
                                                'Andamento quiz',
                                                textAlign: TextAlign.start,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                              )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 15, 0, 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReportQuizStatsWidget(
                                                                  user: widget
                                                                      .user)));
                                                },
                                                child: SelectionArea(
                                                    child: AutoSizeText(
                                                  'Visualizza l\'andamento del paziente in base ai quiz completati',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(400),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(400),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 10, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_projections_re_ulc6.svg',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UmoreStatsWidget(user: widget.user)));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 100,
                              height: 200,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: SelectionArea(
                                                child: AutoSizeText(
                                              'Andamento umore',
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 15, 0, 10),
                                              child: SelectionArea(
                                                  child: AutoSizeText(
                                                'Visualizza l\'andamento dell\'umore del paziente in un determinato periodo di tempo',
                                                textAlign: TextAlign.start,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(400),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(400),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 10, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_predictive_analytics_re_wxt8.svg',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }
}
