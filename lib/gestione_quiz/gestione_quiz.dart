import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/dialog/confirm_dialog.dart';
import 'package:mindcare/gestione_quiz/domanda_img_a_nome.dart';
import 'package:mindcare/gestione_quiz/domanda_nome_a_img.dart';
import 'package:mindcare/model/quesito.dart';
import '../controller/auth.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../model/utente.dart';

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
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Quiz',
        ),
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
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: Image.asset(
                                  'assets/images/infographic_gestione_album.png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Color(0x14000000),
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(155),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            alignment: const AlignmentDirectional(-0.0, 0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                      child: Text(
                        'Seleziona una categoria e tipologia per visualizzare le domande.',
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
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
                              hintText: 'Seleziona categoria:',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 0,
                              borderRadius: 30,
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
                              hintText: 'Seleziona tipologia:',
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 0,
                              borderRadius: 30,
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
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 22,
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
                                            item: null)));
                              } else if (typology ==
                                  'Associa l\'immagine al nome') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CreazioneDomandaImmagineANomeWidget(
                                            user: widget.user,
                                            tipologia: typology,
                                            categoria: category,
                                            item: null)));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 20),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .doc(Auth().currentUser?.uid)
                              .collection('Pazienti')
                              .doc(widget.user.userID)
                              .collection('Quesiti')
                              .where('tipologia', isEqualTo: typology)
                              .where('categoria', isEqualTo: category)
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color: const Color(0xFF57636C),
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ]);
                              }
                              //altrimenti ritorna i diversi widget delle domande
                              return ListView(
                                  //LISTVIEW
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    /*Devo costruire il widget di un paziente rappresentato da un
                                          container per ogni paziente che ho recuperato in data. Per fare
                                          Questo utilizzo un for.*/

                                    for (var item in data)
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 0, 15, 8),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 12,
                                                color: Color(0x14000000),
                                                offset: Offset(0, 5),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: Colors.transparent,
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
                                                  width: 80,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  //ho pensato che è meglio inserire la categoria
                                                  //delle domande piuttosto che un numero progressivo
                                                  child: Text(
                                                    item['categoria'],
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
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
                                                                  0, 4, 0, 0),
                                                          child: Text(
                                                            item['domanda'],
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

                                                  /*Icona modificare un quesito*/
                                                  onPressed: () {
                                                    if ('Associa il nome all\'immagine' ==
                                                        item['tipologia']) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreazioneDomandaNomeAImmagineWidget(
                                                                    user: widget
                                                                        .user,
                                                                    tipologia:
                                                                        typology,
                                                                    categoria:
                                                                        category,
                                                                    item: Quesito(
                                                                        quesitoID:
                                                                            item[
                                                                                'quesitoID'],
                                                                        opzione1:
                                                                            item[
                                                                                'opzione1'],
                                                                        opzione2:
                                                                            item[
                                                                                'opzione2'],
                                                                        opzione3:
                                                                            item[
                                                                                'opzione3'],
                                                                        opzione4:
                                                                            item[
                                                                                'opzione4'],
                                                                        domanda:
                                                                            item[
                                                                                'domanda'],
                                                                        domandaImmagine:
                                                                            item[
                                                                                'domandaImmagine'],
                                                                        risposta:
                                                                            item[
                                                                                'risposta'],
                                                                        categoria:
                                                                            item[
                                                                                'categoria'],
                                                                        tipologia:
                                                                            item['tipologia']),
                                                                  )));
                                                    } else {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreazioneDomandaImmagineANomeWidget(
                                                                    user: widget
                                                                        .user,
                                                                    tipologia:
                                                                        typology,
                                                                    categoria:
                                                                        category,
                                                                    item: Quesito(
                                                                        quesitoID:
                                                                            item[
                                                                                'quesitoID'],
                                                                        opzione1:
                                                                            item[
                                                                                'opzione1'],
                                                                        opzione2:
                                                                            item[
                                                                                'opzione2'],
                                                                        opzione3:
                                                                            item[
                                                                                'opzione3'],
                                                                        opzione4:
                                                                            item[
                                                                                'opzione4'],
                                                                        domanda:
                                                                            item[
                                                                                'domanda'],
                                                                        domandaImmagine:
                                                                            item[
                                                                                'domandaImmagine'],
                                                                        risposta:
                                                                            item[
                                                                                'risposta'],
                                                                        categoria:
                                                                            item[
                                                                                'categoria'],
                                                                        tipologia:
                                                                            item['tipologia']),
                                                                  )));
                                                    }
                                                  },
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 45,
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_forever_outlined,
                                                    color: Color(0xFF8E8E8E),
                                                    size: 25,
                                                  ),
                                                  /*Icona per cancellare un quesito.
                                                      Alla pressione di questa icona viene cancellata
                                                      la domanda corrispondete da Firebase. */
                                                  onPressed: () async {
                                                    var confirmDialogResponse =
                                                        await showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return const ConfirmDialog(
                                                                title:
                                                                    'Eliminazione domanda',
                                                                description:
                                                                    'Vuoi davvero eliminare la domanda?',
                                                                textOptionConfirm:
                                                                    'Conferma',
                                                                textOptionDelete:
                                                                    'Annulla',
                                                              );
                                                            });
                                                    if (confirmDialogResponse) {
                                                      FirebaseFirestore.instance
                                                          .collection('user')
                                                          .doc(Auth()
                                                              .currentUser
                                                              ?.uid)
                                                          .collection(
                                                              'Pazienti')
                                                          .doc(widget
                                                              .user.userID)
                                                          .collection('Quesiti')
                                                          .doc(
                                                              item['quesitoID'])
                                                          .delete();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ]);
                            }
                            return const Text(
                                'Caricamento dei quesiti in corso...');
                          }),
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
