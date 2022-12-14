import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/utente.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../gestione_paziente/aggiunta_paziente.dart';
import '../gestione_paziente/dashboard_paziente.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).backgroundPrimaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .snapshots(), //funzione per ottenere i dati
                      builder: (context, AsyncSnapshot snapshot) {
                        //costruzione degli widget dopo che la funzione si è eseguita
                        if (snapshot.hasData) {
                          var data;
                          snapshot.data?.docs.forEach((doc) {
                            //iterazione sui singoli documenti
                            Map<String, dynamic>? cmap = doc.data();
                            if (cmap!['userID'] == Auth().currentUser!.uid) {
                              data = cmap;
                            } //mappatura dei dati
                          });
                          if (data != null) {
                            return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    70, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 0),
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
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20, 40, 5, 10),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 5, 0),
                                                    child: SelectionArea(
                                                        child: Text(
                                                      data['name'] +
                                                          ' ' +
                                                          data['lastname'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    )),
                                                  ),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Caregiver',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                                  )),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 0, 5, 0),
                                                      child: SelectionArea(
                                                          child: Text(
                                                        data['email'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                      ))),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ));
                          }
                        }
                        return const Scaffold(
                            body: Center(
                                child:
                                    CircularProgressIndicator())); //se non ci sono ancora dati, mostra un testo di caricamento.
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
                                20, 20, 0, 0),
                            child: SelectionArea(
                                child: Text(
                              'Pazienti',
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 20, 0),
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
                                      /*Devo costruire il widget di un paziente rappresentato da un
                                          container per ogni paziente che ho recuperato in data. Per fare
                                          Questo utilizzo un for.*/
                                      children: [
                                        for (var item
                                            in data) //iterazione sui pazienti della lista per creare i diversi widget
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 15),
                                            child: Container(
                                              width: double.infinity,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 12,
                                                    color: Color(0x14000000),
                                                    offset: Offset(0, 5),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                                        //passaggio dei dati del paziente alla
                                                                        //Dashboard del paziente creando un oggetto utente
                                                                        //e riempiendolo con i dati presi dall'item corrente
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
                                                                25, 30, 0, 0),
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
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w300,
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
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'IBM Plex Sans',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w300,
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
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
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
    );
  }
}
