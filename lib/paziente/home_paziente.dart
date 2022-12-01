import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/album_ricordi/album_ricordi.dart';
import 'package:mindcare/utente.dart';
import 'package:mindcare/widget_tree.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth.dart';
import '../quiz/categoria.dart';
import '../login.dart';

class HomePazienteWidget extends StatefulWidget {
  const HomePazienteWidget({Key? key}) : super(key: key);

  @override
  _HomePazienteWidgetState createState() => _HomePazienteWidgetState();
}

class _HomePazienteWidgetState extends State<HomePazienteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String caregiverID = '';
  Utente? user;
  Future<Object?> getData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .get(); //ottenimento di tutti i documenti nella collezione user

    for (var i = 0; i < snapshot.docs.length; i++) {
      var caregiverMap = snapshot.docs[i].data() as Map<String, dynamic>?;
      //ciclo sui pazienti del caregiver
      QuerySnapshot snapshotPat = await FirebaseFirestore.instance
          .collection('user')
          .doc(caregiverMap!['userID'])
          .collection('Pazienti')
          .get(); //ottengo la collezione del caregiver dato dall'UID salvato nel campo
      for (var j = 0; j < snapshotPat.docs.length; j++) {
        var patientMap = snapshotPat.docs[j].data() as Map<String, dynamic>?;
        if (patientMap!['userID'] == Auth().currentUser!.uid) {
          //se l'userID nel documento dei pazienti è uguale a quello loggato
          //creazione di UTENTE inserendo i dati
          caregiverID = caregiverMap['userID'];
          return caregiverID;
        }
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'MindCare',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                  ),
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
                    Auth().signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WidgetTree()));
                  },
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
                    height: 300,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(155),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
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
                                      date: (data?['dateOfBirth'] as Timestamp)
                                          .toDate(),
                                      profileImgPath: data['profileImagePath']);

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 15, 0, 0),
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: data['profileImagePath'] != ''
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
                                            .fromSTEB(15, 10, 0, 0),
                                        child: SelectionArea(
                                            child: Text(
                                          '${'Salve, ' + data['name']}!',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 30,
                                              ),
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(50, 0, 15, 0),
                                        child: SelectionArea(
                                            child: Text(
                                          'Questa è la tua schermata principale.\nCompleta un quiz oppure rivivi i tuoi ricordi!',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        )),
                                      ),
                                    ],
                                  );
                                }
                              }
                              return Text('');
                            },
                          );
                        } else {
                          return Text('');
                        }
                      },
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFF24A148),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelezionaCategoriaWidget(
                                                    user: user!,
                                                    caregiverID: caregiverID)));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Quiz',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
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
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFFEE5396),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AlbumRicordiWidget()));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Album',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFFA56EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: FaIcon(
                                    FontAwesomeIcons.penRuler,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () {},
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Da fare',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
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
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFFE16D4E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 120,
                                  icon: FaIcon(
                                    FontAwesomeIcons.handshakeAngle,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () {},
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'SOS',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
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
