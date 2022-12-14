import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindcare/Quiz/fine_quiz.dart';
import 'package:mindcare/dialog/confirm_dialog.dart';
import '../autenticazione/login.dart';
import 'package:mindcare/quiz/no_piu_tentativi.dart';
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
  int countTentativi = 1;
  Timer? timer;
  Map<String, bool> mappaRisposte = <String, bool>{};
  var quesito;
  var box;
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
          tipologia == 'Associa l\'immagine al nome') {
        timer!.cancel();
        setState(() {
          indexQuesito = box.get('statoCorrente')['indexQuesito'];
          countTentativi = box.get('statoCorrente')['countTentativi'];
          //cast to Map<String, bool>
          mappaRisposte = Map<String, bool>.from(
              box.get('statoCorrente')['mappaRisposte'] as Map);
        });

        print('indexQuesito: $indexQuesito');
        print('countTentativi: $countTentativi');
        print('mappaRisposte: $mappaRisposte');
      }
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
      //CASO RISPOSTA GIUSTA
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogCorretta();
          });
      timer!.cancel();
      setState(() {
        mappaRisposte[quesito['quesitoID']] = true;
        indexQuesito += 1;
        countTentativi = 1;
      });
    } else {
      //CASO RISPOSTA SBAGLIATA, PROPOSTA TENTATIVO
      if (countTentativi == 1) {
        //verifico se ci sono tentativi
        var risposta = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogSbagliata();
            });

        //CASO NON VOGLIO RIPROVARE
        if (!risposta) {
          timer!.cancel();
          setState(() {
            mappaRisposte[quesito['quesitoID']] = false;
            indexQuesito += 1;
            countTentativi = 1; //per sicurezza
          });
        } else {
          //CASO VOGLIO RIPROVARE
          timer!.cancel();
          setState(() {
            countTentativi = 0;
          });
        }
      } else {
        //CASO NON HO PIU' TENTATIVI
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogNoTentativi();
            });
        timer!.cancel();
        setState(() {
          mappaRisposte[quesito['quesitoID']] = false;
          indexQuesito += 1;
          countTentativi = 1;
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
      } else {
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
          categoria: widget.categoria);

      report.createReport(widget.caregiverID, widget.user.userID, reportID);

      /*Dopo che il build ha terminato la costruzione dell'UI, mostro la dialog 
      del quiz terminato*/
      Future.microtask(() => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogTerminato();
          }));
    } else {
      /*Prelevo il quesito che devo mostrare al video */
      quesito = widget.quesiti[indexQuesito];

      /*Quando prelevo il quesito faccio partire il timer. Mostro un AlertDialog
      che mi domanda se voglio vedere la risposta oppure no. Attende con un await
      la mia risposta. Se ho risposto si, attendo con un'altra await che venga chiamata
      l'altra AlertDialog che mi mostra la risposta, e alla fine chiamo setState in modo
      che possa ripartire il timer e mostrarmi dinuovo dopo 10 secondi se voglio vedere dinuovo
      la risposta.
      Se invece ho risposto no che non voglio vedere la risposta allora semplicemente resetto il timer
      ribuildando il widget con setstate.  */

      timer = Timer(const Duration(seconds: 10), () async {
        var risposta = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              //return AlertHint(); //suggerimento
              return ConfirmDialog(
                  title: 'Mmm',
                  description:
                      'sembra che questa domanda ti abbia messo un po\' in difficoltà, vuoi vedere la risposta?',
                  textOptionDelete: 'No',
                  textOptionConfirm: 'Si');
            });

        if (risposta) {
          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertRisposta(quesito['risposta']);
              });
          timer!.cancel();
          setState(() {});
        } else {
          timer!.cancel();
          setState(() {});
        }
      });
    } //non toccare questa parentesi
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
                    timer!.cancel();
                    //Salvo lo stato corrente del quiz perché significa che non
                    //l'ho portato a termine. In questo modo potrò riprenderlo
                    Map<String, dynamic> statoCorrente = {
                      'categoria': widget.categoria,
                      'tipologia': 'Associa l\'immagine al nome',
                      'indexQuesito': indexQuesito,
                      'mappaRisposte': mappaRisposte,
                      'countTentativi': countTentativi,
                      'inizioTempo': widget.inizioTempo
                    };
                    box.put('statoCorrente', statoCorrente);
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
                    timer!.cancel();
                    Map<String, dynamic> statoCorrente = {
                      'categoria': widget.categoria,
                      'tipologia': 'Associa l\'immagine al nome',
                      'indexQuesito': indexQuesito,
                      'mappaRisposte': mappaRisposte,
                      'countTentativi': countTentativi,
                      'inizioTempo': widget.inizioTempo
                    };
                    box.put('statoCorrente', statoCorrente);
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
                  Expanded(
                    child: Padding(
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    quesito['domandaImmagine'],
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
                            child: FFButtonWidget(
                              onPressed: () async {
                                checkRisposta(quesito, 'Opzione 1');
                              },
                              text: quesito['opzione1'],
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                            child: FFButtonWidget(
                              onPressed: () async {
                                checkRisposta(quesito, 'Opzione 2');
                              },
                              text: quesito['opzione2'],
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                            child: FFButtonWidget(
                              onPressed: () async {
                                checkRisposta(quesito, 'Opzione 3');
                              },
                              text: quesito['opzione3'],
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 15, 15),
                            child: FFButtonWidget(
                              onPressed: () async {
                                checkRisposta(quesito, 'Opzione 4');
                              },
                              text: quesito['opzione4'],
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 20,
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
