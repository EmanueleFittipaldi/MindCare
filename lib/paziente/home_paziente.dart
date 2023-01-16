import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindcare/Quiz/dialog_umore.dart';
import 'package:mindcare/album_ricordi/album_ricordi.dart';
import 'package:mindcare/controller/report_controller.dart';
import 'package:mindcare/controller/umore_controller.dart';
import 'package:mindcare/gestione_SOS/sos_paziente.dart';
import 'package:mindcare/model/utente.dart';
import 'package:mindcare/Quiz/seleziona_quiz.dart';
import 'package:mindcare/todolist/todolist.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/auth.dart';

class HomePazienteWidget extends StatefulWidget {
  final String caregiverUID;
  const HomePazienteWidget({Key? key, required this.caregiverUID})
      : super(key: key);

  @override
  _HomePazienteWidgetState createState() => _HomePazienteWidgetState();
}

class _HomePazienteWidgetState extends State<HomePazienteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Utente? user;
  bool checkHumor = false;
  Future? futureQuizCompletati;
  Stream<QuerySnapshot>? _patientStream;
  @override
  void initState() {
    _patientStream = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.caregiverUID)
        .collection('Pazienti')
        .snapshots();
    futureQuizCompletati = ReportController()
        .getQuizCompletati(widget.caregiverUID, Auth().currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
          automaticallyImplyLeading: false,
          actions: const [],
          leading: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Logo_MindCare.jpg',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              'MindCare',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'IBM Plex Sans',
                    color: FlutterFlowTheme.of(context).primaryColor,
                    fontSize: 28,
                  ),
            ),
          ),
          elevation: 0,
        ),
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
                      child: StreamBuilder(
                        stream: _patientStream,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              // ignore: prefer_typing_uninitialized_variables
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
                                    date: (data?['dateOfBirth'] as Timestamp)
                                        .toDate(),
                                    profileImgPath: data['profileImagePath'],
                                    checkBiometric: data['checkBiometric']);

                                return FutureBuilder(
                                    future: futureQuizCompletati,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        int percent = snapshot.data;

                                        /*QUANDO FUTURE BUILDER HA TERMINATO VERIFICA L'UMORE: */
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) async {
                                          await Hive.initFlutter();
                                          var box = await Hive.openBox('temp');

                                          var bool = await UmoreController()
                                              .checkUmore(widget.caregiverUID,
                                                  Auth().currentUser!.uid);

                                          if (!bool) {
                                            if (box.get('umore') == null ||
                                                box.get('umore') == 'false') {
                                              box.put('umore', 'true');

                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () async {
                                                var text = await showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DialogUmore(
                                                          title:
                                                              'Ciao ${user!.name}!',
                                                          message:
                                                              'Come ti senti oggi?');
                                                    });
                                                if (text != '') {
                                                  UmoreController().createUmore(
                                                      widget.caregiverUID,
                                                      Auth().currentUser!.uid,
                                                      text,
                                                      'giornaliero');
                                                }
                                              });
                                            }
                                          } else {
                                            box.put('umore', 'false');
                                          }
                                        });
                                        return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            15, 2, 2, 0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      height: 160,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                12, 8, 12, 8),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      12,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                'Salve,',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle1
                                                                    .override(
                                                                      fontFamily:
                                                                          'IBM Plex Sans',
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${data['name']}!',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .subtitle1
                                                                  .override(
                                                                    fontFamily:
                                                                        'IBM Plex Sans',
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      4,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                'Quiz completati oggi',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'IBM Plex Sans',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Progressi: ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2
                                                                        .override(
                                                                          fontFamily:
                                                                              'IBM Plex Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          5,
                                                                          4,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '$percent/8',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2
                                                                        .override(
                                                                          fontFamily:
                                                                              'IBM Plex Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      8,
                                                                      0,
                                                                      0),
                                                              child:
                                                                  LinearPercentIndicator(
                                                                percent:
                                                                    (1 / 8) *
                                                                        percent,
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
                                                                barRadius:
                                                                    const Radius
                                                                        .circular(8),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 20, 30, 0),
                                                      child: Container(
                                                        width: 130,
                                                        height: 130,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child:
                                                            data['profileImagePath'] !=
                                                                    ''
                                                                ? Image.network(
                                                                    data[
                                                                        'profileImagePath'],
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/add_photo.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          20, 0, 20, 5),
                                                  child: SelectionArea(
                                                      child: AutoSizeText(
                                                    'Questa è la tua schermata principale.\nCompleta un quiz oppure rivivi i tuoi ricordi!',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  )),
                                                ),
                                              ),
                                            ]);
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    });
                              }
                            }
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
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
                                    builder: (context) => SelezionaQuizWidget(
                                        user: user!,
                                        caregiverID: widget.caregiverUID)));
                              },
                              child: Container(
                                width: 100,
                                height: 180,
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
                                      Expanded(
                                        child: FlutterFlowIconButton(
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
                                                        SelezionaQuizWidget(
                                                            user: user!,
                                                            caregiverID: widget
                                                                .caregiverUID)));
                                          },
                                        ),
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
                                      caregiverUID: widget.caregiverUID,
                                      user: user!)));
                            },
                            child: Container(
                              width: 100,
                              height: 180,
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
                                      Expanded(
                                        child: FlutterFlowIconButton(
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
                                                            caregiverUID: widget
                                                                .caregiverUID,
                                                            user: user!)));
                                          },
                                        ),
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
                                height: 180,
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
                                      Expanded(
                                        child: FlutterFlowIconButton(
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
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ToDoListPazienteWidget(
                                                            user: user!,
                                                            caregiverID: widget
                                                                .caregiverUID)));
                                          },
                                        ),
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
                              height: 180,
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
                                      Expanded(
                                        child: FlutterFlowIconButton(
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SosWidget(
                                                          caregiverUID: widget
                                                              .caregiverUID,
                                                          user: user!,
                                                        )));
                                          },
                                        ),
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
