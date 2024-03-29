import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/gestione_SOS/sos_caregiver.dart';
import 'package:mindcare/gestione_quiz/gestione_quiz.dart';
import 'package:mindcare/gestione_report/seleziona_report.dart';
import 'package:mindcare/gestione_todolist/gestione_todolist.dart';
import 'package:mindcare/model/utente.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';

import '../gestione_ricordi/gestione_album.dart';

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
    DateTime now = DateTime.now();
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
                    height: 230,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 2, 2, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: AutoSizeText(
                                          '${widget.user.name} ${widget.user.lastname}',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .title2
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )),
                                        AutoSizeText(
                                          DateFormat("dd-MM-yyyy")
                                              .format(widget.user.date),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 0, 0),
                                            child: AutoSizeText(
                                              getAge() + ' anni',
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 0, 0),
                                            child: AutoSizeText(
                                              widget.user.email,
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 40, 0),
                              child: Container(
                                width: 130,
                                height: 130,
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
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 5),
                            child: SelectionArea(
                                child: AutoSizeText(
                              'Gestisci tutti i dati associati al paziente',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: Text(
                      'Gestisci paziente',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'IBM Plex Sans',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 19,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
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
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: const [
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'Quiz',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
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
                                          SelectionArea(
                                              child: Text(
                                            'Aggiungi o elimina quiz',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(110),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(110),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_questions_re_1fy7.svg',
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      GestioneAlbumWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: const [
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'Album',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
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
                                          SelectionArea(
                                              child: Text(
                                            'Aggiungi o elimina ricordi',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(110),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(110),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_moments_0y20.svg',
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SelezionaReportWidget(
                                      user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: const [
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'Report',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
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
                                          SelectionArea(
                                              child: Text(
                                            'Visualizza andamento paziente',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(110),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(110),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_data_report_re_p4so.svg',
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ToDoListWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: const [
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'Da Fare',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
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
                                          SelectionArea(
                                              child: Text(
                                            'Aggiungi o elimina attività',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(110),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(110),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_to_do_list_re_9nt7.svg',
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      //voglio passare a GestioneQuizWidget lo stesso
                                      //user che ho ricevuto da home_caregiver
                                      SOSCaregiverWidget(user: widget.user)));
                            },
                            child: Container(
                              width: 100,
                              height: 160,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                boxShadow: const [
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'SOS',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
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
                                          SelectionArea(
                                              child: Text(
                                            'Aggiunti contatti',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(110),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD0E2FF),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(110),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(30),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 10),
                                        child: SvgPicture.asset(
                                          'assets/images/undraw_people_search_re_5rre.svg',
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
