import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/auth.dart';
import 'package:mindcare/gestione_ricordi/creazione_ricordo.dart';
import 'package:mindcare/gestione_ricordi/ricordo.dart';
import 'package:mindcare/utente.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class GestioneAlbumWidget extends StatefulWidget {
  final Utente user;
  const GestioneAlbumWidget({Key? key, required this.user}) : super(key: key);

  @override
  _GestioneAlbumWidgetState createState() => _GestioneAlbumWidgetState();
}

class _GestioneAlbumWidgetState extends State<GestioneAlbumWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //funzione per eliminare un paziente e la sua immagine salvate nello storage
  Future<void> deleteMemory(memoryID, filePath) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(widget.user.userID)
        .collection('Ricordi')
        .doc(memoryID); //riferimento al documento da eliminare
    await FirebaseFirestore.instance
        .runTransaction((Transaction deleteTransaction) async {
      deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
    });
    if (filePath != '') {
      await FirebaseStorage.instance
          .refFromURL(filePath)
          .delete(); //eliminazione immagine
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarcaregiverWidget(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            alignment: const AlignmentDirectional(-0.0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: Text(
                                          'Gestione Album',
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/infographic_gestione_album.png',
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                            child: Text(
                              'Ricordi',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 5,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 25,
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RicordoImmagineWidget(
                                        userID: widget.user.userID,
                                        memoryItem: null,
                                      )));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .doc(Auth().currentUser?.uid)
                              .collection('Pazienti')
                              .doc(widget.user.userID)
                              .collection('Ricordi')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var data = [];
                              var count = 0;
                              snapshot.data?.docs.forEach((doc) {
                                //iterazione sui singoli documenti
                                Map<String, dynamic>? memoryMap =
                                    doc.data(); //mappatura dei dati
                                data.add(memoryMap);
                              });

                              if (data.isNotEmpty) {
                                return ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    for (int i = 0; i < data.length; i++)
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 16, 8),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .lineColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8, 8, 8, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    i.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title2,
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Text(
                                                            data[i]['titolo'],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 45,
                                                  icon: const Icon(
                                                    Icons.mode_edit,
                                                    color: Color(0xFF8E8E8E),
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RicordoImmagineWidget(
                                                                    userID: widget
                                                                        .user
                                                                        .userID,
                                                                    memoryItem:
                                                                        Ricordo(
                                                                      titolo: data[
                                                                              i]
                                                                          [
                                                                          'titolo'],
                                                                      annoRicordo:
                                                                          data[i]
                                                                              [
                                                                              'annoRicordo'],
                                                                      descrizione:
                                                                          data[i]
                                                                              [
                                                                              'descrizione'],
                                                                      filePath:
                                                                          data[i]
                                                                              [
                                                                              'filePath'],
                                                                      ricordoID:
                                                                          data[i]
                                                                              [
                                                                              'ricordoID'],
                                                                      tipoRicordo:
                                                                          data[i]
                                                                              [
                                                                              'tipoRicordo'],
                                                                    ))));
                                                  },
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 45,
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    color: Color(0xFF8E8E8E),
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    deleteMemory(
                                                        data[i]['ricordoID'],
                                                        data[i]['filePath']);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              } else {
                                return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Non ci sono ricordi!',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color:
                                                      const Color(0xFF57636C),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ]));
                              }
                            }
                            return Text('Loading...');
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
