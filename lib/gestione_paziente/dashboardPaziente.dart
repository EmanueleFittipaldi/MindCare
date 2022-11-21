import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'datiPaziente.dart';
import '../homeCaregiver.dart';
import '../login.dart';
import '../opzioni.dart';

class DashboardPazienteWidget extends StatefulWidget {
  const DashboardPazienteWidget({Key? key}) : super(key: key);

  @override
  _DashboardPazienteWidgetState createState() =>
      _DashboardPazienteWidgetState();
}

class _DashboardPazienteWidgetState extends State<DashboardPazienteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xFFEBF9FF),
                    size: 30,
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeCaregiverWidget()));
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'MindCare',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.settings,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        size: 30,
                      ),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OpzioniWidget()));
                      },
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.logout,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        size: 30,
                      ),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginWidget()));
                      },
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 2,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(155),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Container(
                          width: 150,
                          height: 150,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://procedural-generation.isaackarth.com/tumblr_files/tumblr_pnpkvnwpWI1uo5d9jo5_1280.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                        child: SelectionArea(
                            child: Text(
                          'Giuseppe Giglio',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'IBM Plex Sans',
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                fontSize: 30,
                              ),
                        )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFF24A148),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: FaIcon(
                                    FontAwesomeIcons.question,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () async {
                                    //context.pushNamed('GestioneQuiz');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Gestione quiz',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
                                        ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFEE5396),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () async {
                                    //context.pushNamed('GestioneAlbum');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Gestione album',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
                                        ),
                                  )),
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFFF832B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: FaIcon(
                                    FontAwesomeIcons.chartLine,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () async {
                                    //context.pushNamed('ReportQuiz');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Gestione report',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
                                        ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFF919191),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: Icon(
                                    Icons.info_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DatiPazienteWidget()));
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Info paziente',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
                                        ),
                                  )),
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
            ),
          ),
        ),
      ),
    );
  }
}
