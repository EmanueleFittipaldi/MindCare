import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/init_homepage.dart';
import 'package:mindcare/paziente/home_paziente.dart';
import 'package:mindcare/model/utente.dart';

import 'controller/auth.dart';
import '../autenticazione/login.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  Utente? userLogged;
  String? caregiverUID;
  Future<String> checkUser() async {
    print("Controllo l'user");
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .get(); //ottenimento di tutti i documenti nella collezione user
    bool isLoggedWithBiometrics;
    for (var i = 0; i < snapshot.docs.length; i++) {
      var caregiverMap = snapshot.docs[i].data() as Map<String, dynamic>?;
      if (caregiverMap!['userID'] == Auth().currentUser!.uid) {
        userLogged = Utente(
            userID: caregiverMap['userID'],
            name: caregiverMap['name'],
            lastname: caregiverMap['lastname'],
            email: caregiverMap['email'],
            type: caregiverMap['type'],
            date: (caregiverMap['dateOfBirth'] as Timestamp).toDate(),
            profileImgPath: caregiverMap['profileImagePath'],
            checkBiometric: caregiverMap['checkBiometric']);
        //verifico se il campo userID è uguale a quello loggato
        print("caregiverMap[checkBiometric] " + caregiverMap['checkBiometric'].toString());
        if(caregiverMap['checkBiometric'] == true){
          isLoggedWithBiometrics = await checkBiometrics();
          if(!isLoggedWithBiometrics) {
                Fluttertoast.showToast(msg: "Identità non riconosciuta");
                Auth().signOut();
                return '';
              }
        }
        return caregiverMap['type']; //allora è il caregiver
      } else {
        print('Sto in paziente');
        //altrimenti ciclo sui pazienti del caregiver
        QuerySnapshot snapshotPat = await FirebaseFirestore.instance
            .collection('user')
            .doc(caregiverMap['userID'])
            .collection('Pazienti')
            .get(); //ottengo la collezione del caregiver dato dall'UID salvato nel campo
        for (var j = 0; j < snapshotPat.docs.length; j++) {
          var patientMap = snapshotPat.docs[j].data() as Map<String, dynamic>?;
          if (patientMap!['userID'] == Auth().currentUser!.uid) {
            caregiverUID = caregiverMap['userID'];
            userLogged = Utente(
                userID: patientMap['userID'],
                name: patientMap['name'],
                lastname: patientMap['lastname'],
                email: patientMap['email'],
                type: patientMap['type'],
                date: (patientMap['dateOfBirth'] as Timestamp).toDate(),
                profileImgPath: patientMap['profileImagePath'],
                checkBiometric: patientMap['checkBiometric']);

            //se l'userID nel documento dei pazienti è uguale a quello loggato
            if(patientMap['checkBiometric'] == true){
              isLoggedWithBiometrics = await checkBiometrics();
              if(!isLoggedWithBiometrics) {
                Fluttertoast.showToast(msg: "Identità non riconosciuta");
                Auth().signOut();
                return '';
              }
            }
            return patientMap['type']; //è il paziente e ritorna il tipo
          }
        }
      }
    }
    return '';
  }

  Future <bool> checkBiometrics() async {
      final LocalAuthentication _localAuthentication = LocalAuthentication();
      bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
      bool isAuthenticated = false;
      final List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
      if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Per favore procedi con l\'autentificazione prima di utilizzare l\'applicazione',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            biometricOnly: true,
            stickyAuth: true));
      } on PlatformException catch (e) {
        print("stampo l'errore " +  e.toString());
      }
    }
    print("isAuthenticated#2 " + isAuthenticated.toString());
     return isAuthenticated;
  }

  Future<void> deleteUserDB(String type) async {
    var user = FirebaseFirestore.instance.collection('user');
    if (type == 'Caregiver') {
      var docSnapshot = user.doc(Auth().currentUser?.uid);
      await FirebaseFirestore.instance
          .runTransaction((Transaction deleteTransaction) async {
        deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
      });
      return;
    } else if (type == 'Paziente') {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .get(); //ottenimento di tutti i documenti nella collezione user

      for (var i = 0; i < snapshot.docs.length; i++) {
        var caregiverMap = snapshot.docs[i].data() as Map<String, dynamic>?;
        QuerySnapshot snapshotPat = await FirebaseFirestore.instance
            .collection('user')
            .doc(caregiverMap!['userID'])
            .collection('Pazienti')
            .get(); //ottengo la collezione del caregiver dato dall'UID salvato nel campo
        for (var j = 0; j < snapshotPat.docs.length; j++) {
          var patientMap = snapshotPat.docs[j].data() as Map<String, dynamic>?;
          if (patientMap!['userID'] == Auth().currentUser!.uid) {
            //se l'userID nel documento dei pazienti è uguale a quello loggato
            var docSnapshot = FirebaseFirestore.instance
                .collection('user')
                .doc(caregiverMap['userID'])
                .collection('Pazienti')
                .doc(Auth().currentUser?.uid);
            await FirebaseFirestore.instance
                .runTransaction((Transaction deleteTransaction) async {
              deleteTransaction
                  .delete(docSnapshot); //transazione per l'eliminazione
            });
            return;
          }
        }
      }
    }
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
                      return InitHomepage(user: userLogged!, carUID: null);
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inHours > 24) {
                        Fluttertoast.showToast(
                            msg: 'Verifica scaduta, account cancellato!');
                        deleteUserDB(type!);
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
                      return InitHomepage(
                          user: userLogged!, carUID: caregiverUID!);
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inHours > 24) {
                        Fluttertoast.showToast(
                            msg: 'Verifica scaduta, account cancellato!');
                        deleteUserDB(type!);
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
                  print('sto aspettando i dati');
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
