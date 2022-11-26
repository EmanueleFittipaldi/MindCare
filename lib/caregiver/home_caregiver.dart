import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mindcare/auth.dart';
import 'package:mindcare/utente.dart';
import 'package:mindcare/widget_tree.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../gestione_paziente/aggiunta_paziente.dart';
import '../gestione_paziente/dashboard_paziente.dart';
import '../login.dart';
import 'opzioni.dart';

class HomeCaregiverWidget extends StatefulWidget {
  const HomeCaregiverWidget({Key? key}) : super(key: key);

  @override
  _HomeCaregiverWidgetState createState() => _HomeCaregiverWidgetState();
}

class _HomeCaregiverWidgetState extends State<HomeCaregiverWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //funzione che permette di ottenere i dati dal database.
  //invocata in FutureBuilder, per caricare dapprima i dati del caregiver
  Future<Object?> getCaregiverData() async {
    //ottenimento della collezione 'user'
    var user = FirebaseFirestore.instance.collection('user');
    var userSnap = await user
        .doc(Auth().currentUser?.uid)
        .get(); //documento del caregiver -> userID autenticato
    if (userSnap.exists) {
      Map<String, dynamic>? userMap =
          userSnap.data(); //mappatura dei dati prelevati

      //user.doc(Auth().currentUser?.uid).snapshots().listen((event) {
      //  setState(() {});
      //});
      return userMap;
    }
  }

  //funzione per eliminare un paziente e la sua immagine salvate nello storage
  Future<void> deletePatient(patientUID, imgPath) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(patientUID); //riferimento al documento da eliminare
    await FirebaseFirestore.instance
        .runTransaction((Transaction deleteTransaction) async {
      deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
    });
    if (imgPath != '') {
      await FirebaseStorage.instance
          .refFromURL(imgPath)
          .delete(); //eliminazione immagine
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: const [],
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
                        Auth().signOut();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WidgetTree()));
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
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: double.infinity,
                    height: 250,
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
                      //FutureBuilder per caricare i dati del caregiver
                      future: getCaregiverData(), //funzione per ottenere i dati
                      builder: (context, snapshot) {
                        //costruzione degli widget dopo che la funzione si è eseguita
                        if (snapshot.hasData) {
                          //verifica se in snapshot ci sono dati da mostrare
                          var data = (snapshot.data as Map<String, dynamic>);
                          return Column(
                            //Widget che viene ritornato con i dati caricati
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 0, 0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 10, 0, 0),
                                child: SelectionArea(
                                    child: Text(
                                  '${'Salve, ' + data['name']}!',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 30,
                                      ),
                                )),
                              ),
                            ],
                          );
                        }
                        return Text(
                            'Loading...'); //se non ci sono ancora dati, mostra un testo di caricamento.
                      },
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 5, 0, 0),
                            child: SelectionArea(
                                child: Text(
                              'Pazienti:',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(Auth().currentUser?.uid)
                                    .collection('Pazienti')
                                    .snapshots(),
                                //StreamBuilder per caricare i dati dei pazienti
                                //funzione per ottenere i dati dei pazienti
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    var data = [];
                                    snapshot.data?.docs.forEach((doc) {
                                      //iterazione sui singoli documenti
                                      Map<String, dynamic>? patientMap =
                                          doc.data(); //mappatura dei dati
                                      data.add(patientMap);
                                    });
                                    if (data.isEmpty) {
                                      //se la lista è vuota mostra 'Non ci sono pazienti'
                                      return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Non ci sono pazienti',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF57636C),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ]);
                                    }
                                    //altrimenti ritorna i diversi container uno per ogni paziente
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (var item
                                            in data) //iterazione sui pazienti della lista per creare i diversi widget
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 10, 10),
                                            child: Container(
                                              width: double.infinity,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x76000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12, 8, 12, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                //navigazione verso dashboardpazientewidgt
                                                                builder: (context) =>
                                                                    DashboardPazienteWidget(
                                                                        //passaggio dei dati -> Utente user
                                                                        user: Utente(
                                                                            userID:
                                                                                item['userID'],
                                                                            name: item['name'],
                                                                            lastname: item['lastname'],
                                                                            email: item['email'],
                                                                            type: item['type'],
                                                                            date: (item['dateOfBirth'] as Timestamp).toDate(),
                                                                            profileImgPath: item['profileImagePath']))));
                                                      },
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child:
                                                            item['profileImagePath'] !=
                                                                    ''
                                                                ? Image.network(
                                                                    item[
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
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                12, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    item['name'] +
                                                                        ' ' +
                                                                        item[
                                                                            'lastname'],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Outfit',
                                                                          color:
                                                                              const Color(0xFF101213),
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
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
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  DateFormat('dd-MM-yyyy').format(DateTime.parse((item[
                                                                              'dateOfBirth']
                                                                          as Timestamp)
                                                                      .toDate()
                                                                      .toString())),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: const Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
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
                                          )
                                      ],
                                    );
                                  }
                                  return Text('Loading...');
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-0.35, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AggiuntaPazienteWidget()));
                            },
                            text: '+',
                            options: FFButtonOptions(
                              width: 130,
                              height: 60,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    fontSize: 36,
                                  ),
                              borderSide: const BorderSide(
                                color: Color(0x00101213),
                                width: 1,
                              ),
                              borderRadius: 8,
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
    );
  }
}
