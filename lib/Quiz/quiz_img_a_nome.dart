import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/Quiz/fine_quiz.dart';
import 'package:mindcare/gestione_quiz/quesito.dart';
import 'package:mindcare/paziente/home_paziente.dart';
import 'package:mindcare/quiz/risposta_corretta.dart';
import 'package:mindcare/quiz/risposta_sbagliata.dart';
import 'package:mindcare/quiz/tipologia.dart';
import 'package:mindcare/utente.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login.dart';

class ImmagineANomeWidget extends StatefulWidget {
  final Utente user;
  final List<dynamic> quesiti;
  final DateTime inizioTempo;

  const ImmagineANomeWidget(
      {Key? key,
      required this.user,
      required this.quesiti,
      required this.inizioTempo})
      : super(key: key);

  @override
  _ImmagineANomeWidgetState createState() => _ImmagineANomeWidgetState();
}

class _ImmagineANomeWidgetState extends State<ImmagineANomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int indexQuesito = 0;
  int countTentativi = 1; //contatore dei tentativi
  Map<String, bool> mappaRisposte = <String, bool>{};

  @override
  Widget build(BuildContext context) {
    var quesito;
    if (indexQuesito >= widget.quesiti.length) {
      quesito = widget.quesiti[
          indexQuesito - 1]; //carica lo stesso il quesito per non avere errori
      //stoppo il timer
      DateTime fineTempo = DateTime.now();
      int tempoImpiegato = fineTempo.difference(widget.inizioTempo).inSeconds;

      Future.microtask(() => showDialog(
          //dialog del quiz terminato
          //ritarda l'esecuzione, in modo da attendere che buil si costruisca
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogTerminato();
          }));

      //metto il primo quesito per non far uscire errori
      //creo il report
      //mostra schermata quiz finito
      //torno a homepage
    } else {
      quesito = widget.quesiti[indexQuesito];
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
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
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xFFEBF9FF),
                    size: 30,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).tertiaryColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x76000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 2, 10, 0),
                            child: SelectionArea(
                                child: Text(
                              quesito['domanda'],
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        scrollDirection: Axis.vertical,
                        children: [
                          InkWell(
                            onTap: () async {
                              //controllo se ho risposto corretto
                              //oppure no
                              if (quesito['risposta'] == 'Immagine 1') {
                                //ho indovinato
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomDialogCorretta();
                                    });
                                setState(() {
                                  countTentativi =
                                      1; //aggiungo il tentativo per la domanda successiva
                                  mappaRisposte[quesito['quesitoID']] = true;
                                  indexQuesito += 1;
                                });
                              } else {
                                //ho sbagliato
                                //verifico se ci sono tentativi
                                if (countTentativi == 1) {
                                  //se si mostro la scherma per il tentativo
                                  var risposta = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CustomDialogSbagliata();
                                      });

                                  //se dico che non voglio riporvare allora vado
                                  //avanti con la domanda
                                  if (!risposta) {
                                    setState(() {
                                      mappaRisposte[quesito['quesitoID']] =
                                          false;
                                      indexQuesito += 1;
                                    });
                                  } else {
                                    //se dice che vuole riprovare azzero i tentativi
                                    setState(() {
                                      countTentativi = 0;
                                    });
                                  }
                                } else {
                                  //ha finito i tentativi
                                  //MOSTRARE SCHERMATA CON SOLO RISPOSTA SBAGLIATA, VEDREMO COME!
                                  Fluttertoast.showToast(
                                      msg:
                                          'Risposta sbagliata! Hai già provato, quindi va avanti');

                                  setState(() {
                                    mappaRisposte[quesito['quesitoID']] = false;
                                    indexQuesito += 1;
                                    countTentativi =
                                        1; //aggiungo il tentativo per la domanda successiva
                                  });
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                quesito['opzione1'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              //controllo se ho risposto corretto
                              //oppure no
                              if (quesito['risposta'] == 'Immagine 2') {
                                //ho indovinato
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomDialogCorretta();
                                    });
                                setState(() {
                                  mappaRisposte[quesito['quesitoID']] = true;
                                  indexQuesito += 1;
                                });
                              } else {
                                //ho sbagliato
                                if (countTentativi == 1) {
                                  //verifico se ci sono tentativi
                                  var risposta = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CustomDialogSbagliata();
                                      });

                                  //se dico che non voglio riporvare allora vado
                                  //avanti con la domanda
                                  if (!risposta) {
                                    setState(() {
                                      mappaRisposte[quesito['quesitoID']] =
                                          false;
                                      indexQuesito += 1;
                                    });
                                  } else {
                                    setState(() {
                                      countTentativi = 0;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Risposta sbagliata! Hai già provato, quindi va avanti');

                                  setState(() {
                                    mappaRisposte[quesito['quesitoID']] = false;
                                    indexQuesito += 1;
                                    countTentativi = 1;
                                  });
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                quesito['opzione2'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              //controllo se ho risposto corretto
                              //oppure no
                              if (quesito['risposta'] == 'Immagine 3') {
                                //ho indovinato
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomDialogCorretta();
                                    });
                                setState(() {
                                  mappaRisposte[quesito['quesitoID']] = true;
                                  indexQuesito += 1;
                                });
                              } else {
                                //ho sbagliato
                                if (countTentativi == 1) {
                                  var risposta = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CustomDialogSbagliata();
                                      });

                                  //se dico che non voglio riporvare allora vado
                                  //avanti con la domanda
                                  if (!risposta) {
                                    setState(() {
                                      mappaRisposte[quesito['quesitoID']] =
                                          false;
                                      indexQuesito += 1;
                                    });
                                  } else {
                                    setState(() {
                                      countTentativi = 0;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Risposta sbagliata! Hai già provato, quindi va avanti');

                                  setState(() {
                                    mappaRisposte[quesito['quesitoID']] = false;
                                    indexQuesito += 1;
                                    countTentativi = 1;
                                  });
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                quesito['opzione3'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              //controllo se ho risposto corretto
                              //oppure no
                              if (quesito['risposta'] == 'Immagine 4') {
                                //ho indovinato
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomDialogCorretta();
                                    });
                                setState(() {
                                  mappaRisposte[quesito['quesitoID']] = true;
                                  indexQuesito += 1;
                                });
                              } else {
                                //ho sbagliato
                                if (countTentativi == 1) {
                                  var risposta = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CustomDialogSbagliata();
                                      });

                                  //se dico che non voglio riporvare allora vado
                                  //avanti con la domanda
                                  if (!risposta) {
                                    setState(() {
                                      mappaRisposte[quesito['quesitoID']] =
                                          false;
                                      indexQuesito += 1;
                                    });
                                  } else {
                                    setState(() {
                                      countTentativi = 0;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Risposta sbagliata! Hai già provato, quindi va avanti');

                                  setState(() {
                                    mappaRisposte[quesito['quesitoID']] = false;
                                    indexQuesito += 1;
                                    countTentativi = 1;
                                  });
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                quesito['opzione4'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
      ),
    );
  }
}
