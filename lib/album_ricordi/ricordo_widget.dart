import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/appbar/appbar_paziente.dart';
import 'package:mindcare/gestione_ricordi/ricordo.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_to_speech/text_to_speech.dart';

class RicordoWidget extends StatefulWidget {
  final Ricordo ricordo;
  const RicordoWidget({Key? key, required this.ricordo}) : super(key: key);

  @override
  _RicordoWidgetState createState() => _RicordoWidgetState();
}

class _RicordoWidgetState extends State<RicordoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextToSpeech tts = TextToSpeech();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: widget.ricordo.tipoRicordo == 'Video'
                          ? FlutterFlowVideoPlayer(
                              path: widget.ricordo.filePath,
                              videoType: VideoType.network,
                              autoPlay: false,
                              looping: true,
                              showControls: true,
                              allowFullScreen: true,
                              allowPlaybackSpeedMenu: false,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.ricordo.filePath,
                                width: 100,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 5),
                      child: SelectionArea(
                          child: Text(
                        widget.ricordo.titolo,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                      )),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 0, 0, 10),
                          child: SelectionArea(
                              child: Text(
                            widget.ricordo.annoRicordo.toString(),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyText2
                                .override(
                                  fontFamily: 'IBM Plex Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                ),
                          )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 45,
                            icon: FaIcon(
                              FontAwesomeIcons.volumeLow,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20,
                            ),
                            onPressed: () {
                              if (widget.ricordo.descrizione == '') {
                                Fluttertoast.showToast(
                                    msg:
                                        'Non è presente una descrizione da leggere!');
                              } else {
                                String language = 'it-IT';
                                tts.setLanguage(language);
                                tts.setPitch(1.1);
                                tts.setRate(0.8);
                                tts.speak(widget.ricordo.descrizione);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 5, 15, 10),
                      child: SelectionArea(
                          child: Text(
                        widget.ricordo.descrizione,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                            ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
