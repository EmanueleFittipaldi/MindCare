import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/gestione_SOS/sos_caregiver.dart';
import 'package:mindcare/gestione_quiz/gestione_quiz.dart';
import 'package:mindcare/model/utente.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../gestione_report/gestione_report.dart';
import '../gestione_ricordi/gestione_album.dart';
import 'dati_paziente.dart';

class DashboardPazienteWidget extends StatefulWidget {
  final Utente user;
  const DashboardPazienteWidget({Key? key, required this.user})
      : super(key: key);

  @override
  _DashboardPazienteWidgetState createState() =>
      _DashboardPazienteWidgetState();
}

class _DashboardPazienteWidgetState extends State<DashboardPazienteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  getAge() {
    DateTime now = new DateTime.now();
    int age = now.year - widget.user.date.year;

    if (now.month < widget.user.date.month) {
      age--;
    } else if (now.month == widget.user.date.month) {
      if (now.day < widget.user.date.day) {
        age--;
      }
    }
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(title: 'Paziente'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).backgroundPrimaryColor,
            ),
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
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12,
                          color: Color(0x14000000),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(155),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 0),
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: widget.user.profileImgPath != ''
                                  ? Image.network(
                                      widget.user.profileImgPath,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/add_photo.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 40, 0, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      '${widget.user.name} ${widget.user.lastname}',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .title2
                                          .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontWeight: FontWeight.normal),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      DateFormat("dd-MM-yyyy")
                                          .format(widget.user.date),
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      getAge() + ' anni',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      widget.user.email,
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                    child: SelectionArea(
                        child: Text(
                      'Gestisci paziente',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'IBM Plex Sans',
                            fontSize: 19,
                            fontWeight: FontWeight.w300,
                          ),
                    )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      //voglio passare a GestioneQuizWidget lo stesso
                                      //user che ho ricevuto da home_caregiver
                                      GestionQuizWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 5),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Quiz',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Aggiungi o elimina quiz',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00FFFFFF),
                                          borderRadius: 0,
                                          borderWidth: 0,
                                          buttonSize: 120,
                                          icon: FaIcon(
                                            FontAwesomeIcons.question,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            size: 40,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        //voglio passare a GestioneQuizWidget lo stesso
                                                        //user che ho ricevuto da home_caregiver
                                                        GestionQuizWidget(
                                                            user:
                                                                widget.user)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      GestioneAlbumWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Card(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 5),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Album',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Aggiungi o elimina ricordi',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00FFFFFF),
                                          borderRadius: 0,
                                          borderWidth: 0,
                                          buttonSize: 120,
                                          icon: FaIcon(
                                            Icons.photo_camera,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: 40,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GestioneAlbumWidget(
                                                            user:
                                                                widget.user)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ReportStatsWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 5),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Report',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Visualizza andamento paziente',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00FFFFFF),
                                          borderRadius: 0,
                                          borderWidth: 0,
                                          buttonSize: 120,
                                          icon: FaIcon(
                                            FontAwesomeIcons.chartLine,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            size: 40,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportStatsWidget(
                                                            user:
                                                                widget.user)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 5),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Da Fare',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Aggiungi o elimina attività',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00FFFFFF),
                                          borderRadius: 0,
                                          borderWidth: 0,
                                          buttonSize: 120,
                                          icon: FaIcon(
                                            FontAwesomeIcons.pencilRuler,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: 40,
                                          ),
                                          onPressed: () async {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 5),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'SOS',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: SelectionArea(
                                                    child: Text(
                                                  'Aggiungi contatti',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 15, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0x00FFFFFF),
                                          borderRadius: 0,
                                          borderWidth: 0,
                                          buttonSize: 120,
                                          icon: FaIcon(
                                            FontAwesomeIcons.handshakeAngle,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            size: 40,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SOSCaregiverWidget(
                                                            user:
                                                                widget.user)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
