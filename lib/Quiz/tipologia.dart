import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:mindcare/model/quesito.dart';
import 'package:mindcare/quiz/quiz_img_a_nome.dart';
import 'package:mindcare/quiz/quiz_nome_a_img.dart';

import '../appbar/appbar_caregiver.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../gestione_quiz/domanda_nome_a_img.dart';
import '../autenticazione/login.dart';
import '../model/utente.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppbarWidget(
            title: 'Seleziona tipologia',
          )),
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
                                    List<dynamic> quesiti =
                                        await QuizController().getQuesiti(
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
                                    List<dynamic> quesiti =
                                        await QuizController().getQuesiti(
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
