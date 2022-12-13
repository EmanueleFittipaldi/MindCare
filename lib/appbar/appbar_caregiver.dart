import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';
import '../autenticazione/login.dart';
import 'package:mindcare/caregiver/opzioni.dart';
import 'package:mindcare/widget_tree.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../model/utente.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  const AppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var docSnaphot;
    Map<String, dynamic>? data;

    Future<void> datiCaregiver() async {
      var collection = FirebaseFirestore.instance.collection("user");
      docSnaphot = await collection.doc(Auth().currentUser?.uid).get();
      data = docSnaphot.data();
    }

    return AppBar(
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
      actions: [],
      centerTitle: false,
      elevation: 0,
    );
  }
}
