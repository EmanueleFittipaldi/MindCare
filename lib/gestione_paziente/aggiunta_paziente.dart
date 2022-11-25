import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/auth.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/image_upload.dart';
import 'package:mindcare/utente.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class AggiuntaPazienteWidget extends StatefulWidget {
  const AggiuntaPazienteWidget({Key? key}) : super(key: key);

  @override
  _AggiuntaPazienteWidgetState createState() => _AggiuntaPazienteWidgetState();
}

class _AggiuntaPazienteWidgetState extends State<AggiuntaPazienteWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';
  String imagePickedPath = '';
  DateTime? datePicked;
  TextEditingController? controllerNome;
  TextEditingController? controllerCognome;
  TextEditingController? controllerUsername;
  TextEditingController? controllerPassword;

  late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controllerNome = TextEditingController();
    controllerCognome = TextEditingController();
    controllerUsername = TextEditingController();
    controllerPassword = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    controllerNome?.dispose();
    controllerCognome?.dispose();
    controllerUsername?.dispose();
    controllerPassword?.dispose();
    super.dispose();
  }

  String generatePassword() {
    String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lower = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1234567890';
    String symbols = '!@#\$%^&*()<>,./-';
    RegExp regex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*()<>,./-]).{8,20}$');
    int passLength = 14;
    String seed = upper + lower + numbers + symbols;
    String password = '';
    List<String> list = seed.split('').toList();
    Random rand = Random();
    while (true) {
      for (int i = 0; i < passLength; i++) {
        int index = rand.nextInt(list.length);
        password += list[index];
      }
      if (regex.hasMatch(password)) {
        break;
      } else {
        password = '';
      }
    }
    return password;
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = '1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future<String?> createNewPatientAccount() async {
    try {
      return await Auth().createNewPatientAccount(
          email: controllerUsername!.text, password: controllerPassword!.text);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Problema con la creazione dell'account!");
    }
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
          'Paziente',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: InkWell(
                                    onTap: () async {},
                                    child: Container(
                                      width: 120,
                                      height: 120,
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
                                        onTap: () async {
                                          var imagePath = await ImageUpload()
                                              .pickFile('image');
                                          if (imagePath != null) {
                                            setState(() {
                                              imagePickedPath = imagePath;
                                            });
                                          }
                                        },
                                        child: imagePickedPath != ''
                                            ? Image.asset(
                                                imagePickedPath,
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Inserisci un nome!';
                                      }
                                      return null;
                                    },
                                    controller: controllerNome,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nome:',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Inserisci un cognome!';
                                      }
                                      return null;
                                    },
                                    controller: controllerCognome,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Cognome:',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: Container(
                                    width: double.infinity,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .borderColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            datePicked == null
                                                ? 'Data di nascita'
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.parse(
                                                        datePicked.toString())),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await DatePicker.showDatePicker(
                                                  context,
                                                  showTitleActions: true,
                                                  onConfirm: (date) {
                                                setState(
                                                    () => datePicked = date);
                                              },
                                                  currentTime:
                                                      getCurrentTimestamp,
                                                  minTime: DateTime(0, 0, 0),
                                                  maxTime: DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day,
                                                  ));
                                            },
                                            child: const Icon(
                                              Icons.date_range_outlined,
                                              color: Color(0xFF57636C),
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 10),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      if (controllerNome!.text.isEmpty ||
                                          controllerCognome!.text.isEmpty) {
                                        controllerPassword!.text = '';
                                        controllerUsername!.text = '';
                                        Fluttertoast.showToast(
                                            msg: 'Inserisci nome o cognome!');
                                      } else {
                                        var stringGenerated =
                                            generateRandomString(4);
                                        controllerUsername!.text =
                                            '${controllerNome!.text[0].toLowerCase()}.${controllerCognome!.text.replaceAll(' ', '').toLowerCase()}.$stringGenerated@paziente.mindcare.it';
                                        controllerPassword!.text =
                                            generatePassword();
                                      }
                                    },
                                    text: 'Genera credenziali',
                                    options: FFButtonOptions(
                                      width: 160,
                                      height: 40,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 8,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Inserisci l\'username!';
                                      }
                                      return null;
                                    },
                                    controller: controllerUsername,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Username:',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*()<>,./-]).{8,20}$');
                                      if (value == null || value.isEmpty) {
                                        return 'Inserisci la password!';
                                      } else if (!regex.hasMatch(value)) {
                                        return 'Inserisci una password valida!\nAlmeno 8 caratteri\nCarattere maiuscolo\nCarattere minuscolo\nUn numero\nUn carattere speciale';
                                      }
                                      return null;
                                    },
                                    controller: controllerPassword,
                                    autofocus: true,
                                    obscureText: !passwordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Password:',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: const Color(0xFF757575),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 20, 0, 16),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                    .validate() &&
                                                datePicked != null) {
                                              var imageUrl;
                                              if (imagePickedPath != '') {
                                                imageUrl = await ImageUpload()
                                                    .uploadImage(
                                                        imagePickedPath);
                                              }
                                              final patientUID =
                                                  await createNewPatientAccount();
                                              if (patientUID != null) {
                                                final user = Utente(
                                                    userID: patientUID,
                                                    name: controllerNome!.text,
                                                    lastname:
                                                        controllerCognome!.text,
                                                    email: controllerUsername!
                                                        .text,
                                                    type: 'Paziente',
                                                    date: datePicked!,
                                                    profileImgPath:
                                                        imageUrl ?? '');
                                                user.createPatient();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeCaregiverWidget()));
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Inserisci tutti i campi!');
                                            }
                                          },
                                          text: 'Salva',
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle1
                                                    .override(
                                                      fontFamily:
                                                          'IBM Plex Sans',
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
                              ],
                            ),
                          ),
                        ),
                      ],
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
