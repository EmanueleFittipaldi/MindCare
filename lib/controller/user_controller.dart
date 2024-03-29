import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/album_controller.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/controller/quiz_controller.dart';
import 'package:mindcare/controller/sos_controller.dart';

class UserController {
  Future<String?> getCaregiverID(patientID) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .get(); //ottenimento di tutti i documenti nella collezione user

    for (var i = 0; i < snapshot.docs.length; i++) {
      var caregiverMap = snapshot.docs[i].data() as Map<String, dynamic>?;
      //ciclo sui pazienti del caregiver
      QuerySnapshot snapshotPat = await FirebaseFirestore.instance
          .collection('user')
          .doc(caregiverMap!['userID'])
          .collection('Pazienti')
          .get(); //ottengo la collezione del caregiver dato dall'UID salvato nel campo
      for (var j = 0; j < snapshotPat.docs.length; j++) {
        var patientMap = snapshotPat.docs[j].data() as Map<String, dynamic>?;
        if (patientMap!['userID'] == patientID) {
          //se l'userID nel documento dei pazienti è uguale a quello loggato
          //creazione di UTENTE inserendo i dati

          return caregiverMap['userID'];
        }
      }
    }
    return null;
  }

  Future<bool> forgottenPassword(email) async {
    try {
      await Auth().forgottenPassword(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<bool> modificaDati(name, lastname, dateOfBirth, email, type,
      userLoggedID, caregiverUID, pathImage) async {
    DateTime convertedDateTime = DateTime.parse(dateOfBirth);
    Timestamp convertedDateTimeStamp = Timestamp.fromDate(convertedDateTime);
    if (type == 'Paziente') {
      var collection = FirebaseFirestore.instance.collection("user");
      collection
          .doc(caregiverUID)
          .collection('Pazienti')
          .doc(userLoggedID)
          .update({
        'name': name,
        'lastname': lastname,
        'dateOfBirth': convertedDateTimeStamp,
        'email': email,
        'profileImagePath': pathImage,
      });
      return true;
    } else if (type == 'Caregiver') {
      var collection = FirebaseFirestore.instance.collection("user");
      try {
        collection.doc(userLoggedID).update({
          'name': name,
          'lastname': lastname,
          'dateOfBirth': convertedDateTimeStamp,
          'email': email,
          'profileImagePath': pathImage,
        });
        return true;
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        return false;
      }
    }
    return false;
  }

  Future<String?> createNewPatientAccount(email, password) async {
    try {
      return await Auth()
          .createNewPatientAccount(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Problema con la creazione dell'account!");
    }
    return null;
  }

  Future<void> createNewAccount(email, password) async {
    try {
      await Auth().createNewAccount(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "qualcosa è andato storto");
    }
  }

  Future<String> deleteAccount(
      String caregiveruid, String useruid, String type, String imgPath) async {
    var user = FirebaseFirestore.instance.collection('user');
    if (type == 'Caregiver') {
      var docPatients =
          await user.doc(caregiveruid).collection('Pazienti').get();

      if (docPatients.docs.isNotEmpty) {
        return 'error with data';
      }
      var docSnapshot =
          user.doc(caregiveruid); //riferimento al documento da eliminare
      await FirebaseFirestore.instance
          .runTransaction((Transaction deleteTransaction) async {
        deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
      });
      if (imgPath != '') {
        await FirebaseStorage.instance
            .refFromURL(imgPath)
            .delete(); //eliminazione immagine
      }
    } else if (type == 'Paziente') {
      var docSnapshot =
          user.doc(caregiveruid).collection('Pazienti').doc(useruid);
      var quesiti = await docSnapshot.collection('Quesiti').get();
      for (var item in quesiti.docs) {
        QuizController().deleteQuiz(caregiveruid, useruid, item);
      }
      var ricordi = await docSnapshot.collection('Ricordi').get();
      for (var item in ricordi.docs) {
        AlbumController().deleteMemory(
            useruid, caregiveruid, item['ricordoID'], item['filePath']);
      }
      var contatti = await docSnapshot.collection('ContattiSOS').get();
      for (var item in contatti.docs) {
        ContattoController().deleteContatto(useruid, caregiveruid,
            item['contattoID'], item['profileImagePath']);
      }
      //riferimento al documento da eliminare
      await FirebaseFirestore.instance
          .runTransaction((Transaction deleteTransaction) async {
        deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
      });
      if (imgPath != '') {
        await FirebaseStorage.instance
            .refFromURL(imgPath)
            .delete(); //eliminazione immagine
      }
    }
    try {
      await Auth().currentUser?.delete();
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<bool> useBiometric(
      type, userLoggedID, caregiverUID, newBiometric) async {
    if (type == 'Paziente') {
      var collection = FirebaseFirestore.instance.collection("user");
      collection
          .doc(caregiverUID)
          .collection('Pazienti')
          .doc(userLoggedID)
          .update({
        'checkBiometric': newBiometric,
      });
      return true;
    } else if (type == 'Caregiver') {
      var collection = FirebaseFirestore.instance.collection("user");
      try {
        collection.doc(userLoggedID).update({
          'checkBiometric': newBiometric,
        });
        return true;
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        return false;
      }
    }
    return false;
  }
}
