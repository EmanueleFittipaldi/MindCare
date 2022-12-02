import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/auth.dart';
import 'package:mindcare/login.dart';
import 'package:mindcare/caregiver/opzioni.dart';
import 'package:mindcare/widget_tree.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../utente.dart';

class AppbarcaregiverWidget extends StatelessWidget {
  const AppbarcaregiverWidget({super.key});

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
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      actions: [],
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.settings,
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    size: 30,
                  ),
                  onPressed: () async {
                    await datiCaregiver();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OpzioniWidget(
                           user: Utente(
                                  userID:
                                        data!['userID'],
                                        name: data!['name'],
                                        lastname: data!['lastname'],
                                        email: data!['email'],
                                        type: data!['type'],
                                        date: (data!['dateOfBirth'] as Timestamp).toDate(),
                                        profileImgPath: data!['profileImagePath']))));
                  },
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
          ],
        ),
        centerTitle: true,
        expandedTitleScale: 1.0,
      ),
      elevation: 2,
    );
  }
}
