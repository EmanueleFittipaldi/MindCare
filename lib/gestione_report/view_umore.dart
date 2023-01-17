import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/model/umore.dart';
import 'package:mindcare/model/utente.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';

class ViewUmore extends StatefulWidget {
  final Utente user;
  final List<Umore> data;

  const ViewUmore({
    Key? key,
    required this.user,
    required this.data,
  }) : super(key: key);

  @override
  _ViewUmoreState createState() => _ViewUmoreState();
}

class _ViewUmoreState extends State<ViewUmore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  getEmoticon(umore) {
    String image = '';
    switch (umore) {
      case 0:
        image = 'assets/images/angry.png';
        break;
      case 1:
        image = 'assets/images/sad.png';
        break;
      case 2:
        image = 'assets/images/neutral.png';
        break;
      case 3:
        image = 'assets/images/happy.png';
        break;
      case 4:
        image = 'assets/images/excited.png';
        break;
    }
    return image;
  }

  getEmoji(String text) {
    var emoji = ['😡', '🙁', '😐', '🙂', '😍'];
    var t = text.split(' ').last;
    return getEmoticon(emoji.indexOf(t));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Risposte umore',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var item in widget.data)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                    child: Container(
                      width: double.infinity,
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
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 5, 0, 0),
                                            child: Text(
                                              'Tipologia risposta:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 0, 0, 0),
                                          child: Text(
                                            item.type,
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color:
                                                      const Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 5, 0, 0),
                                            child: Text(
                                              'Data risposta:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 5, 0, 0),
                                          child: Text(
                                            DateFormat('dd-MM-yyyy HH:mm')
                                                .format(item.data)
                                                .toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color:
                                                      const Color(0xFF101213),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 5, 16, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Score:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                              ),
                                              Text(
                                                '${item.score}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        item.type != 'quiz'
                                            ? Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 5, 16, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Emoticon:',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .subtitle1
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: const Color(
                                                                0xFF101213),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                    Image.asset(
                                                      getEmoji(item.text),
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.contain,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 5, 16, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .subtitle1
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: const Color(
                                                                0xFF101213),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                    Text(
                                                      '',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .subtitle1
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: const Color(
                                                                0xFF101213),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          width: 200,
                                          height: 185,
                                          child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 0, 0, 5),
                                                      child: Text(
                                                        'Risposta:',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                      )),
                                                  item.type == 'quiz'
                                                      ? Image.asset(
                                                          getEmoticon(
                                                              item.score),
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  16, 5, 0, 0),
                                                          child: AutoSizeText(
                                                            item.text.substring(
                                                                0,
                                                                item.text
                                                                        .length -
                                                                    2),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: const Color(
                                                                      0xFF101213),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                          )),
                                                ]),
                                          ),
                                        ),
                                      ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.type, this.value);
  final String type;
  final int value;
}
