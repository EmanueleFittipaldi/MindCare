import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/paziente/home_paziente.dart';

import 'auth.dart';
import 'home_page.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {


  @override
  Widget build(BuildContext context) {

    var flag = false;
    var docSnaphot;

    Future<bool> isCaregiver() async {
    var collection = FirebaseFirestore.instance.collection("user");
    docSnaphot = await collection.doc(Auth().currentUser?.uid).get();
    return flag;
    }

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: isCaregiver(),
            builder: (context, snapshot) {
              if (snapshot.hasData){
                if(docSnaphot.exists){
                  Map<String, dynamic>? data = docSnaphot.data();
                  if(data?["type"] == "Caregiver"){
                    flag = true;
                  }else {
                    flag = false;
                  }
                } 
                if (flag) {
                  return const HomeCaregiverWidget();
                } else {
                  return const HomePazienteWidget();
                }
              }
              else {
                return const LoginWidget();
              }
            });
        } else {
          print("sono dentro widgetTree - Snapshot NULL");
          return const LoginWidget();
        }
      },
    );
  }
}

