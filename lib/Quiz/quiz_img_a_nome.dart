import 'dart:async';
import 'package:mindcare/Quiz/no_piu_tentativi.dart';
import 'package:mindcare/init_homepage.dart';
import 'package:mindcare/model/report.dart';
import 'package:mindcare/model/utente.dart';
import 'package:mindcare/Quiz/quiz_terminato.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../widget_tree.dart';

class ImmagineANomeWidget extends StatefulWidget {
  final Box box;
  final Utente user;
  const ImmagineANomeWidget({required this.box, required this.user, Key? key})
      : super(key: key);

  @override
  _ImmagineANomeWidgetState createState() => _ImmagineANomeWidgetState();
}

class _ImmagineANomeWidgetState extends State<ImmagineANomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int indexQuesito = 0;
  int? countTentativi;
  Timer? timer;
  Map<String, bool> mappaRisposte = <String, bool>{};
  String? categoria;
  String? tipologia;
  // ignore: prefer_typing_uninitialized_variables
  var quesito;
  var percentualeBarra = 0.0;
  var incrementoBarra = 0.0;
  int tempoImpiegato = 0;
  List<dynamic>? quesiti;
  /*Funzione che vede se in locale c'è salvato un quiz per questa categoria e 
  tipologia. Se è così, significa che l'utente non ha completato un quiz e quindi
  gli permette di continuarlo andando a caricare:
  - indexQuesito: in questo modo riprendo a rispondere da dove avevo interrotto
  - mappaRisposte: in questo modo ricordo quali sono state le mie risposte passate e posso
    registrare quelle nuove. */

  getStatoQuiz() async {
    //Apre il box. Se non c'è lo crea
    categoria = widget.box.get('statoCorrente')['categoria'];
    tipologia = widget.box.get('statoCorrente')['tipologia'];
    indexQuesito = widget.box.get('statoCorrente')['indexQuesito'];
    countTentativi = widget.box.get('statoCorrente')['countTentativi'];
    percentualeBarra = widget.box.get('statoCorrente')['percentualeBarra'];
    quesiti = widget.box.get('statoCorrente')['quesiti'];
    incrementoBarra = 1.0 / quesiti!.length;
    //cast to Map<String, bool>
    mappaRisposte = Map<String, bool>.from(
        widget.box.get('statoCorrente')['mappaRisposte'] as Map);
  }

  @override
  void initState() {
    super.initState();
    //controllo se c'è salvato uno stato di quiz relativo a questa categoria e tipologia
    //se si allora lo devo caricare in quanto significa
    //che l'utente non ha completato il quiz
    //Apre il box. Se non c'è lo crea
    getStatoQuiz();
  }

  /*
   Controllo se ho selezionato la risposta corretta:
   Se ho risposto correttamente
   1. Mostro un dialog di risposta corretta
   2. Avanzo al quesito successivo e marco con true all'interno della mappa
      delle risposte che la domanda corrente è stata risposta correttamente
   3. Vado avanti con indexQuesito in modo da prelevare la prossima domanda

   Se ho risposto sbagliato
   1. Verifico se ho ancora un tentativo disponibile. In tal caso mostro un dialog
      di risposta sbagliata dove chiedo all'utente se vuole riprovare.
   2. Se l'utente seleziona "no" allora marco la domanda corrente come sbagliata e
      incremento il indexQuesito per passare alla domanda successiva.
   3. Se l'utente seleziona "si", azzero il countTentativi. In questo modo se sbaglia
      di nuovo, verrà mostrato che non ha più tentativi disponibili.
   */

  updateState(var quesito, bool boolRisposta, int indexQ, int? countTent) {
    setState(() {
      mappaRisposte[quesito['quesitoID']] = boolRisposta;
      indexQuesito += indexQ;
      percentualeBarra += incrementoBarra;
      countTentativi = countTent;
    });
  }

  checkRisposta(var quesito, var opzioneSelezionata) async {
    if (timer!.isActive) {
      timer!.cancel();
    }
    //CASO RISPOSTA GIUSTA
    if (quesito['risposta'] == opzioneSelezionata) {
      await PanaraInfoDialog.show(
        context,
        imagePath:
            'assets/images/smart-guy-getting-award-winner-standing-pedestal-holding-golden-cup-cartoon-illustration_74855-14511.jpg.webp',
        title: "Risposta corretta!",
        message: "Complimenti! Hai indovinato la risposta!",
        buttonText: "Quiz",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: false, // optional parameter (default is true)
      );
      updateState(quesito, true, 1, null);
    } else {
      ///CASO RISPOSTA SBAGLIATA, PROPOSTA TENTATIVO
      if (countTentativi! >= 1) {
        //verifico se ci sono tentativi
        var risposta = await PanaraConfirmDialog.show(
          context,
          title: "Risposta sbagliata!",
          message: "Vuoi riprovare?",
          confirmButtonText: "Si",
          cancelButtonText: "No",
          onTapCancel: () {
            Navigator.of(context).pop(false);
          },
          onTapConfirm: () {
            Navigator.of(context).pop(true);
          },
          panaraDialogType: PanaraDialogType.error,
          barrierDismissible: false, // optional parameter (default is true)
        );

        //CASO NON VOGLIO RIPROVARE
        if (!risposta) {
          updateState(quesito, false, 1, null);
        } else {
          setState(() {
            countTentativi = countTentativi! - 1;
          });
        }
      } else {
        //CASO NON HO PIU' TENTATIVI
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogNoTentativi(
                  quesito: quesito,
                  title: 'Risposta sbagliata!',
                  message: 'Non hai più tentativi! Ecco la risposta:');
            });
        updateState(quesito, false, 1, null);
      }
    }
  }

  /*Funzione che conta quante risposte sono corrette e quante sbagliate */
  statisticheQuiz() {
    int corrette = 0;
    int sbagliate = 0;
    mappaRisposte.forEach((key, value) {
      if (value) {
        corrette++;
      } else {
        sbagliate++;
      }
    });
    var precisione = corrette / (corrette + sbagliate);
    //create a map with key integers and corrette,sbagliate and precision as values
    Map<String, dynamic> statistiche = {
      'corrette': corrette,
      'sbagliate': sbagliate,
      'precisione': precisione
    };
    return statistiche;
  }

  saveQuesito() async {
    var risposta = await PanaraConfirmDialog.show(
      context,
      title: "Esci dal quiz",
      message: "Vuoi davvero uscire dal quiz? Il quiz verrà messo in pausa!",
      confirmButtonText: "Si",
      cancelButtonText: "No",
      onTapCancel: () {
        Navigator.of(context).pop(false);
      },
      onTapConfirm: () {
        Navigator.of(context).pop(true);
      },
      panaraDialogType: PanaraDialogType.normal,
      barrierDismissible: false, // optional parameter (default is true)
    );
    if (risposta) {
      if (timer!.isActive) {
        timer!.cancel();
      }
//Salvo lo stato corrente del quiz perché significa che non
//l'ho portato a termine. In questo modo potrò riprenderlo
      Map<String, dynamic> statoCorrente = {
        'categoria': categoria,
        'tipologia': tipologia,
        'indexQuesito': indexQuesito,
        'mappaRisposte': mappaRisposte,
        'countTentativi': countTentativi,
        'inizioTempo': widget.box.get('statoCorrente')['inizioTempo'],
        'percentualeBarra': percentualeBarra,
        'quesiti': quesiti,
        'caregiverID': widget.box.get('statoCorrente')['caregiverID'],
        'userID': widget.box.get('statoCorrente')['userID']
      };
      widget.box.put('statoCorrente', statoCorrente);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => InitHomepage(
                  user: widget.user,
                  carUID: widget.box.get('statoCorrente')['caregiverID'])),
          (Route<dynamic> route) => false);
    } else {
      setState(() {});
    }
  }

  tempoScaduto() async {
    var risposta = await PanaraConfirmDialog.show(
      context,
      title: "Hey",
      message:
          "Sembra che questa domanda ti abbia messo un po' in difficoltà, vuoi vedere la risposta?",
      confirmButtonText: "Si",
      cancelButtonText: "No",
      onTapCancel: () {
        Navigator.of(context).pop(false);
      },
      onTapConfirm: () {
        Navigator.of(context).pop(true);
      },
      panaraDialogType: PanaraDialogType.normal,
      barrierDismissible: false, // optional parameter (default is true)
    );

    if (risposta) {
      if (timer!.isActive) {
        timer!.cancel();
      }
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CustomDialogNoTentativi(
                quesito: quesito,
                title: 'Risposta',
                message: 'Hai scelto di vedere la risposta:');
            //per la risposta
          });
      updateState(quesito, false, 1,
          null); // devo andare alla domanda successiva e considerare questa sbagliata
    } else {
      if (timer!.isActive) {
        timer!.cancel();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
     Se ho esaurito i quesiti da proporre:
    - Carico lo stesso l'ultimo quesito per non avere errori.
    - Prendo il tempo corrente in modo da poter ricavare quanto tempo ho impiegato
      per completare il quiz.
    - A questo punto ho tutti il necessario per poter generare un report. 
    - Una volta generato lo inserisco all'interno della collezion "Report" del paziente.
     */
    if (indexQuesito >= quesiti!.length) {
      //controllo di sicurezza per evitare che ci sia qualche istanza
      //di timer ancora attiva in background. Questo causerebbe delle eccezioni
      //uscendo dalla pagina del quiz.
      if (timer!.isActive) {
        timer!.cancel();
      }

      quesito = quesiti![
          indexQuesito - 1]; //carica lo stesso il quesito per non avere errori

      //stoppo il timer
      DateTime fineTempo = DateTime.now();

      var tempoInizioMemorizzato =
          widget.box.get('statoCorrente')['inizioTempo'];
      tempoImpiegato = fineTempo.difference(tempoInizioMemorizzato).inSeconds;

      //creo il report
      var reportID = Report.reportIDGenerator(28);
      var risposteCorretteESbagliate = statisticheQuiz();
      Report report = Report(
          mappaRisposte: mappaRisposte,
          tempoImpiegato: tempoImpiegato,
          dataInizio: tempoInizioMemorizzato,
          risposteCorrette: risposteCorretteESbagliate['corrette'],
          risposteErrate: risposteCorretteESbagliate['sbagliate'],
          precisione: risposteCorretteESbagliate['precisione'],
          reportID: reportID,
          tipologia: tipologia!,
          categoria: categoria!,
          umore: 3); //da reimpostare quando l'utente farà tap sull'umore

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => QuizTerminatoWidget(
                    report: report,
                    caregiverID: widget.box.get('statoCorrente')['caregiverID'],
                    user: widget.user,
                    reportID: reportID)),
            (Route<dynamic> route) => false);
      });
    } else {
      /*Prelevo il quesito che devo mostrare al video */
      quesito = quesiti![indexQuesito];
      countTentativi ??= quesito['numeroTentativi'];

      /*Quando prelevo il quesito faccio partire il timer. Mostro un AlertDialog
      che mi domanda se voglio vedere la risposta oppure no. Attende con un await
      la mia risposta. Se ho risposto si, attendo con un'altra await che venga chiamata
      l'altra AlertDialog che mi mostra la risposta, e alla fine chiamo setState in modo
      che possa ripartire il timer e mostrarmi dinuovo dopo 10 secondi se voglio vedere dinuovo
      la risposta.
      Se invece ho risposto no che non voglio vedere la risposta allora semplicemente resetto il timer
      ribuildando il widget con setstate.  */
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        timer =
            Timer(Duration(seconds: quesiti![indexQuesito]['tempoRisposta']),
                () async {
          if (mounted) {
            tempoScaduto();
          }
        });
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (timer!.isActive) {
          timer!.cancel();
        }
        saveQuesito();
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF0F6FF),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Quiz',
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 30,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 50,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                icon: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 30,
                ),
                onPressed: () async {
                  if (timer!.isActive) {
                    timer!.cancel();
                  }
                  saveQuesito();
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 12, 0, 0),
                      child: LinearPercentIndicator(
                        animateFromLastPercent: true,
                        percent: percentualeBarra,
                        width: MediaQuery.of(context).size.width * 0.9,
                        lineHeight: 12,
                        animation: true,
                        progressColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        backgroundColor: FlutterFlowTheme.of(context).lineColor,
                        barRadius: const Radius.circular(24),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            color: Color(0x14000000),
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Text(
                                  'Domanda ${indexQuesito + 1}/${quesiti!.length}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 10, 10),
                              child: SelectionArea(
                                  child: Text(
                                quesito['domanda'],
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                              )),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 5, 5),
                                            child: InkWell(
                                              onTap: () async {
                                                checkRisposta(
                                                    quesito, 'Immagine 1');
                                              },
                                              child: Container(
                                                width: 60,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: Image.network(
                                                      quesito['opzione1'],
                                                    ).image,
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 12,
                                                      color: Color(0x14000000),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFA0A0A0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 10, 0, 5),
                                            child: InkWell(
                                              onTap: () async {
                                                checkRisposta(
                                                    quesito, 'Immagine 2');
                                              },
                                              child: Container(
                                                width: 60,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: Image.network(
                                                      quesito['opzione2'],
                                                    ).image,
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 12,
                                                      color: Color(0x14000000),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFA0A0A0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 5, 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Immagine 3');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: Image.network(
                                                        quesito['opzione3'],
                                                      ).image,
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 12,
                                                        color:
                                                            Color(0x14000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFA0A0A0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(5, 5, 0, 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Immagine 4');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: Image.network(
                                                        quesito['opzione4'],
                                                      ).image,
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 12,
                                                        color:
                                                            Color(0x14000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFA0A0A0),
                                                    ),
                                                  ),
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
                          ],
                        ),
                      ),
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
