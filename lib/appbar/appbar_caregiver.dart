import 'package:flutter/services.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  const AppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      iconTheme:
          IconThemeData(color: FlutterFlowTheme.of(context).secondaryText),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: FlutterFlowTheme.of(context).bodyText2.override(
              fontFamily: 'IBM Plex Sans',
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
      ),
      actions: const [],
      centerTitle: false,
      elevation: 0,
    );
  }
}
