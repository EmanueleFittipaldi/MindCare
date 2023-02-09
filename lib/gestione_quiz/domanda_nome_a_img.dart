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

class CreazioneDomandaNomeAImmagineWidget extends StatefulWidget {
  final Utente user;
  final String? tipologia;
  final String? categoria;
  final Quesito? item;
  const CreazioneDomandaNomeAImmagineWidget(
      {Key? key,
      required this.user,
      required this.tipologia,
      required this.categoria,
      required this.item})
      : super(key: key);

  @override
  _CreazioneDomandaNomeAImmagineWidgetState createState() =>
      _CreazioneDomandaNomeAImmagineWidgetState();
}

class _CreazioneDomandaNomeAImmagineWidgetState
    extends State<CreazioneDomandaNomeAImmagineWidget> {
  String imagDomanda = '';

  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textController5;
  String? dropDownValue; //valore del dropdown
  String dropDownValueTime = '10';
  String dropDownValueTentativi = '1';
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(); //testo della domanda
    textController2 = TextEditingController(); //opzione1
    textController3 = TextEditingController(); //opzione2
    textController4 = TextEditingController(); //opzione3
    textController5 = TextEditingController(); //opzione4

    if (widget.item != null) {
      textController1!.text = widget.item!.domanda!;
      textController2!.text = widget.item!.opzione1!;
      textController3!.text = widget.item!.opzione2!;
      textController4!.text = widget.item!.opzione3!;
      textController5!.text = widget.item!.opzione4!;
      dropDownValue = widget.item!.risposta!;
      dropDownValueTime = widget.item!.tempoRisposta!.toString();
      dropDownValueTentativi = widget.item!.numeroTentativi!.toString();
    }
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    super.dispose();
  }

/*Questa funzione elimina l'immagine che c'era prima e carica quella
passata come parametro */
  Future<String> updateImage(String imagDomanda, String imagPrecedente) async {
    ImageUpload().deleteFile(imagPrecedente);
    return await ImageUpload().uploadImage(imagDomanda);
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
                    'Associa il nome all\'immagine',
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
                        //valido il campo di "Testo domanda". Voglio che ci sia
                        //qualcosa scritto
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
                          controller: textController1,
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
                                'Inserisci immagine domanda',
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
                                  0, 4, 0, 0),
                              child: InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: 100,
                                  height: 100,
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
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    /*Quando clicco sull'icona di Inserisci immagine domanda
                                    faccio selezionare una immagine dalla galleria all'utente*/
                                    onTap: () async {
                                      var imagePath =
                                          await ImageUpload().pickFile('image');
                                      if (imagePath != null) {
                                        setState(() {
                                          imagDomanda = imagePath;
                                        });
                                      }
                                    },
                                    /*Qui c'è una doppia condizione: 
                                    - Se imagDomanda è diverso da null allora significa che noi abbiamo
                                    cliccato sul bottone dell'immagine per caricarne una e quindi imagDomanda
                                    conterrà l'URL di firestore. 
                                    - Se invece è null allora controllo se item non è null. Se è questo il caso allora
                                    significa che ho passato un Quesito da modificare a questo widget
                                    - Se anche item è null allora significa che devo creare un nuovo quesito.
                                    - Tutto questo viene fatto usando l'operatore ternario in maniera nidificata.
                                     */
                                    child: imagDomanda != ''
                                        ? Image.file(
                                            File(imagDomanda),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : widget.item != null
                                            ? Image.network(
                                                widget.item!.domandaImmagine!,
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
                          ],
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
                                  0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: Text(
                                      '1',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Inserisci l\'opzione1';
                                        }
                                        var val = value.replaceAll(' ', '');
                                        if (val.isEmpty || value.isEmpty) {
                                          return 'Inserisci l\'opzione1';
                                        }

                                        return null;
                                      },
                                      controller: textController2,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Opzione 1',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: Text(
                                      '2',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Inserisci l\'opzione2';
                                        }
                                        var val = value.replaceAll(' ', '');
                                        if (val.isEmpty || value.isEmpty) {
                                          return 'Inserisci l\'opzione2';
                                        }
                                        return null;
                                      },
                                      controller: textController3,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Opzione 2',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: Text(
                                      '3',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Inserisci l\'opzione3';
                                        }
                                        var val = value.replaceAll(' ', '');
                                        if (val.isEmpty || value.isEmpty) {
                                          return 'Inserisci l\'opzione3';
                                        }
                                        return null;
                                      },
                                      controller: textController4,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Opzione 3',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: Text(
                                      '4',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Inserisci l\'opzione3';
                                        }
                                        var val = value.replaceAll(' ', '');
                                        if (val.isEmpty || value.isEmpty) {
                                          return 'Inserisci l\'opzione3';
                                        }
                                        return null;
                                      },
                                      controller: textController5,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Opzione 4',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .borderErrorColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
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
                                /*Qui sto usando il cosìddetto operatore ternario
                                testCondition ? trueValue : falseValue
                                Questo mi permette di assegnare un valore ad un parametro
                                del widget in base ad una condizione. In questo caso controllo
                                se è stato passato un Quesito se si allora significa che ho
                                cliccato in precedenza sull'icona della matita per modificare 
                                il quesito */
                                initialOption: dropDownValue ??= 'Opzione 1',
                                options: const [
                                  'Opzione 1',
                                  'Opzione 2',
                                  'Opzione 3',
                                  'Opzione 4'
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
                      /* 
                      Quando clicco su Salva devo andare a creare un nuovo
                      Quesito ed aggiungerlo alla colezione "Quesiti" del 
                      paziente. Se essa non esiste allora viene creata. */
                      onPressed: () async {
                        //Controlli sui campi riempiti
                        if (formKey.currentState == null ||
                            !formKey.currentState!.validate()) {
                          return;
                        }

                        /*
                        Distinguo il caso della modifica di un quesito esistente
                        dalla creazione di un nuovo quesito constatando se è stato
                        passato un oggetto di tipo Quesito a domanda_nome_a_imag.dart
                        oppure no */

                        if (widget.item != null) {
                          QuizController().updateQuesitoNomeImg(
                              widget.user.userID,
                              widget.item,
                              textController2?.text,
                              textController3?.text,
                              textController4?.text,
                              textController5?.text,
                              textController1?.text,
                              imagDomanda,
                              dropDownValue,
                              widget.categoria,
                              widget.tipologia,
                              dropDownValueTime,
                              int.parse(dropDownValueTentativi));

                          //Una volta modificato il quesito ritorno a GestioneQuiz
                          /*Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GestionQuizWidget(user: widget.user)));*/
                          Navigator.of(context).pop();
                        } else {
                          // Caricamento dell'immagine oggetto
                          // della domanda su firebase
                          // ignore: prefer_typing_uninitialized_variables
                          var imageUrlDomanda;
                          if (imagDomanda != '') {
                            imageUrlDomanda =
                                await ImageUpload().uploadImage(imagDomanda);
                          }
                          if (imageUrlDomanda == null) {
                            Fluttertoast.showToast(
                                msg: 'Caricara un\'immagine');
                          } else {
                            //Creazione del quesito
                            QuizController().creazioneQuesitoNomeImg(
                                widget.user,
                                textController2?.text,
                                textController3?.text,
                                textController4?.text,
                                textController5?.text,
                                textController1?.text,
                                imageUrlDomanda,
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
                          borderRadius: 30),
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
