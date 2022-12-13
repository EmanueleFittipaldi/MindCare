import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String description;
  final String textOptionDelete;
  final String textOptionConfirm;

  const ConfirmDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.textOptionDelete,
      required this.textOptionConfirm})
      : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      width: 500,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, -1),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
              child: Text(
                widget.title,
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 26,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
              child: Text(
                widget.description,
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 18,
                    ),
              ),
            ),
            Expanded(
                child: Align(
                    alignment: AlignmentDirectional(1, 1),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 15, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () => Navigator.of(context).pop(false),
                              text: widget.textOptionDelete,
                              options: FFButtonOptions(
                                width: 80,
                                height: 35,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
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
                                5, 0, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () => Navigator.of(context).pop(true),
                              text: widget.textOptionConfirm,
                              options: FFButtonOptions(
                                width: 80,
                                height: 35,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
