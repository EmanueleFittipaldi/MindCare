import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:mindcare/model/quesito.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../controller/image_upload.dart';
import '../model/utente.dart';

class CreazioneDomandaImmagineANomeWidget extends StatefulWidget {
  final Utente user;
  final String? tipologia;
  final String? categoria;
  final Quesito? item;
  const CreazioneDomandaImmagineANomeWidget(
      {Key? key,
      required this.user,
      required this.tipologia,
      required this.categoria,
      required this.item})
      : super(key: key);

  @override
  _CreazioneDomandaImmagineANomeWidgetState createState() =>
      _CreazioneDomandaImmagineANomeWidgetState();
}

class _CreazioneDomandaImmagineANomeWidgetState
    extends State<CreazioneDomandaImmagineANomeWidget> {
  // Path delle quattro immagini che il caregiver sceglie come opzioni
  String imagOp1 = '';
  String imagOp2 = '';
  String imagOp3 = '';
  String imagOp4 = '';

  TextEditingController? textController;
  String? dropDownValue;
  String dropDownValueTime = '10';
  String dropDownValueTentativi = '1';
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

    /*Se è stato passato un quesito riempio i placeholder */
    if (widget.item != null) {
      textController!.text = widget.item!.domanda!;
      dropDownValue = widget.item!.risposta!;
      dropDownValueTime = widget.item!.tempoRisposta!.toString();
      dropDownValueTentativi = widget.item!.numeroTentativi!.toString();
    }
  }

  @override
  void dispose() {
    textController?.dispose();
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
          'Domanda',
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
                var confirmDialogResponse = await PanaraConfirmDialog.show(
                  context,
                  title: "Creazione domanda",
                  message:
                      "Vuoi davvero annullare la creazione? Tutti i dati verranno persi!",
                  confirmButtonText: "Conferma",
                  cancelButtonText: "Annulla",
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
                if (confirmDialogResponse) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
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
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Associa l\'immagine al nome',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Inserisci il titolo della domanda!';
                            }
                            var val = value.replaceAll(' ', '');
                            if (val.isEmpty || value.isEmpty) {
                              return 'Inserisci il titolo della domanda!';
                            }

                            return null;
                          },
                          controller: textController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Testo domanda:',
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
                          maxLines: 5,
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
                              child: Text(
                                'Inserisci risposte',
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: InkWell(
                                          /*Caricamento immagine 1 al Tap*/
                                          onTap: () async {},
                                          child: Container(
                                            width: 70,
                                            height: 70,
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
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                var imagePath =
                                                    await ImageUpload()
                                                        .pickFile('image');
                                                if (imagePath != null) {
                                                  setState(() {
                                                    imagOp1 = imagePath;
                                                  });
                                                }
                                              },
                                              child: imagOp1 != ''
                                                  ? Image.file(
                                                      File(imagOp1),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : widget.item != null
                                                      ? Image.network(
                                                          widget
                                                              .item!.opzione1!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          '1',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            width: 70,
                                            height: 70,
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
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                var imagePath =
                                                    await ImageUpload()
                                                        .pickFile('image');
                                                if (imagePath != null) {
                                                  setState(() {
                                                    imagOp2 = imagePath;
                                                  });
                                                }
                                              },
                                              child: imagOp2 != ''
                                                  ? Image.file(
                                                      File(imagOp2),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : widget.item != null
                                                      ? Image.network(
                                                          widget
                                                              .item!.opzione2!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          '2',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            width: 70,
                                            height: 70,
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
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                var imagePath =
                                                    await ImageUpload()
                                                        .pickFile('image');
                                                if (imagePath != null) {
                                                  setState(() {
                                                    imagOp3 = imagePath;
                                                  });
                                                }
                                              },
                                              child: imagOp3 != ''
                                                  ? Image.file(
                                                      File(imagOp3),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : widget.item != null
                                                      ? Image.network(
                                                          widget
                                                              .item!.opzione3!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          '3',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            width: 70,
                                            height: 70,
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
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                var imagePath =
                                                    await ImageUpload()
                                                        .pickFile('image');
                                                if (imagePath != null) {
                                                  setState(() {
                                                    imagOp4 = imagePath;
                                                  });
                                                }
                                              },
                                              child: imagOp4 != ''
                                                  ? Image.file(
                                                      File(imagOp4),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : widget.item != null
                                                      ? Image.network(
                                                          widget
                                                              .item!.opzione4!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          '4',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15, 15, 15, 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SelectionArea(
                                child: Text(
                              'Seleziona risposta corretta',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: FlutterFlowDropDown(
                                initialOption: dropDownValue ??= 'Immagine 1',
                                options: const [
                                  'Immagine 1',
                                  'Immagine 2',
                                  'Immagine 3',
                                  'Immagine 4'
                                ],
                                onChanged: (val) async {
                                  setState(() {
                                    dropDownValue = val;
                                  });
                                },
                                width: 180,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                    ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).borderColor,
                                borderWidth: 0,
                                borderRadius: 10,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Tempo per vedere la risposta (in secondi)',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: FlutterFlowDropDown(
                                initialOption: dropDownValueTime,
                                options: const ['5', '10', '30', '60'],
                                onChanged: (val) async {
                                  setState(() {
                                    dropDownValueTime = val!;
                                  });
                                },
                                width: 180,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                    ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).borderColor,
                                borderWidth: 0,
                                borderRadius: 10,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Numero di tentativi',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: FlutterFlowDropDown(
                                initialOption: dropDownValueTentativi,
                                options: const ['1', '2', '3', '4'],
                                onChanged: (val) async {
                                  setState(() {
                                    dropDownValueTentativi = val!;
                                  });
                                },
                                width: 180,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                    ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).borderColor,
                                borderWidth: 0,
                                borderRadius: 10,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                    child: FFButtonWidget(
                      onPressed: () async {
                        /* Quando clicco su Salva devo andare a creare un nuovo
                        Quesito ed aggiungerlo alla collezione "Quesiti" del 
                        paziente. Se essa non esiste allora viene creata. */

                        //Controlli sui campi riempiti
                        if (formKey.currentState == null ||
                            !formKey.currentState!.validate()) {
                          return;
                        }

                        /*Caso in cui sto modificando un quesito già
                        esistente */

                        if (widget.item != null) {
                          QuizController().updateQuesitoImgNome(
                              widget.user.userID,
                              widget.item,
                              widget.categoria,
                              widget.tipologia,
                              imagOp1,
                              imagOp2,
                              imagOp3,
                              imagOp4,
                              textController?.text,
                              dropDownValue!,
                              dropDownValueTime,
                              int.parse(dropDownValueTentativi));

                          //Una volta modificato il quesito ritorno a GestioneQuiz
                          /*Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GestionQuizWidget(user: widget.user)));*/
                          Navigator.of(context).pop();
                        } else {
                          //caricamento immagine 1 su firebase
                          // ignore: prefer_typing_uninitialized_variables
                          var imageUrlOp1;
                          if (imagOp1 != '') {
                            imageUrlOp1 =
                                await ImageUpload().uploadImage(imagOp1);
                          }

                          //caricamento immagine 2 su firebase
                          // ignore: prefer_typing_uninitialized_variables
                          var imageUrlOp2;
                          if (imagOp2 != '') {
                            imageUrlOp2 =
                                await ImageUpload().uploadImage(imagOp2);
                          }

                          //caricamento immagine 3 su firebase
                          // ignore: prefer_typing_uninitialized_variables
                          var imageUrlOp3;
                          if (imagOp3 != '') {
                            imageUrlOp3 =
                                await ImageUpload().uploadImage(imagOp3);
                          }

                          //Caricamento immagine 4 su firebase
                          // ignore: prefer_typing_uninitialized_variables
                          var imageUrlOp4;
                          if (imagOp4 != '') {
                            imageUrlOp4 =
                                await ImageUpload().uploadImage(imagOp4);
                          }

                          /*Faccio un controllo se sono state effettivamente
                          caricate delle immagini, altrimenti impedisco la creazione
                          della domanda */

                          if (imageUrlOp1 == null ||
                              imageUrlOp2 == null ||
                              imageUrlOp3 == null ||
                              imageUrlOp4 == null) {
                            Fluttertoast.showToast(msg: 'Caricare le immagini');
                          } else {
                            //Creazione del quesito
                            QuizController().createQuesitoImgNome(
                                widget.user,
                                imageUrlOp1,
                                imageUrlOp2,
                                imageUrlOp3,
                                imageUrlOp4,
                                textController?.text,
                                dropDownValue,
                                widget.categoria,
                                widget.tipologia,
                                dropDownValueTime,
                                int.parse(dropDownValueTentativi));

                            //Una volta creato il quesito ritorno a GestioneQuiz
                            /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    GestionQuizWidget(user: widget.user)));*/
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        } //fine if
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
                        borderRadius: 30,
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
