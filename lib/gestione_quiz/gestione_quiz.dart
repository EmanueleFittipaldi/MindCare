import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/gestione_quiz/domanda_img_a_nome.dart';
import 'package:mindcare/gestione_quiz/domanda_nome_a_img.dart';
import '../auth.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../utente.dart';

class GestionQuizWidget extends StatefulWidget {
  final Utente user;
  const GestionQuizWidget({Key? key, required this.user}) : super(key: key);

  @override
  _GestionQuizWidgetState createState() => _GestionQuizWidgetState();
}

class _GestionQuizWidgetState extends State<GestionQuizWidget> {
  String? category;
  String? typology;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                                          'Gestione Quiz',
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          'Seleziona una categoria e tipologia per visualizzare le domande',
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/Customer_Survey-amico.png',
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
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SelectionArea(
                              child: Text(
                            'Categoria:',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                          )),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 5),
                            child: FlutterFlowDropDown(
                              initialOption: category ??= 'Persone',
                              options: const [
                                'Persone',
                                'Animali',
                                'Oggetti',
                                'Altro'
                              ],
                              onChanged: (val) async {
                                setState(() => category = val);
                              },
                              width: 180,
                              height: 50,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                              hintText: 'Please select...',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 0,
                              borderRadius: 10,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SelectionArea(
                              child: Text(
                            'Tipologia:',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                          )),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 5),
                            child: FlutterFlowDropDown(
                              initialOption: typology ??=
                                  'Associa l\'immagine al nome',
                              options: const [
                                'Associa l\'immagine al nome',
                                'Associa il nome all\'immagine'
                              ],
                              onChanged: (val) async {
                                setState(() => typology = val);
                              },
                              width: 180,
                              height: 50,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                              hintText: 'Please select...',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 0,
                              borderRadius: 10,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12, 4, 12, 4),
                              hidesUnderline: true,
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
                              'Domande',
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
                              /* A prescindere dalla tipologia del quesito che sto creando
                              voglio portarmi avanti le informazioni di user, categoria e tipologia
                              perchè mi serviranno per creare l'istanza di un Quesito ed assegnarla
                              successivamente alla collezione "Quesiti" del paziente.*/
                              if (typology == 'Associa il nome all\'immagine') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CreazioneDomandaNomeAImmagineWidget(
                                          user: widget.user,
                                          tipologia: typology,
                                          categoria: category,
                                        )));
                              } else if (typology ==
                                  'Associa l\'immagine al nome') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CreazioneDomandaImmagineANomeWidget(
                                          user: widget.user,
                                          tipologia: category,
                                          categoria: typology,
                                        )));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: ListView(
                        //LISTVIEW
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 16, 8),
                            // Questo è il container che contiene la lista
                            //delle domande
                            child: Container(
                              //CONTAINER
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).lineColor,
                                  width: 2,
                                ),
                              ),

                              /*StreamBuilder per caricare dinamicamente
                               le domande da firebase*/
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(Auth().currentUser?.uid)
                                      .collection('Pazienti')
                                      .doc(widget.user.userID)
                                      .collection('Quesiti')
                                      .where('tipologia',
                                          isEqualTo:
                                              typology) //categoria e tipologia sono
                                      .where('categoria',
                                          isEqualTo:
                                              category) //invertite non so perché
                                      .snapshots(),
                                  //StreamBuilder per caricare i dati dei quesiti
                                  //funzione per ottenere i dati dei quesiti
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      var data = [];
                                      snapshot.data?.docs.forEach((doc) {
                                        //iterazione sui singoli documenti
                                        Map<String, dynamic>? quesitiMap =
                                            doc.data(); //mappatura dei dati
                                        data.add(quesitiMap);
                                      });
                                      if (data.isEmpty) {
                                        //se la lista è vuota mostra 'Non ci sono domande'
                                        return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Non ci sono domande',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF57636C),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ]);
                                      }
                                      //altrimenti ritorna i diversi widget delle domande
                                      return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          /*Devo costruire il widget di un paziente rappresentato da un
                                          container per ogni paziente che ho recuperato in data. Per fare
                                          Questo utilizzo un for.*/
                                          children: [
                                            for (var item in data)
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0, 0),
                                                      //ho pensato che è meglio inserire la categoria
                                                      //delle domande piuttosto che un numero progressivo
                                                      child: Text(
                                                        item['categoria'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1,
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
                                                                      0,
                                                                      4,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                item['domanda'],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'IBM Plex Sans',
                                                                      fontSize:
                                                                          12,
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
                                                        color:
                                                            Color(0xFF8E8E8E),
                                                        size: 25,
                                                      ),

                                                      /*Icona per cancellare un quesito.
                                                      Alla pressione di questa icona viene cancellata
                                                      la domanda corrispondete da Firebase. */
                                                      onPressed: () {},
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 45,
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                        color:
                                                            Color(0xFF8E8E8E),
                                                        size: 25,
                                                      ),
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('user')
                                                            .doc(Auth()
                                                                .currentUser
                                                                ?.uid)
                                                            .collection(
                                                                'Pazienti')
                                                            .doc(widget
                                                                .user.userID)
                                                            .collection(
                                                                'Quesiti')
                                                            .doc(item[
                                                                'quesitoID'])
                                                            .delete();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ]);
                                    }
                                    return const Text(
                                        'Caricamento dei quesiti in corso...');
                                  }),

                              //Questo è il widgeto che devo realizzare dinamicamente con i dati
                              //che mi prendo da firebase

                              /*child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 8, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                'Chi è Mario, tuo figlio?',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 45,
                                      icon: const Icon(
                                        Icons.mode_edit,
                                        color: Color(0xFF8E8E8E),
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 45,
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Color(0xFF8E8E8E),
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ],
                                ),
                              ),*/
                            ),
                          ),
                        ],
                      ),
                    ),
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
