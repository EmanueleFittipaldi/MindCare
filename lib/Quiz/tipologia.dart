import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:mindcare/model/quesito.dart';
import 'package:mindcare/quiz/quiz_img_a_nome.dart';
import 'package:mindcare/quiz/quiz_nome_a_img.dart';
import '../appbar/appbar_caregiver.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../gestione_quiz/domanda_nome_a_img.dart';
import '../autenticazione/login.dart';
import '../model/utente.dart';
import 'dart:math';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Color(0xFFF0F6FF),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset('assets/images/tipologia.jpg').image,
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 15, 0),
                  child: SelectionArea(
                      child: Text(
                    'In questa pagina è possibile scegliere tra due tipologie di quiz: "Associa immagine a nome" e "Associa nome ad immagine". Divertiti allenandoti!',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 19,
                          fontWeight: FontWeight.w300,
                        ),
                  )),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: [
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
                            color: Color(0xFF4589FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: FlutterFlowIconButton(
                                    borderColor: Color(0x00FFFFFF),
                                    borderRadius: 0,
                                    borderWidth: 0,
                                    buttonSize: 140,
                                    icon: Icon(
                                      Icons.image_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 60,
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
                                          await QuizController()
                                              .getRandomQuesiti(
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
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 5),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Selezionare l\'immagine in base al nome mostrato nella domanda.',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: [
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
                            color: Color(0xFFA56EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: FlutterFlowIconButton(
                                    borderColor: Color(0x00FFFFFF),
                                    borderRadius: 0,
                                    borderWidth: 0,
                                    buttonSize: 140,
                                    icon: Icon(
                                      Icons.list,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 60,
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
                                          await QuizController().getRandomQuesiti(
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
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 5),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 15),
                                  child: SelectionArea(
                                      child: Text(
                                    'Selezionare la risposta esatta in base all\'immagine mostrata nella domanda.',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 18,
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
