import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/controller/quiz_controller.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ViewDomande extends StatefulWidget {
  final String uid;
  final Map<String, bool> mappaRisposte;
  const ViewDomande({Key? key, required this.uid, required this.mappaRisposte})
      : super(key: key);

  @override
  _ViewDomandeState createState() => _ViewDomandeState();
}

class _ViewDomandeState extends State<ViewDomande> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Domande',
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
            child: FutureBuilder(
              future: QuizController().getQuesitiByID(widget.uid,
                  Auth().currentUser!.uid, widget.mappaRisposte.keys),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = [];
                  snapshot.data!.forEach((e) {
                    data.add(e);
                  });

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              for (var item in data)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 12,
                                          color: Color(0x14000000),
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 8, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: 120,
                                              height: 120,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: item.domandaImmagine != ''
                                                  ? Image.network(
                                                      item.domandaImmagine,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Image.network(
                                                      item.risposta,
                                                      fit: BoxFit.contain,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 0, 0),
                                                    child: AutoSizeText(
                                                      item.domanda,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                fontSize: 18,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: widget.mappaRisposte[
                                                        item.quesitoID] ==
                                                    true
                                                ? Icon(
                                                    Icons.check_rounded,
                                                    color: Color(0xFF17901E),
                                                    size: 40,
                                                  )
                                                : Icon(
                                                    Icons.clear_rounded,
                                                    color: Color(0xFFAB2B40),
                                                    size: 40,
                                                  ),
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
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}
