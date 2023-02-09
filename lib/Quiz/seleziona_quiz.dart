import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindcare/Quiz/quiz_img_a_nome.dart';
import 'package:mindcare/Quiz/quiz_nome_a_img.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../model/utente.dart';

class SelezionaQuizWidget extends StatefulWidget {
  final Utente user;
  final String caregiverID;
  const SelezionaQuizWidget(
      {Key? key, required this.user, required this.caregiverID})
      : super(key: key);

  @override
  _SelezionaQuizWidgetState createState() => _SelezionaQuizWidgetState();
}

class _SelezionaQuizWidgetState extends State<SelezionaQuizWidget> {
  PageController? pageViewController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String categorySelected = 'Persone';
  String tiplogySelected = 'Associa l\'immagine al nome';
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppbarWidget(
            title: 'Quiz',
          )),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 20, 20, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 20, 10),
                                  child: Text(
                                    'Seleziona una categoria',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 15),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        categorySelected = 'Persone';
                                      });
                                      await pageViewController?.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: categorySelected == 'Persone'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Persone',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Persone'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Riconosci i tuoi cari',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Persone'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(110),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(110),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_family_vg76.svg',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 15),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        categorySelected = 'Animali';
                                      });
                                      await pageViewController?.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: categorySelected == 'Animali'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Animali',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Animali'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Riconosci i tuoi animali',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Animali'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(110),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(110),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_dog_re_63j1.svg',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 14),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        categorySelected = 'Oggetti';
                                      });
                                      await pageViewController?.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: categorySelected == 'Oggetti'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Oggetti',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Oggetti'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Riconosci gli oggetti del tuo mestiere',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected == 'Oggetti'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(110),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(110),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_collecting_re_lp6p.svg',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 15),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        categorySelected = 'Altro';
                                      });
                                      await pageViewController?.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: categorySelected == 'Altro'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Altro',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected ==
                                                                      'Altro'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Riconosci cose di tuo interesse',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: categorySelected ==
                                                                      'Altro'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(110),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(110),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_specs_re_546x.svg',
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Vai a tipologia',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await pageViewController?.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 20, 20, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 20, 10),
                                  child: Text(
                                    'Seleziona una tipologia',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 15),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        tiplogySelected =
                                            'Associa l\'immagine al nome';
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: tiplogySelected ==
                                                'Associa l\'immagine al nome'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Associa l\'immagine al nome',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: tiplogySelected ==
                                                                      'Associa l\'immagine al nome'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Selezionare l\'immagine in base al nome mostrato nella domanda',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: tiplogySelected ==
                                                                      'Associa l\'immagine al nome'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(250),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(80),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(250),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(80),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 10, 0, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_choose_re_7d5a.svg',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 2, 15),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        tiplogySelected =
                                            'Associa il nome all\'immagine';
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: tiplogySelected ==
                                                'Associa il nome all\'immagine'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryColor
                                            : FlutterFlowTheme.of(context)
                                                .tertiaryColor,
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Associa il nome all\'immagine',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: tiplogySelected ==
                                                                      'Associa il nome all\'immagine'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Selezionare la risposta esatta in base all\'immagine mostrata nella domanda',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'IBM Plex Sans',
                                                              color: tiplogySelected ==
                                                                      'Associa il nome all\'immagine'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryColor
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                bottomLeft:
                                                    Radius.circular(250),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(80),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Container(
                                              width: 150,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFD0E2FF),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(250),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(80),
                                                  topRight: Radius.circular(30),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        0, 10, 10, 10),
                                                child: SvgPicture.asset(
                                                  'assets/images/undraw_image_options_7uph.svg',
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await pageViewController?.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                    Text(
                                      'Vai a categoria',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      40, 40, 40, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await Hive.initFlutter();
                                      var box = await Hive.openBox('quiz');
                                      if (tiplogySelected ==
                                          'Associa il nome all\'immagine') {
                                        if (box.get('statoCorrente') == null ||
                                            (box.get('statoCorrente') != null &&
                                                    (box.get('statoCorrente')[
                                                            'categoria']) !=
                                                        categorySelected ||
                                                box.get('statoCorrente')[
                                                        'tipologia'] !=
                                                    tiplogySelected)) {
                                          var quesiti = await QuizController()
                                              .getRandomQuesiti(
                                                  categorySelected,
                                                  tiplogySelected,
                                                  widget.user.userID,
                                                  widget.caregiverID);

                                          if (quesiti.isEmpty) {
                                            // ignore: use_build_context_synchronously
                                            PanaraInfoDialog.show(
                                              context,
                                              title: "Quiz",
                                              message: "Non ci sono domande!",
                                              buttonText: "Okay",
                                              onTapDismiss: () {
                                                Navigator.pop(context);
                                              },
                                              panaraDialogType:
                                                  PanaraDialogType.warning,
                                              barrierDismissible:
                                                  false, // optional parameter (default is true)
                                            );
                                          } else {
                                            Map<String, dynamic> statoCorrente =
                                                {
                                              'categoria': categorySelected,
                                              'tipologia': tiplogySelected,
                                              'indexQuesito': 0,
                                              'mappaRisposte': {},
                                              'countTentativi': quesiti[0]
                                                  ['numeroTentativi'],
                                              'inizioTempo': DateTime.now(),
                                              'percentualeBarra': 0.0,
                                              'quesiti': quesiti,
                                              'caregiverID': widget.caregiverID,
                                              'userID': widget.user.userID
                                            };
                                            box.put(
                                                'statoCorrente', statoCorrente);
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NomeAImmagineWidget(
                                                            box: box,
                                                            user:
                                                                widget.user)));
                                          }
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NomeAImmagineWidget(
                                                          box: box,
                                                          user: widget.user)));
                                        }
                                      } else if (tiplogySelected ==
                                          'Associa l\'immagine al nome') {
                                        if (box.get('statoCorrente') == null ||
                                            (box.get('statoCorrente') != null &&
                                                    (box.get('statoCorrente')[
                                                            'categoria']) !=
                                                        categorySelected ||
                                                box.get('statoCorrente')[
                                                        'tipologia'] !=
                                                    tiplogySelected)) {
                                          var quesiti = await QuizController()
                                              .getRandomQuesiti(
                                                  categorySelected,
                                                  tiplogySelected,
                                                  widget.user.userID,
                                                  widget.caregiverID);

                                          if (quesiti.isEmpty) {
                                            // ignore: use_build_context_synchronously
                                            PanaraInfoDialog.show(
                                              context,
                                              title: "Quiz",
                                              message: "Non ci sono domande!",
                                              buttonText: "Okay",
                                              onTapDismiss: () {
                                                Navigator.pop(context);
                                              },
                                              panaraDialogType:
                                                  PanaraDialogType.warning,
                                              barrierDismissible:
                                                  false, // optional parameter (default is true)
                                            );
                                          } else {
                                            Map<String, dynamic> statoCorrente =
                                                {
                                              'categoria': categorySelected,
                                              'tipologia': tiplogySelected,
                                              'indexQuesito': 0,
                                              'mappaRisposte': {},
                                              'countTentativi': quesiti[0]
                                                  ['numeroTentativi'],
                                              'inizioTempo': DateTime.now(),
                                              'percentualeBarra': 0.0,
                                              'quesiti': quesiti,
                                              'caregiverID': widget.caregiverID,
                                              'userID': widget.user.userID
                                            };
                                            box.put(
                                                'statoCorrente', statoCorrente);
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImmagineANomeWidget(
                                                            box: box,
                                                            user:
                                                                widget.user)));
                                          }
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImmagineANomeWidget(
                                                          box: box,
                                                          user: widget.user)));
                                        }
                                      }
                                    },
                                    text: 'Inizia!',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 60,
                                      color: const Color(0xFF32C157),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 30,
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }
}
