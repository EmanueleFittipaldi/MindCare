// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:mindcare/autenticazione/password_dimenticata.dart';
import 'package:mindcare/autenticazione/registrazione.dart';
// ignore: unused_import
import 'package:mindcare/widget_tree.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? errorMessage = 'Email o password errata';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      // ignore: unused_local_variable
      String msg = '';
      if (e.toString().contains("Given String is empty or null")) {
        PanaraInfoDialog.show(
          context,
          title: "Accesso",
          message: "Inserire email e password prima di procedere!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false, // optional parameter (default is true)
        );
      } else if (e
          .toString()
          .contains("The email address is badly formatted")) {
        PanaraInfoDialog.show(
          context,
          title: "Accesso",
          message: "Inserire un'email valida prima di procedere!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false, // optional parameter (default is true)
        );
      } else if (e.toString().contains("There is no user record")) {
        PanaraInfoDialog.show(
          context,
          title: "Accesso",
          message: "Email o password errati!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.error,
          barrierDismissible: false, // optional parameter (default is true)
        );
      } else {
        PanaraInfoDialog.show(
          context,
          title: "Accesso",
          message: "Le informazioni inserite non sono corrette!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.error,
          barrierDismissible: false, // optional parameter (default is true)
        );
      }

      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: FlutterFlowTheme.of(context).borderErrorColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiaryColor,
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/images/Logo_MindCare.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'MindCare',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 35,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(44, 0, 44, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: TextFormField(
                                controller: _controllerEmail,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Indirizzo email o username',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF95A1AC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF95A1AC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB9BEBF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB9BEBF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 12, 0, 0),
                              child: TextFormField(
                                controller: _controllerPassword,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF95A1AC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF95A1AC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB9BEBF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB9BEBF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .borderErrorColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF95A1AC),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              const PasswordDimenticataWidget()));
                                    },
                                    text: 'Password dimenticata?',
                                    options: FFButtonOptions(
                                      width: 200,
                                      height: 40,
                                      color: const Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      elevation: 0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FFButtonWidget(
                                    onPressed: signInWithEmailAndPassword,
                                    text: 'Accedi',
                                    options: FFButtonOptions(
                                      width: 230,
                                      height: 50,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      elevation: 3,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Non hai un account?',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegistrazioneWidget()));
                                      },
                                      text: 'Crea account',
                                      options: FFButtonOptions(
                                          width: 230,
                                          height: 50,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .subtitle2
                                              .override(
                                                fontFamily: 'Lexend Deca',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          elevation: 0,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
