import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/model/contattoSOS.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../controller/image_upload.dart';
import '../model/utente.dart';

class SOScontattoWidget extends StatefulWidget {
  final Utente user;
  final ContattoSOS? item;
  const SOScontattoWidget({Key? key, required this.user, required this.item})
      : super(key: key);

  @override
  _SOScontattoWidgetState createState() => _SOScontattoWidgetState();
}

class _SOScontattoWidgetState extends State<SOScontattoWidget> {
  String imagContatto = '';

  TextEditingController? nomeController;
  TextEditingController? cognomeController;
  TextEditingController? telefonoController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(); //nome
    cognomeController = TextEditingController(); //cognome
    telefonoController = TextEditingController(); //numero di telefono

    if (widget.item != null) {
      nomeController!.text = widget.item!.name;
      cognomeController!.text = widget.item!.lastname;
      telefonoController!.text = widget.item!.cell;
    }
  }

  @override
  void dispose() {
    nomeController?.dispose();
    cognomeController?.dispose();
    telefonoController?.dispose();
    super.dispose();
  }

/*Questa funzione elimina l'immagine che c'era prima e carica quella
passata come parametro */
  Future<String> updateImage(String imagContatto, String imagPrecedente) async {
    ImageUpload().deleteFile(imagPrecedente);
    return await ImageUpload().uploadImage(imagContatto);
  }

  static String sosIdGenerator(int len) {
    var r = Random();
    const chars = '1234567890aAbBcCdDeEfFgGhHiIlLmMnNoOpPqQrRsStTuUvVzZ';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var confirmDialogResponse = await PanaraConfirmDialog.show(
          context,
          title: "Creazione ricordo",
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

          barrierDismissible: false, // optional parameter (default is true)
        );
        if (confirmDialogResponse) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Contatto',
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
                    title: "Creazione ricordo",
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Foto profilo del contatto',
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
                                    0, 20, 0, 0),
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
                                        var imagePath = await ImageUpload()
                                            .pickFile('image');
                                        if (imagePath != null) {
                                          setState(() {
                                            imagContatto = imagePath;
                                          });
                                        }
                                      },
                                      /*Qui c'è una doppia condizione: 
                                    - Se imagContatto è diverso da null allora significa che noi abbiamo
                                    cliccato sul bottone dell'immagine per caricarne una e quindi imagContatto
                                    conterrà l'URL di firestore. 
                                    - Se invece è null allora controllo se item non è null. Se è questo il caso allora
                                    significa che ho passato un contatto da modificare a questo widget
                                    - Se anche item è null allora significa che devo creare un nuovo contatto.
                                    - Tutto questo viene fatto usando l'operatore ternario in maniera nidificata.
                                     */
                                      child: imagContatto != ''
                                          ? Image.asset(
                                              imagContatto,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : widget.item != null
                                              ? Image.network(
                                                  widget.item!.profileImgPath,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Informazioni contatto',
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
                                    0, 20, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Inserisci il nome';
                                          }
                                          return null;
                                        },
                                        controller: nomeController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Nome',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                    0, 5, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Inserisci il cognome';
                                          }
                                          return null;
                                        },
                                        controller: cognomeController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Cognome',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Inserisci il numero di telefono';
                                          }
                                          return null;
                                        },
                                        controller: telefonoController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Telefono',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderErrorColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                      child: FFButtonWidget(
                        /* 
                      Quando clicco su Salva devo andare a creare un nuovo
                      contatto ed aggiungerlo alla colezione "Quesiti" del 
                      paziente. Se essa non esiste allora viene creata. */
                        onPressed: () async {
                          //Controlli sui campi riempiti
                          if (formKey.currentState == null ||
                              !formKey.currentState!.validate()) {
                            return;
                          }
                          if (widget.item != null) {
                            // ignore: prefer_typing_uninitialized_variables
                            var filePath;
                            if (imagContatto != '') {
                              filePath =
                                  await ImageUpload().uploadImage(imagContatto);
                            }
                            final contattoSOS = ContattoSOS(
                              contattoID: widget.item!.contattoID,
                              name: nomeController!.text,
                              lastname: cognomeController!.text,
                              cell: telefonoController!.text,
                              profileImgPath: filePath ?? '',
                            );
                            contattoSOS.createContatto(widget.user.userID);
                            Fluttertoast.showToast(msg: 'Contatto Creato');
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } else {
                            // ignore: prefer_typing_uninitialized_variables
                            var imageUrlSos;
                            if (imagContatto != '') {
                              imageUrlSos =
                                  await ImageUpload().uploadImage(imagContatto);
                            }
                            if (imageUrlSos == null) {
                              Fluttertoast.showToast(
                                  msg: 'Caricare un\'immagine');
                            } else {
                              // ignore: prefer_typing_uninitialized_variables
                              var filePath;
                              if (imagContatto != '') {
                                filePath = await ImageUpload()
                                    .uploadImage(imagContatto);
                              }
                              final contattoSOS = ContattoSOS(
                                contattoID: sosIdGenerator(28),
                                name: nomeController!.text,
                                lastname: cognomeController!.text,
                                cell: telefonoController!.text,
                                profileImgPath: filePath ?? '',
                              );
                              contattoSOS.createContatto(widget.user.userID);
                              Fluttertoast.showToast(msg: 'Contatto Creato');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          } //fine if
                        },
                        text: 'Salva',
                        options: FFButtonOptions(
                          width: 150,
                          height: 65,
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
      ),
    );
  }
}
