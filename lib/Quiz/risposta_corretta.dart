import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class CustomDialogCorretta extends StatefulWidget {
  const CustomDialogCorretta({Key? key}) : super(key: key);

  @override
  _CustomDialogCorrettaState createState() => _CustomDialogCorrettaState();
}

class _CustomDialogCorrettaState extends State<CustomDialogCorretta> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      width: 500,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.05, -0.3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Risposta corretta!',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'IBM Plex Sans',
                      color: Colors.black,
                      fontSize: 30,
                    ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Image.asset(
                  'assets/images/smart-guy-getting-award-winner-standing-pedestal-holding-golden-cup-cartoon-illustration_74855-14511.jpg.webp',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Continua',
                  options: FFButtonOptions(
                    width: 140,
                    height: 60,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
