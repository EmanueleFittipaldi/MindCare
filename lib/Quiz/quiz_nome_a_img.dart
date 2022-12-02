import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/Quiz/fine_quiz.dart';
import 'package:mindcare/login.dart';
import 'package:mindcare/quiz/no_piu_tentativi.dart';
import 'package:mindcare/quiz/report.dart';
import 'package:mindcare/quiz/risposta_corretta.dart';
import 'package:mindcare/quiz/risposta_sbagliata.dart';
import 'package:mindcare/utente.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  int countTentativi = 1; //contatore dei tentativi
  Map<String, bool> mappaRisposte = <String, bool>{};

  checkRisposta(var quesito, var opzioneSelezionata) async {
    /*
   Controllo se ho selezionato la risposta corretta:

   Se ho risposto correttamente
   1. Se ho indovinato mostro un dialog di risposta corretta
   2. Avanzo al quesito successivo e marco con true all'interno della mappa
      delle risposte che la domanda corrente è stata risposta correttamente
   3. Vado avanti con indexQuesito in modo da prelevare la prossima domanda

   Se ho risposto sbagliato
   1. Verifico se ho ancora un tentativo disponibile. In tal caso mostro un dialog
      di risposta sbagliata dove chiedo all'utente se vuole riprovare.
   2. Se l'utente seleziona "no" allora marco la domanda corrente come sbagliata e
      incremento il indexQuesito per passare alla domanda successiva.
   3. Se l'utente seleziona "si", azzero il countTentativi
   */
    if (quesito['risposta'] == opzioneSelezionata) {
      await showDialog(
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
            mappaRisposte[quesito['quesitoID']] = false;
            indexQuesito += 1;
          });
        } else {
          //se dico che voglio riprovare
          setState(() {
            countTentativi = 0;
          });
        }
      } else {
        //se non ho più tentativi mostro un dialog che avvisa l'utente
        //che non ha più tentativi e che può ritornare al quiz
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogNoTentativi();
            });

        setState(() {
          mappaRisposte[quesito['quesitoID']] = false;
          indexQuesito += 1;
          countTentativi =
              1; //aggiorno il countTentativi in modo che anche la prossima domanda abbia 1 tentativo
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
    var precisione = (corrette + sbagliate) / corrette;
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
    var quesito;
    if (indexQuesito >= widget.quesiti.length) {
      quesito = widget.quesiti[
          indexQuesito - 1]; //carica lo stesso il quesito per non avere errori
      //stoppo il timer
      DateTime fineTempo = DateTime.now();
      int tempoImpiegato = fineTempo.difference(widget.inizioTempo).inSeconds;

      //creo il report
      var reportID = Report.reportIDGenerator(28);
      var risposteCorretteESbagliate = statisticheQuiz();
      Report report = Report(
          mappaRisposte: mappaRisposte,
          tempoImpiegato: tempoImpiegato,
          dataInizio: widget.inizioTempo,
          risposteCorrette: statisticheQuiz()['corrette'],
          risposteErrate: statisticheQuiz()['sbagliate'],
          precisione: statisticheQuiz()['precisione'],
          reportID: reportID,
          tipologia: 'Associa il nome all\'immagine',
          categoria: widget.categoria);

      report.createReport(widget.caregiverID, widget.user.userID, reportID);

      Future.microtask(() => showDialog(
          //dialog del quiz terminato
          //ritarda l'esecuzione, in modo da attendere che buil si costruisca
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogTerminato();
          }));
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
