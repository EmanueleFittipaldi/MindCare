import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/album_ricordi/album_ricordi.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:mindcare/model/utente.dart';
import 'package:mindcare/widget_tree.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/auth.dart';
import '../quiz/categoria.dart';
import '../autenticazione/login.dart';
import 'opzioni_paziente.dart';

class HomePazienteWidget extends StatefulWidget {
  const HomePazienteWidget({Key? key}) : super(key: key);

  @override
  _HomePazienteWidgetState createState() => _HomePazienteWidgetState();
}

class _HomePazienteWidgetState extends State<HomePazienteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String caregiverID = '';
  Utente? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
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
                      child: FutureBuilder(
                        future: UserController()
                            .getCaregiverID(Auth().currentUser!.uid),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            caregiverID = snapshot.data;
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(caregiverID)
                                  .collection('Pazienti')
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  var data;
                                  snapshot.data?.docs.forEach((doc) {
                                    //iterazione sui singoli documenti
                                    Map<String, dynamic>? cmap = doc.data();
                                    if (cmap!['userID'] ==
                                        Auth().currentUser!.uid) {
                                      data = cmap;
                                    } //mappatura dei dati
                                  });
                                  if (data != null) {
                                    user = Utente(
                                        userID: data['userID'],
                                        name: data['name'],
                                        lastname: data['lastname'],
                                        email: data['email'],
                                        type: data['type'],
                                        date:
                                            (data?['dateOfBirth'] as Timestamp)
                                                .toDate(),
                                        profileImgPath:
                                            data['profileImagePath'],
                                        checkBiometric: data['checkBiometric']);

                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              40, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 20, 0, 0),
                                            child: Container(
                                              width: 150,
                                              height: 150,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: data['profileImagePath'] !=
                                                      ''
                                                  ? Image.network(
                                                      data['profileImagePath'],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/add_photo.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 2, 2, 12),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.44,
                                              height: 190,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12, 8, 12, 8),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 12, 0, 0),
                                                      child: Text(
                                                        '${'Salve, ' + data['name']}!',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        'Quiz completati oggi',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Text(
                                                            'Progressi',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Text(
                                                            '2/8',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 8, 0, 0),
                                                      child:
                                                          LinearPercentIndicator(
                                                        percent: 0.2,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.38,
                                                        lineHeight: 12,
                                                        animation: true,
                                                        progressColor:
                                                            const Color(
                                                                0xFF4589FF),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .lineColor,
                                                        barRadius: const Radius
                                                            .circular(8),
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 15, 0),
                    child: SelectionArea(
                        child: Text(
                      'Questa è la tua schermata principale.\nCompleta un quiz oppure rivivi i tuoi ricordi!',
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
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 10, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SelezionaCategoriaWidget(
                                            user: user!,
                                            caregiverID: caregiverID)));
                              },
                              child: Container(
                                width: 100,
                                height: 190,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 12,
                                      color: Color(0x14000000),
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFF24A148),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: const Color(0x00FFFFFF),
                                        borderRadius: 0,
                                        borderWidth: 0,
                                        buttonSize: 100,
                                        icon: FaIcon(
                                          FontAwesomeIcons.question,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 50,
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelezionaCategoriaWidget(
                                                          user: user!,
                                                          caregiverID:
                                                              caregiverID)));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: SelectionArea(
                                            child: Text(
                                          'Quiz',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 40,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AlbumRicordiWidget(
                                      caregiverUID: caregiverID, user: user!)));
                            },
                            child: Container(
                              width: 100,
                              height: 190,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 12,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 5, 0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFFEE5396),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: const Color(0x00FFFFFF),
                                        borderRadius: 0,
                                        borderWidth: 0,
                                        buttonSize: 100,
                                        icon: Icon(
                                          Icons.photo_camera,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 50,
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AlbumRicordiWidget(
                                                          caregiverUID:
                                                              caregiverID,
                                                          user: user!)));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: SelectionArea(
                                            child: Text(
                                          'Album',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 40,
                                              ),
                                        )),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 10, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 190,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 12,
                                      color: Color(0x14000000),
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFFA56EFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: const Color(0x00FFFFFF),
                                        borderRadius: 0,
                                        borderWidth: 0,
                                        buttonSize: 100,
                                        icon: FaIcon(
                                          FontAwesomeIcons.penRuler,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 50,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: SelectionArea(
                                            child: Text(
                                          'Da fare',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 40,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 190,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 12,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 5, 0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFFE16D4E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: const Color(0x00FFFFFF),
                                        borderRadius: 0,
                                        borderWidth: 0,
                                        buttonSize: 100,
                                        icon: FaIcon(
                                          FontAwesomeIcons.handshakeAngle,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 50,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: SelectionArea(
                                            child: Text(
                                          'SOS',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 40,
                                              ),
                                        )),
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
