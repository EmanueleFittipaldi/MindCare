import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RicordoImmagineWidget extends StatefulWidget {
  const RicordoImmagineWidget({Key? key}) : super(key: key);

  @override
  _RicordoImmagineWidgetState createState() => _RicordoImmagineWidgetState();
}

class _RicordoImmagineWidgetState extends State<RicordoImmagineWidget> {
  bool isMediaUploading1 = false;
  String uploadedFileUrl1 = '';

  bool isMediaUploading2 = false;
  String uploadedFileUrl2 = '';

  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Ricordo',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
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
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Titolo:',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
                        child: TextFormField(
                          controller: textController2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Anno ricordo:',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 5),
                                child: Text(
                                  'Inserisci immagine o video',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset(
                                        'assets/images/add_photo.png',
                                      ).image,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Color(0x3A000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      //;
                                    },
                                    child: Image.asset(
                                      'assets/images/add_photo.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 10),
                              child: InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/add_photo.png',
                                      ).image,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Color(0x3A000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const FlutterFlowVideoPlayer(
                                    path:
                                        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
                                    videoType: VideoType.network,
                                    width: double.infinity,
                                    height: double.infinity,
                                    autoPlay: false,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
                        child: TextFormField(
                          controller: textController3,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Descrizione:',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                          maxLines: 7,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState == null ||
                            !formKey.currentState!.validate()) {
                          return;
                        }
                      },
                      text: 'Salva',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'IBM Plex Sans',
                                  color: Colors.white,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
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
