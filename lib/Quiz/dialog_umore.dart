import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../flutter_flow/flutter_flow_theme.dart';
// ignore: duplicate_import
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:panara_dialogs/src/widgets/panara_button.dart';

class DialogUmore extends StatefulWidget {
  final String title;
  final String message;
  const DialogUmore({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  _DialogUmore createState() => _DialogUmore();
}

class _DialogUmore extends State<DialogUmore> {
  final textColor = const Color(0xFF707070);
  int checkEmoticon = 5;
  final buttonTextColor = Colors.white;
  TextEditingController? textController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: MediaQuery.of(context).viewInsets,
                constraints: const BoxConstraints(
                  maxWidth: 340,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.message,
                        style: TextStyle(
                          color: textColor,
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15, 15, 15, 15),
                        child: Container(
                          height: 120,
                          decoration: const BoxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              String val = value!.replaceAll(' ', '');

                              if (value.isEmpty || val.isEmpty) {
                                return 'Inserisci una descrizione!';
                              }
                              return null;
                            },
                            controller: textController,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Descrizione:',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                            maxLines: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => checkEmoticon = 0);
                                  },
                                  child: Image.asset(
                                    'assets/images/angry.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: checkEmoticon == 0 ? true : false,
                                    onChanged: (newValue) async {
                                      setState(() => checkEmoticon = 0);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => checkEmoticon = 1);
                                  },
                                  child: Image.asset(
                                    'assets/images/sad.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: checkEmoticon == 1 ? true : false,
                                    onChanged: (newValue) async {
                                      setState(() => checkEmoticon = 1);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => checkEmoticon = 2);
                                  },
                                  child: Image.asset(
                                    'assets/images/neutral.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: checkEmoticon == 2 ? true : false,
                                    onChanged: (newValue) async {
                                      setState(() => checkEmoticon = 2);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => checkEmoticon = 3);
                                  },
                                  child: Image.asset(
                                    'assets/images/happy.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: checkEmoticon == 3 ? true : false,
                                    onChanged: (newValue) async {
                                      setState(() => checkEmoticon = 3);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => checkEmoticon = 4);
                                  },
                                  child: Image.asset(
                                    'assets/images/excited.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: checkEmoticon == 4 ? true : false,
                                    onChanged: (newValue) async {
                                      setState(() => checkEmoticon = 4);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: PanaraButton(
                          buttonTextColor: Colors.white,
                          text: 'Fatto!',
                          onTap: () {
                            var emoji = ['😡', '🙁', '😐', '🙂', '😍'];
                            if (formKey.currentState!.validate()) {
                              if (checkEmoticon < 5) {
                                var text =
                                    '${textController!.text} ${emoji[checkEmoticon]}';
                                Navigator.of(context).pop(text);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Seleziona una faccina!');
                              }
                            }
                          },
                          bgColor: FlutterFlowTheme.of(context).primaryColor,
                          isOutlined: false,
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
    );
  }
}
