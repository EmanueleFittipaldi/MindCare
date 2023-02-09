import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContattoController {
  //funzione per eliminare un contatto e la sua immagine salvate nello storage
  Future<void> deleteContatto(userID, caregiverID, contattoID, filePath) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('ContattiSOS')
        .doc(contattoID); //riferimento al documento da eliminare
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
}
