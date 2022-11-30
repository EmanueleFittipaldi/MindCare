import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/paziente/home_paziente.dart';


import 'auth.dart';
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
                if (snapshot.hasData) {
                  var type = '';
                  if (docSnaphot != null) {
                    Map<String, dynamic>? data = docSnaphot.data();

                    if (data?["type"] == "Caregiver") {
                      type = 'Caregiver';
                    } else {
                      type = 'Paziente';
                    }
                  }
                  if (type == 'Caregiver') {
                    if (Auth().currentUser!.emailVerified) {
                      return const HomeCaregiverWidget();
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inHours > 24) {
                        Fluttertoast.showToast(
                            msg: 'Verifica scaduta, account cancellato!');

                        Auth().currentUser!.delete();
                      } else {
                        Fluttertoast.showToast(msg: 'Verifica email!');
                        Auth().signOut();
                      }
                    }
                    return const LoginWidget();
                  } else if (type == 'Paziente') {
                    // DA NON ELIMINARE -> server per verificare che il paziente ha verifica l'email, ma da limare alcuni dettagli
                    if (Auth().currentUser!.emailVerified) {
                      return const HomePazienteWidget();
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inHours > 24) {
                        Fluttertoast.showToast(
                            msg: 'Verifica scaduta, account cancellato!');
                        Auth().signOut();
                        Auth().currentUser!.delete();
                      } else {
                        Fluttertoast.showToast(msg: 'Verifica email!');
                        Auth().signOut();
                      }

                      return const LoginWidget();
                    }
                  } else {
                    return const LoginWidget();
                  }
                } else {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
              });
        } else {
          return const LoginWidget();
        }
      },
    );
  }
}
