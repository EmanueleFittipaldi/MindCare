import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class PasswordDimenticataWidget extends StatefulWidget {
  const PasswordDimenticataWidget({Key? key}) : super(key: key);

  @override
  _PasswordDimenticataWidgetState createState() =>
      _PasswordDimenticataWidgetState();
}

class _PasswordDimenticataWidgetState extends State<PasswordDimenticataWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(title: 'Password dimenticata'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiaryColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 0.99),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            'Inserisci l\'email per recuperare la password.',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'IBM Plex Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 30, 15, 0),
                          child: TextFormField(
                            controller: _controllerEmail,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email:',
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
                            ),
                            style:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 30, 15, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  if (_controllerEmail.text == '') {
                                    PanaraInfoDialog.show(
                                      context,
                                      title: "Accesso",
                                      message: "Inserisci l'email!",
                                      buttonText: "Okay",
                                      onTapDismiss: () {
                                        Navigator.pop(context);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible:
                                          false, // optional parameter (default is true)
                                    );
                                  } else {
                                    var success = await UserController()
                                        .forgottenPassword(
                                            _controllerEmail.text);
                                    if (success) {
                                      // ignore: use_build_context_synchronously
                                      PanaraInfoDialog.show(
                                        context,
                                        title: "Password dimenticata",
                                        message: "Email inviata!",
                                        buttonText: "Okay",
                                        onTapDismiss: () {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.success,
                                        barrierDismissible:
                                            false, // optional parameter (default is true)
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      PanaraInfoDialog.show(
                                        context,
                                        title: "Password dimenticata",
                                        message:
                                            "Ops! Qualcosa è andato storto!",
                                        buttonText: "Okay",
                                        onTapDismiss: () {
                                          Navigator.pop(context);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.error,
                                        barrierDismissible:
                                            false, // optional parameter (default is true)
                                      );
                                    }
                                  }
                                },
                                text: 'Invia email',
                                options: FFButtonOptions(
                                  width: 230,
                                  height: 50,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
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
                      ],
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
