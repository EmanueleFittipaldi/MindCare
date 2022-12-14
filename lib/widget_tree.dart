import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/paziente/home_paziente.dart';



import 'auth.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  Future<String> checkUser() async {
    print("Controllo l'user");
    bool isLoggedWithBiometrics = await checkBiometrics();
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

  Future <bool> checkBiometrics() async {
      final LocalAuthentication _localAuthentication = LocalAuthentication();
      bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
      bool isAuthenticated = false;
      final List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
      if (availableBiometrics.isEmpty)
        print("la lista di biometria è vuota");
      else
        print("la lista è piena" + availableBiometrics.toString());
      if (availableBiometrics.contains(BiometricType.weak))
        print("face disponibile [weak]");
        else
        print("non trovo face");
      if (availableBiometrics.contains(BiometricType.strong))
        print("fingerprint disponibile [strong]");
      else
        print("non trovo fingerprint");
      print("isAuthenticated " + isAuthenticated.toString());
      print("cancheckBiometrics " + canCheckBiometrics.toString());
      if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Per favore procedi con l\'autentificazione prima di utilizzare l\'applicazione',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            biometricOnly: true,
            stickyAuth: true));
        print("ho finito isAuthenticated");
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
                      return const HomeCaregiverWidget();
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inMicroseconds > 2) {
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
                      return const HomePazienteWidget();
                    } else {
                      DateTime? date =
                          Auth().currentUser!.metadata.creationTime;
                      DateTime dateNow = DateTime.now();
                      if (dateNow.difference(date!).inMicroseconds > 2) {
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
