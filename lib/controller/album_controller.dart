import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AlbumController {
  //funzione per eliminare un paziente e la sua immagine salvate nello storage
  Future<void> deleteMemory(userID, caregiverID, memoryID, filePath) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('Ricordi')
        .doc(memoryID); //riferimento al documento da eliminare
    await FirebaseFirestore.instance
        .runTransaction((Transaction deleteTransaction) async {
      deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
    });
    if (filePath != '') {
      await FirebaseStorage.instance
          .refFromURL(filePath)
          .delete(); //eliminazione immagine
    }
  }

  Future<bool> checkMemory(caregiverID, patientID) async {
    var fIstance = FirebaseFirestore.instance.collection('user');
    var docSnapshot = await fIstance
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(patientID)
        .collection('Ricordi')
        .get();

    if (docSnapshot.docs.isNotEmpty) {
      return true;
    }
    return false;
  }
}
