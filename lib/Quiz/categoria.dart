import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/quiz/tipologia.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../autenticazione/login.dart';
import '../model/utente.dart';

class SelezionaCategoriaWidget extends StatefulWidget {
  final Utente user;
  final String caregiverID;
  const SelezionaCategoriaWidget(
      {Key? key, required this.user, required this.caregiverID})
      : super(key: key);

  @override
  _SelezionaCategoriaWidgetState createState() =>
      _SelezionaCategoriaWidgetState();
}

class _SelezionaCategoriaWidgetState extends State<SelezionaCategoriaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppbarWidget(
            title: 'Quiz',
          )),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x14000000),
                        offset: Offset(0, 5),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(155),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 35, 0, 0),
                        child: SelectionArea(
                            child: Text(
                          'Ciao! Seleziona la\ncategoria di quiz che\nvorresti svolgere.\n',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  ),
                        )),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Container(
                          width: 220,
                          height: 220,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/doctorCategoria.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            width: 100,
                            height: 190,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Color(0x14000000),
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4589FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: FlutterFlowIconButton(
                                    borderColor: Color(0x00FFFFFF),
                                    borderRadius: 0,
                                    borderWidth: 0,
                                    buttonSize: 140,
                                    icon: Icon(
                                      Icons.family_restroom,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 80,
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelezionaTipologiaWidget(
                                                      user: widget.user,
                                                      categoria: 'Persone',
                                                      caregiverID:
                                                          widget.caregiverID)));
                                    },
                                  )),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 25),
                                    child: SelectionArea(
                                        child: Text(
                                      'Persone',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            fontSize: 20,
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Color(0x14000000),
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFF24A148),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 140,
                                  icon: FaIcon(
                                    FontAwesomeIcons.dog,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 80,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelezionaTipologiaWidget(
                                                    user: widget.user,
                                                    categoria: 'Animali',
                                                    caregiverID:
                                                        widget.caregiverID)));
                                  },
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 25),
                                  child: SelectionArea(
                                      child: Text(
                                    'Animali',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 20,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Color(0x14000000),
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFEE5396),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: FlutterFlowIconButton(
                                  borderColor: Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 140,
                                  icon: Icon(
                                    Icons.handyman,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 80,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelezionaTipologiaWidget(
                                                    user: widget.user,
                                                    categoria: 'Oggetti',
                                                    caregiverID:
                                                        widget.caregiverID)));
                                  },
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 25),
                                  child: SelectionArea(
                                      child: Text(
                                    'Oggetti',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 20,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            width: 100,
                            height: 190,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Color(0x14000000),
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFA56EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: FlutterFlowIconButton(
                                    borderColor: Color(0x00FFFFFF),
                                    borderRadius: 0,
                                    borderWidth: 0,
                                    buttonSize: 140,
                                    icon: FaIcon(
                                      FontAwesomeIcons.boxOpen,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 80,
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelezionaTipologiaWidget(
                                                      user: widget.user,
                                                      categoria: 'Altro',
                                                      caregiverID:
                                                          widget.caregiverID)));
                                    },
                                  )),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 25),
                                    child: SelectionArea(
                                        child: Text(
                                      'Altro',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            fontSize: 20,
                                          ),
                                    )),
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
