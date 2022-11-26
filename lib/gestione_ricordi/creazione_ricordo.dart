import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/flutter_flow/flutter_flow_drop_down.dart';
import 'package:mindcare/gestione_ricordi/ricordo.dart';
import 'package:mindcare/image_upload.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:video_player/video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class RicordoImmagineWidget extends StatefulWidget {
  final String userID;
  const RicordoImmagineWidget({Key? key, required this.userID})
      : super(key: key);

  @override
  _RicordoImmagineWidgetState createState() => _RicordoImmagineWidgetState();
}

class _RicordoImmagineWidgetState extends State<RicordoImmagineWidget> {
  bool isMediaUploading1 = false;
  String uploadedFileUrl1 = '';
  String? dropDownType;
  bool isMediaUploading2 = false;
  String uploadedFileUrl2 = '';
  String imagePickedPath = '';
  String videoPickedPath = '';
  TextEditingController? controllerTitolo;
  TextEditingController? controllerAnno;
  TextEditingController? controllerDescrizione;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController _videoPlayerController;
  bool? switchDescritpionValue = true;
  @override
  void initState() {
    super.initState();
    controllerTitolo = TextEditingController();
    controllerAnno = TextEditingController();
    controllerDescrizione = TextEditingController();
  }

  @override
  void dispose() {
    controllerTitolo?.dispose();
    controllerAnno?.dispose();
    controllerDescrizione?.dispose();
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserisci un titolo!';
                            }
                            return null;
                          },
                          controller: controllerTitolo,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Titolo:',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .borderErrorColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .borderErrorColor,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserisci l\'anno del ricordo!';
                            } else if (value.length != 4) {
                              return 'Anno non valido!';
                            }
                            final n = num.tryParse(value);
                            if (n == null) {
                              return '"$value" non è un numero!';
                            }
                            if (n < 1800 || n > DateTime.now().year) {
                              return 'Anno non valido!';
                            }
                            return null;
                          },
                          controller: controllerAnno,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Anno ricordo:',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .borderErrorColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .borderErrorColor,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: FlutterFlowDropDown(
                                initialOption: dropDownType ??= 'Immagine',
                                options: const ['Video', 'Immagine'],
                                onChanged: (val) async {
                                  setState(() {
                                    dropDownType = val;
                                    imagePickedPath = '';
                                    videoPickedPath = '';
                                    switchDescritpionValue = true;
                                  });
                                },
                                width: double.infinity,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).borderColor,
                                borderWidth: 1,
                                borderRadius: 10,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                            dropDownType == 'Immagine'
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                    child: InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        width: double.infinity,
                                        height: 160,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 6,
                                              color: Color(0x3A000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            var imagePath = await ImageUpload()
                                                .pickFile('image');
                                            if (imagePath != null) {
                                              setState(() {
                                                imagePickedPath = imagePath;
                                              });
                                            }
                                          },
                                          child: Image.asset(
                                            imagePickedPath != ''
                                                ? imagePickedPath
                                                : 'assets/images/add_photo_plus.png',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : videoPickedPath == ''
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            width: double.infinity,
                                            height: 160,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 6,
                                                  color: Color(0x3A000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                var videoPath =
                                                    await ImageUpload()
                                                        .pickFile('video');
                                                if (videoPath != null) {
                                                  var _video = File(videoPath);

                                                  _videoPlayerController =
                                                      VideoPlayerController
                                                          .file(_video)
                                                        ..initialize()
                                                            .then((_) {
                                                          setState(() {
                                                            videoPickedPath =
                                                                videoPath;
                                                          });
                                                          _videoPlayerController
                                                              .play();
                                                        });
                                                }
                                              },
                                              child: Image.asset(
                                                'assets/images/add_video.png',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : AspectRatio(
                                        aspectRatio: _videoPlayerController
                                            .value.aspectRatio,
                                        child:
                                            VideoPlayer(_videoPlayerController),
                                      )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Text(
                                'Descrizione: ',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: dropDownType == 'Video'
                                  ? Switch(
                                      value: switchDescritpionValue ??= true,
                                      onChanged: (newValue) async {
                                        setState(() =>
                                            switchDescritpionValue = newValue);
                                      },
                                      activeColor: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      inactiveThumbColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                    )
                                  : Switch(
                                      value: true,
                                      onChanged: null,
                                      activeColor: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      inactiveThumbColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      switchDescritpionValue == true
                          ? Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 5, 15, 5),
                              child: TextFormField(
                                validator: (value) {
                                  if (switchDescritpionValue == false) {
                                    return null;
                                  }
                                  if (value == null || value.isEmpty) {
                                    return 'Inserisci una descrizione!';
                                  }
                                  return null;
                                },
                                controller: controllerDescrizione,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Descrizione:',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 7,
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            (imagePickedPath != '' || videoPickedPath != '')) {
                          var filePath;
                          if (imagePickedPath != '') {
                            filePath = await ImageUpload()
                                .uploadImage(imagePickedPath);
                          } else if (videoPickedPath != '') {
                            filePath = await ImageUpload()
                                .uploadVideo(videoPickedPath);
                          }
                          final ricordo = Ricordo(
                              titolo: controllerTitolo!.text,
                              annoRicordo: int.parse(controllerAnno!.text),
                              descrizione: controllerDescrizione!.text,
                              filePath: filePath ?? '');
                          ricordo.createMemory(widget.userID);
                          Navigator.of(context).pop();
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Inserisci tutti i campi!');
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
