import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/gestione_quiz/quesito.dart';
import 'package:mindcare/quiz/quiz_img_a_nome.dart';
import 'package:mindcare/quiz/quiz_nome_a_img.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../gestione_quiz/domanda_nome_a_img.dart';
import '../login.dart';
import '../utente.dart';

class SelezionaTipologiaWidget extends StatefulWidget {
  final String categoria;
  final Utente user;
  final String caregiverID;
  const SelezionaTipologiaWidget(
      {Key? key,
      required this.categoria,
      required this.user,
      required this.caregiverID})
      : super(key: key);

  @override
  _SelezionaTipologiaWidgetState createState() =>
      _SelezionaTipologiaWidgetState();
}

class _SelezionaTipologiaWidgetState extends State<SelezionaTipologiaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /*
  Funzione che permette di reperire tutti i quesiti di un determinato paziente
  specificando una categoria ed una tipologia. 
  */
  getQuesiti(String categoria, String tipologia, String userID,
      String caregiverID) async {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('Quesiti');

    QuerySnapshot QueryCategoria = await _collectionRef
        .where('tipologia', isEqualTo: tipologia)
        .where('categoria', isEqualTo: categoria)
        .get();

    /*
    Quello che viene ritornato è una lista di documenti, dove ogni documento
    è una domanda della categoria e tipologia selezionata.
    */
    var result = [];
    for (var v in QueryCategoria.docs) {
      (result.add(v.data()));
    }
    return result;
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
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xFFEBF9FF),
                    size: 30,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginWidget()));
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
                  height: 230,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(155),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/add_photo.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.94, -0.92),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 10, 0),
                            child: SelectionArea(
                                child: Text(
                              'Seleziona una \ntipologia',
                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            color: const Color(0xFFFA4D56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 150,
                                  icon: Icon(
                                    Icons.image,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 90,
                                  ),

                                  /*
                                  Qui parte il quiz di tipologia associa l'immagine al nome:
                                  1. Vengono prelevati tutti i quesiti della categoria e tipologia selezionata.
                                  2. Se non ci sono domande viene mostrato un Toast che avvisa l'utente.
                                  3. Prendo la data corrente(compreso ora,minuti e secondi) al momento del 
                                     Tap sulla tipologia selezionata. Questo mi servirà insieme al tempo in cui
                                     completo il quiz per stabilire quanto tempo ci ho impiegato.
                                  4. Passo alla pagina del quiz associa immagine al nome i quesiti che dovrò svolgere
                                     l'utente corrente e il "timestamp" di inizio quiz.
                                  */
                                  onPressed: () async {
                                    List<dynamic> quesiti = await getQuesiti(
                                        widget.categoria,
                                        'Associa l\'immagine al nome',
                                        widget.user.userID,
                                        widget.caregiverID);
                                    if (quesiti.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Non ci sono domande!');
                                    } else {
                                      //faccio partire il timer quando clicco sulla tipologia
                                      //del quiz che voglio iniziare
                                      DateTime inizioTempo = DateTime.now();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ImmagineANomeWidget(
                                                      quesiti: quesiti,
                                                      user: widget.user,
                                                      inizioTempo:
                                                          inizioTempo)));
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 5),
                                  child: SelectionArea(
                                      child: Text(
                                    'Associa l\'immagine al nome',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 20,
                                        ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 25),
                                  child: SelectionArea(
                                      child: Text(
                                    'Selezionare l\'immagine in base al nome mostrato nella domanda.',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w200,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 10),
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0x00FFFFFF),
                                  borderRadius: 0,
                                  borderWidth: 0,
                                  buttonSize: 150,
                                  icon: Icon(
                                    Icons.toc,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 115,
                                  ),

                                  /*
                                   Qui parte il quiz di tipologia associa l'immagine al nome:
                                   1. Vengono prelevati tutti i quesiti della categoria e tipologia selezionata.
                                   2. Se non ci sono domande viene mostrato un Toast che avvisa l'utente.
                                   3. Prendo la data corrente(compreso ora,minuti e secondi) al momento del 
                                     Tap sulla tipologia selezionata. Questo mi servirà insieme al tempo in cui
                                     completo il quiz per stabilire quanto tempo ci ho impiegato.
                                   4. Passo alla pagina del quiz associa immagine al nome i quesiti che dovrò svolgere
                                     l'utente corrente e il "timestamp" di inizio quiz.
                                  */
                                  onPressed: () async {
                                    List<dynamic> quesiti = await getQuesiti(
                                        widget.categoria,
                                        'Associa il nome all\'immagine',
                                        widget.user.userID,
                                        widget.caregiverID);
                                    if (quesiti.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Non ci sono domande!');
                                    } else {
                                      //faccio partire il timer quando clicco sulla tipologia
                                      //del quiz che voglio iniziare
                                      DateTime inizioTempo = DateTime.now();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NomeAImmagineWidget(
                                                      quesiti: quesiti,
                                                      categoria:
                                                          widget.categoria,
                                                      caregiverID:
                                                          widget.caregiverID,
                                                      user: widget.user,
                                                      inizioTempo:
                                                          inizioTempo)));
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 5),
                                  child: SelectionArea(
                                      child: Text(
                                    'Associa il nome all\'immagine',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 20,
                                        ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 25),
                                  child: SelectionArea(
                                      child: Text(
                                    'Selezionare la risposta esatta in base all\'immagine mostrata nella domanda.',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w200,
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
