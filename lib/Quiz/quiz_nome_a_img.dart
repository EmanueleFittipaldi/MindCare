import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindcare/Quiz/fine_quiz.dart';
import 'package:mindcare/Quiz/no_piu_tentativi.dart';
import 'package:mindcare/dialog/confirm_dialog.dart';
import 'package:mindcare/model/quesito.dart';
import 'package:mindcare/quiz/quiz_terminato.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../autenticazione/login.dart';
import 'package:mindcare/model/report.dart';
import 'package:mindcare/quiz/risposta_corretta.dart';
import 'package:mindcare/quiz/risposta_sbagliata.dart';
import '../model/utente.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alert_hint.dart';
import 'alert_risposta.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NomeAImmagineWidget extends StatefulWidget {
  final Utente user;
  final String categoria;
  final List<dynamic> quesiti;
  final DateTime inizioTempo;
  final String caregiverID;
  const NomeAImmagineWidget(
      {Key? key,
      required this.user,
      required this.quesiti,
      required this.inizioTempo,
      required this.categoria,
      required this.caregiverID})
      : super(key: key);

  @override
  _NomeAImmagineWidgetState createState() => _NomeAImmagineWidgetState();
}

class _NomeAImmagineWidgetState extends State<NomeAImmagineWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int indexQuesito = 0;
  int? countTentativi;
  Timer? timer;
  Map<String, bool> mappaRisposte = <String, bool>{};
  var quesito;
  var box;
  var percentualeBarra = 0.0;
  var incrementoBarra = 0.0;
  int tempoImpiegato = 0;

  getStatoQuiz() async {
    //inizializzazione di Hive
    await Hive.initFlutter();
    //Apre il box. Se non c'è lo crea
    box = await Hive.openBox('quiz');

    /*
    Preleva 'statoCorrente' dal box. Se non è nullo, inizializza: indexQuesito, countTentativi e mappaRisposte
    */
    if (box.get('statoCorrente') != null) {
      var categoria = box.get('statoCorrente')['categoria'];
      var tipologia = box.get('statoCorrente')['tipologia'];

      //devo ripristinare lo stato del quiz solo se lo stato memorizzato
      //è relativo a questa categoria e a questa tipologia
      if (categoria == widget.categoria &&
          tipologia == 'Associa il nome all\'immagine') {
        timer!.cancel();
        setState(() {
          indexQuesito = box.get('statoCorrente')['indexQuesito'];
          countTentativi = box.get('statoCorrente')['countTentativi'];
          percentualeBarra = box.get('statoCorrente')['percentualeBarra'];
          //cast to Map<String, bool>
          mappaRisposte = Map<String, bool>.from(
              box.get('statoCorrente')['mappaRisposte'] as Map);
        });

        print('indexQuesito: $indexQuesito');
        print('countTentativi: $countTentativi');
        print('mappaRisposte: $mappaRisposte');
      }
    } else {
      //cancel box content
      await box.delete('statoCorrente');
    }
  }

  /*Funzione che mi permette di cancellare uno stato. Utile quando ho completato
  il quiz. */
  deleteStatoQuiz() async {
    await box.delete('statoCorrente');
  }

  @override
  void initState() {
    super.initState();
    //controllo se c'è salvato uno stato di quiz relativo a questa categoria e tipologia
    //se si allora lo devo caricare in quanto significa
    //che l'utente non ha completato il quiz
    getStatoQuiz();
    incrementoBarra = 1.0 / widget.quesiti.length;
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
  checkRisposta(var quesito, var opzioneSelezionata) async {
    if (quesito['risposta'] == opzioneSelezionata) {
      timer!.cancel();
      //CASO RISPOSTA GIUSTA
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
      setState(() {
        mappaRisposte[quesito['quesitoID']] = true;
        indexQuesito += 1;
        percentualeBarra += incrementoBarra;
        countTentativi = null;
      });
    } else {
      //CASO RISPOSTA SBAGLIATA, PROPOSTA TENTATIVO
      if (countTentativi! >= 1) {
        timer!.cancel();
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
          //timer!.cancel();
          setState(() {
            mappaRisposte[quesito['quesitoID']] = false;
            indexQuesito += 1;
            percentualeBarra += incrementoBarra;
            countTentativi = null; //per sicurezza
          });
        } else {
          //CASO VOGLIO RIPROVARE
          //timer!.cancel();
          setState(() {
            countTentativi = countTentativi! - 1;
          });
        }
      } else {
        timer!.cancel();
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
        //timer!.cancel();
        setState(() {
          mappaRisposte[quesito['quesitoID']] = false;
          indexQuesito += 1;
          percentualeBarra += incrementoBarra;
          countTentativi = null;
        });
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
    if (indexQuesito >= widget.quesiti.length) {
      //controllo di sicurezza per evitare che ci sia qualche istanza
      //di timer ancora attiva in background. Questo causerebbe delle eccezioni
      //uscendo dalla pagina del quiz.
      if (timer!.isActive) {
        timer!.cancel();
      }
      quesito = widget.quesiti[
          indexQuesito - 1]; //carica lo stesso il quesito per non avere errori

      //stoppo il timer
      DateTime fineTempo = DateTime.now();

      /*Se c'era uno stato corrente significa che per ricavare il tempo impiegato
      devo utilizzare l'inizioTempo memorizzato nel momento in cui ho abbandonato il quiz
      e non quello corrente. Solo in questo modo posso ottenere quanto tempo ho impiegato
      per completare il quiz.*/

      if (box.get('statoCorrente') != null) {
        if (box.get('statoCorrente')['tipologia'] ==
                'Associa l\'immagine al nome' &&
            box.get('statoCorrente')['categoria'] == widget.categoria) {
          var tempoInizioMemorizzato = box.get('statoCorrente')['inizioTempo'];
          tempoImpiegato =
              fineTempo.difference(tempoInizioMemorizzato).inSeconds;
          deleteStatoQuiz();
        }
      }

      if (tempoImpiegato == 0) {
        tempoImpiegato = fineTempo.difference(widget.inizioTempo).inSeconds;
      }

      //creo il report
      var reportID = Report.reportIDGenerator(28);
      var risposteCorretteESbagliate = statisticheQuiz();
      Report report = Report(
          mappaRisposte: mappaRisposte,
          tempoImpiegato: tempoImpiegato,
          dataInizio: widget.inizioTempo,
          risposteCorrette: risposteCorretteESbagliate['corrette'],
          risposteErrate: risposteCorretteESbagliate['sbagliate'],
          precisione: risposteCorretteESbagliate['precisione'],
          reportID: reportID,
          tipologia: 'Associa il nome all\'immagine',
          categoria: widget.categoria,
          umore: 3);

      Future.microtask(() => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizTerminatoWidget(
                  caregiverID: widget.caregiverID,
                  userID: widget.user.userID,
                  reportID: reportID,
                  report: report))));
    } else {
      /*Prelevo il quesito che devo mostrare al video */
      quesito = widget.quesiti[indexQuesito];
      countTentativi ??= quesito['numeroTentativi'];
      /*Quando prelevo il quesito faccio partire il timer. Mostro un AlertDialog
      che mi domanda se voglio vedere la risposta oppure no. Attende con un await
      la mia risposta. Se ho risposto si, attendo con un'altra await che venga chiamata
      l'altra AlertDialog che mi mostra la risposta, e alla fine chiamo setState in modo
      che possa ripartire il timer e mostrarmi dinuovo dopo 10 secondi se voglio vedere dinuovo
      la risposta.
      Se invece ho risposto no che non voglio vedere la risposta allora semplicemente resetto il timer
      ribuildando il widget con setstate.  */

      timer = Timer(
          Duration(seconds: widget.quesiti[indexQuesito]['tempoRisposta']),
          () async {
        var risposta = await PanaraConfirmDialog.show(
          context,
          title: "Hey",
          message:
              "Sembra che questa domanda ti abbia messo un po\' in difficoltà, vuoi vedere la risposta?",
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
          timer!.cancel();
          setState(() {
            mappaRisposte[quesito['quesitoID']] = false;
            indexQuesito += 1;
            percentualeBarra += incrementoBarra;
            countTentativi = null;
          });
        } else {
          timer!.cancel();
          setState(() {});
        }
      });
    } //non toccare questa parentesi
    return WillPopScope(
      onWillPop: () async {
        timer!.cancel();
        var risposta = await PanaraConfirmDialog.show(
          context,
          title: "Esci dal quiz",
          message:
              "Vuoi davvero uscire dal quiz? Il quiz verrà messo in pausa!",
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
          //Salvo lo stato corrente del quiz perché significa che non
          //l'ho portato a termine. In questo modo potrò riprenderlo
          Map<String, dynamic> statoCorrente = {
            'categoria': widget.categoria,
            'tipologia': 'Associa il nome all\'immagine',
            'indexQuesito': indexQuesito,
            'mappaRisposte': mappaRisposte,
            'countTentativi': countTentativi,
            'inizioTempo': widget.inizioTempo,
            'percentualeBarra': percentualeBarra,
          };
          box.put('statoCorrente', statoCorrente);
          Navigator.of(context).pop();
        } else {
          setState(() {});
        }
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
                  timer!.cancel();
                  var risposta = await PanaraConfirmDialog.show(
                    context,
                    title: "Esci dal quiz",
                    message:
                        "Vuoi davvero uscire dal quiz? Il quiz verrà messo in pausa!",
                    confirmButtonText: "Si",
                    cancelButtonText: "No",
                    onTapCancel: () {
                      Navigator.of(context).pop(false);
                    },
                    onTapConfirm: () {
                      Navigator.of(context).pop(true);
                    },
                    panaraDialogType: PanaraDialogType.normal,
                    barrierDismissible:
                        false, // optional parameter (default is true)
                  );
                  if (risposta) {
                    //Salvo lo stato corrente del quiz perché significa che non
                    //l'ho portato a termine. In questo modo potrò riprenderlo
                    Map<String, dynamic> statoCorrente = {
                      'categoria': widget.categoria,
                      'tipologia': 'Associa il nome all\'immagine',
                      'indexQuesito': indexQuesito,
                      'mappaRisposte': mappaRisposte,
                      'countTentativi': countTentativi,
                      'inizioTempo': widget.inizioTempo,
                      'percentualeBarra': percentualeBarra,
                    };
                    box.put('statoCorrente', statoCorrente);
                    Navigator.of(context).pop();
                  } else {
                    setState(() {});
                  }
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
                        const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 0),
                                child: Text(
                                  'Domanda ${indexQuesito + 1}/${widget.quesiti.length}',
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 10, 0),
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300,
                                    ),
                              )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    quesito['domandaImmagine'],
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 50, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Opzione 1');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Color(0xFFA0A0A0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15, 0,
                                                                    10, 0),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xB6F4F4F4),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            '1',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          quesito['opzione1'],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Opzione 2');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Color(0xFFA0A0A0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15, 0,
                                                                    10, 0),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xB6F4F4F4),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            '2',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          quesito['opzione2'],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Opzione 3');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Color(0xFFA0A0A0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15, 0,
                                                                    10, 0),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xB6F4F4F4),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            '3',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          quesito['opzione3'],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: InkWell(
                                                onTap: () async {
                                                  checkRisposta(
                                                      quesito, 'Opzione 4');
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Color(0xFFA0A0A0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15, 0,
                                                                    10, 0),
                                                        child: Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xB6F4F4F4),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            '4',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          quesito['opzione4'],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
