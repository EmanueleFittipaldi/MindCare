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
  Future<String> checkUser() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .get(); //ottenimento di tutti i documenti nella collezione user

    for (var i = 0; i < snapshot.docs.length; i++) {
      var caregiverMap = snapshot.docs[i].data() as Map<String, dynamic>?;
      if (caregiverMap!['userID'] == Auth().currentUser!.uid) {
        //verifico se il campo userID è uguale a quello loggato
        return caregiverMap['type']; //allora è il caregiver
      } else {
        //altrimenti ciclo sui pazienti del caregiver
        QuerySnapshot snapshotPat = await FirebaseFirestore.instance
            .collection('user')
            .doc(caregiverMap['userID'])
            .collection('Pazienti')
            .get(); //ottengo la collezione del caregiver dato dall'UID salvato nel campo
        for (var j = 0; j < snapshotPat.docs.length; j++) {
          var patientMap = snapshotPat.docs[j].data() as Map<String, dynamic>?;
          if (patientMap!['userID'] == Auth().currentUser!.uid) {
            //se l'userID nel documento dei pazienti è uguale a quello loggato
            return patientMap['type']; //è il paziente e ritorna il tipo
          }
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
              future: checkUser(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  var type = snapshot.data;
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
