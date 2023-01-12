import 'package:mindcare/model/report.dart';
import 'package:mindcare/widget_tree.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizTerminatoWidget extends StatefulWidget {
  final String caregiverID;
  final String userID;
  final String reportID;
  final Report report;

  const QuizTerminatoWidget(
      {Key? key,
      required this.caregiverID,
      required this.userID,
      required this.reportID,
      required this.report})
      : super(key: key);

  @override
  _QuizTerminatoWidgetState createState() => _QuizTerminatoWidgetState();
}

class _QuizTerminatoWidgetState extends State<QuizTerminatoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  createReport(umoreSelezionato) {
    widget.report.umore = umoreSelezionato;

    widget.report
        .createReport(widget.caregiverID, widget.userID, widget.reportID);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PanaraInfoDialog.show(
          context,
          title: "Esci dal quiz",
          message: "Per uscire dal quiz seleziona una delle icone in basso!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.error,
          barrierDismissible: false, // optional parameter (default is true)
        );
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
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 20, 0, 0),
                              child: Text(
                                'Quiz Terminato!',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Image.asset(
                                'assets/images/smart-guy-getting-award-winner-standing-pedestal-holding-golden-cup-cartoon-illustration_74855-14511.jpg.webp',
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 20, 0, 0),
                              child: Text(
                                'Complimenti!',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 8, 0, 0),
                              child: Text(
                                'Come ti senti dopo aver completato il quiz? \nSeleziona l\'icona che più si avvicina al tuo umore corrente.',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 44, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //wrap the Image.network in a InkWell widget
                                  InkWell(
                                    onTap: () {
                                      createReport(0);

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WidgetTree()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/6637/6637186.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      createReport(1);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WidgetTree()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/6637/6637163.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      createReport(2);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WidgetTree()));
                                    },
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/6637/6637207.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      createReport(3);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WidgetTree()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/6637/6637188.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      createReport(4);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WidgetTree()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/6637/6637197.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
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
