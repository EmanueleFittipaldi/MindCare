import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindcare/Quiz/quiz_img_a_nome.dart';
import 'package:mindcare/Quiz/quiz_nome_a_img.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../appbar/appbar_caregiver.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF0F6FF),
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
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x14000000),
                        offset: Offset(0, 5),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(155),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 15, 0),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: const [
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
                            color: const Color(0xFF4589FF),
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
                                    borderColor: const Color(0x00FFFFFF),
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
                                      await Hive.initFlutter();
                                      var box = await Hive.openBox('quiz');

                                      if (box.get('statoCorrente') == null ||
                                          (box.get('statoCorrente') != null &&
                                                  (box.get('statoCorrente')[
                                                          'categoria']) !=
                                                      widget.categoria ||
                                              box.get('statoCorrente')[
                                                      'tipologia'] !=
                                                  'Associa l\'immagine al nome')) {
                                        var quesiti = await QuizController()
                                            .getRandomQuesiti(
                                                widget.categoria,
                                                'Associa l\'immagine al nome',
                                                widget.user.userID,
                                                widget.caregiverID);

                                        if (quesiti.isEmpty) {
                                          // ignore: use_build_context_synchronously
                                          PanaraInfoDialog.show(
                                            context,
                                            title: "Quiz",
                                            message: "Non ci sono domande!",
                                            buttonText: "Okay",
                                            onTapDismiss: () {
                                              Navigator.pop(context);
                                            },
                                            panaraDialogType:
                                                PanaraDialogType.warning,
                                            barrierDismissible:
                                                false, // optional parameter (default is true)
                                          );
                                        } else {
                                          Map<String, dynamic> statoCorrente = {
                                            'categoria': widget.categoria,
                                            'tipologia':
                                                'Associa l\'immagine al nome',
                                            'indexQuesito': 0,
                                            'mappaRisposte': {},
                                            'countTentativi': quesiti[0]
                                                ['numeroTentativi'],
                                            'inizioTempo': DateTime.now(),
                                            'percentualeBarra': 0.0,
                                            'quesiti': quesiti,
                                            'caregiverID': widget.caregiverID,
                                            'userID': widget.user.userID
                                          };
                                          box.put(
                                              'statoCorrente', statoCorrente);
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImmagineANomeWidget(
                                                          box: box)));
                                        }
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImmagineANomeWidget(
                                                        box: box)));
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 190,
                          decoration: BoxDecoration(
                            boxShadow: const [
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
                            color: const Color(0xFFA56EFF),
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
                                    borderColor: const Color(0x00FFFFFF),
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
                                      await Hive.initFlutter();
                                      var box = await Hive.openBox('quiz');

                                      if (box.get('statoCorrente') == null ||
                                          (box.get('statoCorrente') != null &&
                                                  (box.get('statoCorrente')[
                                                          'categoria']) !=
                                                      widget.categoria ||
                                              box.get('statoCorrente')[
                                                      'tipologia'] !=
                                                  'Associa il nome all\'immagine')) {
                                        var quesiti = await QuizController()
                                            .getRandomQuesiti(
                                                widget.categoria,
                                                'Associa il nome all\'immagine',
                                                widget.user.userID,
                                                widget.caregiverID);

                                        if (quesiti.isEmpty) {
                                          // ignore: use_build_context_synchronously
                                          PanaraInfoDialog.show(
                                            context,
                                            title: "Quiz",
                                            message: "Non ci sono domande!",
                                            buttonText: "Okay",
                                            onTapDismiss: () {
                                              Navigator.pop(context);
                                            },
                                            panaraDialogType:
                                                PanaraDialogType.warning,
                                            barrierDismissible:
                                                false, // optional parameter (default is true)
                                          );
                                        } else {
                                          Map<String, dynamic> statoCorrente = {
                                            'categoria': widget.categoria,
                                            'tipologia':
                                                'Associa il nome all\'immagine',
                                            'indexQuesito': 0,
                                            'mappaRisposte': {},
                                            'countTentativi': quesiti[0]
                                                ['numeroTentativi'],
                                            'inizioTempo': DateTime.now(),
                                            'percentualeBarra': 0.0,
                                            'quesiti': quesiti,
                                            'caregiverID': widget.caregiverID,
                                            'userID': widget.user.userID
                                          };
                                          box.put(
                                              'statoCorrente', statoCorrente);
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NomeAImmagineWidget(
                                                          box: box)));
                                        }
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NomeAImmagineWidget(
                                                        box: box)));
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
