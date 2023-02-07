import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mindcare/controller/image_upload.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:mindcare/notification_service.dart';
import 'package:mindcare/widget_tree.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../controller/auth.dart';

import '../model/utente.dart';

// ignore: must_be_immutable
class OpzioniWidget extends StatefulWidget {
  Utente user;
  final String caregiverUID;
  OpzioniWidget({Key? key, required this.user, required this.caregiverUID})
      : super(key: key);

  @override
  _OpzioniWidgetState createState() => _OpzioniWidgetState();
}

class _OpzioniWidgetState extends State<OpzioniWidget> {
  DateTime? datePicked;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textcontrollerData;
  String imagePickedPath = '';
  late bool passwordVisibility1;
  TextEditingController? textController5;

  late bool passwordVisibility2;
  TextEditingController? textController6;
  PageController? pageViewController;
  int pageIndex = 0;
  late bool passwordVisibility3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? switchBiometric;
  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: widget.user.name);
    textController2 = TextEditingController(text: widget.user.lastname);
    textController3 = TextEditingController(text: widget.user.email);
    textController4 = TextEditingController();
    textcontrollerData = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(widget.user.date));
    passwordVisibility1 = false;
    textController5 = TextEditingController();
    passwordVisibility2 = false;
    textController6 = TextEditingController();
    passwordVisibility3 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    textController6?.dispose();
    textcontrollerData?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: StreamBuilder(
          stream: widget.user.type == 'Paziente'
              ? FirebaseFirestore.instance
                  .collection('user')
                  .doc(widget.caregiverUID)
                  .collection('Pazienti')
                  .snapshots()
              : FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ignore: prefer_typing_uninitialized_variables
              var data;
              snapshot.data?.docs.forEach((doc) {
                //iterazione sui singoli documenti
                Map<String, dynamic>? cmap = doc.data();
                if (cmap!['userID'] == Auth().currentUser!.uid) {
                  data = cmap;
                } //mappatura dei dati
              });
              if (data != null) {
                widget.user = Utente(
                    userID: data['userID'],
                    name: data['name'],
                    lastname: data['lastname'],
                    email: data['email'],
                    type: data['type'],
                    date: (data?['dateOfBirth'] as Timestamp).toDate(),
                    profileImgPath: data['profileImagePath'],
                    checkBiometric: data['checkBiometric']);

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        width: double.infinity,
                        height: 500,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            25, 30, 15, 0),
                                    child: SelectionArea(
                                        child: Text(
                                      'Impostazioni',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 30, 20, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Modifica dati',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.9, 0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      pageViewController!
                                                          .jumpToPage(2);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 18,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 12, 20, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Biometria',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.9, 0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      pageViewController!
                                                          .jumpToPage(1);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 18,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 12, 20, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Termini & Servizi',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.9, 0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    pageViewController!
                                                        .jumpToPage(3);
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 12, 20, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Elimina account',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.9, 0),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    var confirmDialogResponse =
                                                        await PanaraConfirmDialog
                                                            .show(
                                                      context,
                                                      title:
                                                          "Eliminazione account",
                                                      message:
                                                          "Vuoi davvero eliminare l'account? L'azione è irreversibile!",
                                                      confirmButtonText:
                                                          "Conferma",
                                                      cancelButtonText:
                                                          "Annulla",
                                                      onTapCancel: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      onTapConfirm: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      panaraDialogType:
                                                          PanaraDialogType
                                                              .error,

                                                      barrierDismissible:
                                                          false, // optional parameter (default is true)
                                                    );
                                                    if (confirmDialogResponse) {
                                                      // ignore: unused_local_variable
                                                      var success =
                                                          await UserController()
                                                              .deleteAccount(
                                                                  widget
                                                                      .caregiverUID,
                                                                  widget.user
                                                                      .userID,
                                                                  widget.user
                                                                      .type,
                                                                  widget.user
                                                                      .profileImgPath);
                                                      if (success ==
                                                          'error with data') {
                                                        // ignore: use_build_context_synchronously
                                                        PanaraInfoDialog.show(
                                                          context,
                                                          title:
                                                              "Eliminazione account",
                                                          message:
                                                              "Attenzione! Sei responsabile di alcuni pazienti, salva i loro dati ed elimina i loro account prima di eseguire questa operazione!",
                                                          buttonText: "Okay",
                                                          onTapDismiss: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .warning,
                                                          barrierDismissible:
                                                              false, // optional parameter (default is true)
                                                        );
                                                      } else if (success ==
                                                          'success') {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const WidgetTree()));
                                                      }
                                                      // ignore: use_build_context_synchronously

                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color.fromARGB(
                                                        255, 246, 83, 83),
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            80, 40, 80, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                var confirmDialogResponse =
                                                    await PanaraConfirmDialog
                                                        .show(
                                                  context,
                                                  title: "Esci dall'account",
                                                  message:
                                                      "Vuoi davvero uscire dall'account?",
                                                  confirmButtonText: "Esci",
                                                  cancelButtonText: "Annulla",
                                                  onTapCancel: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  onTapConfirm: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  panaraDialogType:
                                                      PanaraDialogType.error,

                                                  barrierDismissible:
                                                      false, // optional parameter (default is true)
                                                );
                                                if (confirmDialogResponse) {
                                                  Auth().signOut();
                                                  NotificationService()
                                                      .cancelAllNotifications();
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const WidgetTree()));
                                                }
                                              },
                                              text: 'Esci',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 60,
                                                color: const Color.fromARGB(
                                                    255, 246, 83, 83),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 30,
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
                            Container(
                                color: Colors.white,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 50,
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 25,
                                            ),
                                            onPressed: () {
                                              pageViewController!.jumpToPage(0);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 0, 0, 0),
                                            child: Text(
                                              'Biometria',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 0),
                                        child: SwitchListTile.adaptive(
                                          value: switchBiometric ??= false,
                                          onChanged: (newValue) async {
                                            print(newValue);
                                            setState(() =>
                                                switchBiometric = newValue);
                                            UserController().useBiometric(
                                                widget.user.type,
                                                Auth().currentUser!.uid,
                                                widget.caregiverUID,
                                                newValue);
                                          },
                                          title: Text(
                                            'Utilizza biometria',
                                            style: FlutterFlowTheme.of(context)
                                                .title3
                                                .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25),
                                          ),
                                          subtitle: Text(
                                            'Accedere all\'applicazione utilizzando la biometria del cellulare.',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 18),
                                          ),
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryColor,
                                          activeTrackColor:
                                              const Color(0x8A4B39EF),
                                          dense: false,
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          contentPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(24, 12, 24, 12),
                                        ),
                                      ),
                                    ])),
                            Container(
                              color: Colors.white,
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 50,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            pageViewController!.jumpToPage(0);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 0, 0, 0),
                                          child: Text(
                                            'Modifica dati',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 15),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                              child: InkWell(
                                                onTap: () async {},
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var imagePath =
                                                          await ImageUpload()
                                                              .pickFile(
                                                                  'image');
                                                      if (imagePath != null) {
                                                        setState(() {
                                                          imagePickedPath =
                                                              imagePath;
                                                        });
                                                      }
                                                    },
                                                    child: imagePickedPath != ''
                                                        ? Image.file(
                                                            File(
                                                                imagePickedPath),
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network(
                                                            widget.user
                                                                .profileImgPath,
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 10),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  setState(() {
                                                    imagePickedPath = '';
                                                  });
                                                },
                                                text: 'Ripristina foto',
                                                options: FFButtonOptions(
                                                  elevation: 0,
                                                  width: 120,
                                                  height: 40,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        0, 255, 255, 255),
                                                    width: 0,
                                                  ),
                                                  borderRadius: 8,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 5),
                                              child: TextFormField(
                                                validator: (value) {
                                                  String val = value!
                                                      .replaceAll(' ', '');
                                                  if (value.isEmpty ||
                                                      val.isEmpty) {
                                                    return 'Inserisci un nome!';
                                                  }
                                                  return null;
                                                },
                                                controller: textController1,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Nome:',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 5),
                                              child: TextFormField(
                                                validator: (value) {
                                                  String val = value!
                                                      .replaceAll(' ', '');
                                                  if (value.isEmpty ||
                                                      val.isEmpty) {
                                                    return 'Inserisci un cognome!';
                                                  }
                                                  return null;
                                                },
                                                controller: textController2,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Cognome:',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 0),
                                              // ignore: sized_box_for_whitespace
                                              child: Container(
                                                width: double.infinity,
                                                height: 55,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 12, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 12, 0),
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Inserisci una data di nascita!';
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                textcontrollerData,
                                                            autofocus: true,
                                                            readOnly: true,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Data di nascita',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .borderColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .borderColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .borderErrorColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .borderErrorColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          await DatePicker
                                                              .showDatePicker(
                                                                  context,
                                                                  showTitleActions:
                                                                      true,
                                                                  onConfirm:
                                                                      (date) {
                                                            setState(() {
                                                              datePicked = date;
                                                              textcontrollerData!
                                                                  .text = datePicked ==
                                                                      null
                                                                  ? 'Data di nascita'
                                                                  : DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(DateTime.parse(
                                                                          datePicked
                                                                              .toString()));
                                                            });
                                                          },
                                                                  currentTime: widget
                                                                      .user
                                                                      .date,
                                                                  minTime:
                                                                      DateTime(
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  maxTime:
                                                                      DateTime(
                                                                    DateTime.now()
                                                                            .year -
                                                                        18,
                                                                    DateTime.now()
                                                                        .month,
                                                                    DateTime.now()
                                                                        .day,
                                                                  ));
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .date_range_outlined,
                                                          color:
                                                              Color(0xFF57636C),
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 5),
                                              child: TextFormField(
                                                validator: (value) {
                                                  String val = value!
                                                      .replaceAll(' ', '');
                                                  if (value.isEmpty ||
                                                      val.isEmpty) {
                                                    return 'Inserisci l\'email!';
                                                  }
                                                  RegExp regex = RegExp(
                                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                                  if (!regex.hasMatch(value)) {
                                                    return 'Inserisci un\'email valida!';
                                                  }
                                                  return null;
                                                },
                                                controller: textController3,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 10),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  var success =
                                                      await UserController()
                                                          .forgottenPassword(
                                                              widget
                                                                  .user.email);
                                                  if (success) {
                                                    // ignore: use_build_context_synchronously
                                                    PanaraInfoDialog.show(
                                                      context,
                                                      title:
                                                          "Modifica password",
                                                      message:
                                                          "Email per la modifica della password inviata!",
                                                      buttonText: "Okay",
                                                      onTapDismiss: () {
                                                        Navigator.pop(context);
                                                      },
                                                      panaraDialogType:
                                                          PanaraDialogType
                                                              .normal,
                                                      barrierDismissible:
                                                          false, // optional parameter (default is true)
                                                    );
                                                  }
                                                },
                                                text: 'Modifica password',
                                                options: FFButtonOptions(
                                                  elevation: 0,
                                                  width: 120,
                                                  height: 60,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 25,
                                                      ),
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        0, 255, 255, 255),
                                                    width: 0,
                                                  ),
                                                  borderRadius: 8,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 15),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  var confirmDialogResponse =
                                                      await PanaraConfirmDialog
                                                          .show(
                                                    context,
                                                    title: "Conferma modifica",
                                                    message:
                                                        "Vuoi confermare le modifiche effettuate?",
                                                    confirmButtonText:
                                                        "Conferma",
                                                    cancelButtonText: "Annulla",
                                                    onTapCancel: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    onTapConfirm: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    panaraDialogType:
                                                        PanaraDialogType.normal,

                                                    barrierDismissible:
                                                        false, // optional parameter (default is true)
                                                  );
                                                  if (confirmDialogResponse) {
                                                    // ignore: prefer_typing_uninitialized_variables
                                                    var image;

                                                    if (imagePickedPath != '') {
                                                      image = await ImageUpload()
                                                          .uploadImage(
                                                              imagePickedPath);
                                                      await ImageUpload()
                                                          .deleteFile(widget
                                                              .user
                                                              .profileImgPath);
                                                    } else {
                                                      image = widget
                                                          .user.profileImgPath;
                                                    }

                                                    var success =
                                                        await UserController()
                                                            .modificaDati(
                                                                textController1
                                                                    ?.text
                                                                    .toString(),
                                                                textController2
                                                                    ?.text
                                                                    .toString(),
                                                                textcontrollerData!
                                                                    .text,
                                                                textController3
                                                                    ?.text
                                                                    .toString(),
                                                                widget
                                                                    .user.type,
                                                                widget.user
                                                                    .userID,
                                                                widget
                                                                    .caregiverUID,
                                                                image);
                                                    if (success) {
                                                      // ignore: use_build_context_synchronously
                                                      PanaraInfoDialog.show(
                                                        context,
                                                        title:
                                                            "Salvataggio modifiche",
                                                        message:
                                                            "Modifiche avvenute con successo!",
                                                        buttonText: "Okay",
                                                        onTapDismiss: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        panaraDialogType:
                                                            PanaraDialogType
                                                                .success,
                                                        barrierDismissible:
                                                            false, // optional parameter (default is true)
                                                      );
                                                    } else {
                                                      // ignore: use_build_context_synchronously
                                                      PanaraInfoDialog.show(
                                                        context,
                                                        title:
                                                            "Salvataggio modifiche",
                                                        message:
                                                            "Ops! Qualcosa è andato storto!",
                                                        buttonText: "Okay",
                                                        onTapDismiss: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        panaraDialogType:
                                                            PanaraDialogType
                                                                .error,
                                                        barrierDismissible:
                                                            false, // optional parameter (default is true)
                                                      );
                                                    }
                                                  }
                                                  imagePickedPath = '';
                                                  pageViewController!.jumpTo(0);
                                                },
                                                text: 'Salva',
                                                options: FFButtonOptions(
                                                  width: 150,
                                                  height: 60,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
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
                                  ])),
                            ),
                            Container(
                                color: Colors.white,
                                child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 50,
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 25,
                                            ),
                                            onPressed: () {
                                              pageViewController!.jumpToPage(0);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 0, 0, 0),
                                            child: Text(
                                              'Termini & Servizi',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(20, 12, 20, 0),
                                        child: Text(
                                          "L'utilizzo dei Servizi avviene a rischio dell'utente ed è soggetto alle seguenti esclusioni di responsabilità. I nostri Servizi sono forniti nello stato in cui si trovano, senza garanzie esplicite o implicite, ivi comprese, a titolo esemplificativo e non esaustivo, garanzie relative a commerciabilità, idoneità per scopo specifico, proprietà o non violazione di diritti di terzi e assenza di virus o altri codici informatici dannosi. Non forniamo alcuna garanzia in merito all'esattezza, alla completezza e all'utilità delle informazioni, al funzionamento, alla mancanza di errori, alla sicurezza o alla protezione dei nostri Servizi o al funzionamento dei nostri Servizi senza interruzioni, ritardi o difetti. Non deteniamo il controllo e non siamo responsabili del controllo della modalità o del momento di utilizzo dei Servizi o delle funzioni, dei servizi e delle interfacce fornite dai nostri Servizi. Non siamo responsabili e non abbiamo l'obbligo di controllare le azioni o le informazioni dei nostri utenti o di altri terzi. L'utente esenta noi, le nostre società controllate e affiliate e i rispettivi dirigenti, amministratori, dipendenti, partner e agenti da ogni reclamo, ricorso, azione legale, controversia, contenzioso o danno, noti e non noti, relativi a, derivanti da o collegati in qualsiasi modo a reclami che l'utente possa avere contro terzi. I diritti dell'utente non vengono modificati dalle presenti esclusioni di responsabilità se le leggi in vigore nel Paese o nel territorio in cui risiede, applicabili come conseguenza dell'utilizzo dei nostri Servizi, non lo permettono.",
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 20),
                                        ),
                                      ),
                                    ]))),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
