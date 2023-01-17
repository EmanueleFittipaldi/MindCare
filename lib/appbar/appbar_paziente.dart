import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../controller/auth.dart';
import '../widget_tree.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      actions: const [],
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xFFEBF9FF),
                size: 30,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
              child: Text(
                'MindCare',
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'IBM Plex Sans',
                      color: Colors.white,
                      fontSize: 22,
                    ),
              ),
            ),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.logout,
                color: FlutterFlowTheme.of(context).tertiaryColor,
                size: 30,
              ),
              onPressed: () async {
                Auth().signOut();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WidgetTree()));
              },
            ),
          ],
        ),
        centerTitle: true,
        expandedTitleScale: 1.0,
      ),
      elevation: 2,
    );
  }
}
