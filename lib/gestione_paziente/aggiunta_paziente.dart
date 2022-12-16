import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:mindcare/controller/image_upload.dart';
import 'package:mindcare/model/utente.dart';

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
  TextEditingController? controllerData;

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
    controllerData = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    controllerNome?.dispose();
    controllerCognome?.dispose();
    controllerUsername?.dispose();
    controllerPassword?.dispose();
    controllerData?.dispose();
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
                                      String val = value!.replaceAll(' ', '');
                                      if (value.isEmpty || val.isEmpty) {
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
                                      String val = value!.replaceAll(' ', '');
                                      if (value.isEmpty || val.isEmpty) {
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 10, 0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Inserisci una data di nascita!';
                                            }
                                            return null;
                                          },
                                          controller: controllerData,
                                          autofocus: true,
                                          readOnly: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Data di nascita',
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            onConfirm: (date) {
                                          setState(() {
                                            datePicked = date;
                                            controllerData!.text = datePicked ==
                                                    null
                                                ? 'Data di nascita'
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.parse(
                                                        datePicked.toString()));
                                          });
                                        },
                                            currentTime: getCurrentTimestamp,
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
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
                                    validator: (value) {
                                      String val = value!.replaceAll(' ', '');
                                      if (value.isEmpty || val.isEmpty) {
                                        return 'Inserisci l\'email!';
                                      }
                                      RegExp regex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      if (!regex.hasMatch(value)) {
                                        return 'Inserisci un\'email valida!';
                                      }
                                      return null;
                                    },
                                    controller: controllerUsername,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email:',
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
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 5),
                                  child: TextFormField(
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
                                      0, 15, 0, 10),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      controllerPassword!.text =
                                          generatePassword();
                                    },
                                    text: 'Genera password',
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
                                      borderRadius: 30,
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
                                            /* Quando clicco su Salva viene salvato
                                            il paziente*/
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
                                                  await UserController()
                                                      .createNewPatientAccount(
                                                          controllerUsername!
                                                              .text,
                                                          controllerPassword!
                                                              .text);
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                              borderRadius: 30),
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
