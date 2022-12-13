import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/report.dart';

class QuizController {
  /*
  Funzione che permette di reperire tutti i quesiti di un determinato paziente
  specificando una categoria ed una tipologia. 
  */
  getQuesiti(String categoria, String tipologia, String userID,
      String caregiverID) async {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('Quesiti');

    QuerySnapshot QueryCategoria = await _collectionRef
        .where('tipologia', isEqualTo: tipologia)
        .where('categoria', isEqualTo: categoria)
        .get();

    /*
    Quello che viene ritornato è una lista di documenti, dove ogni documento
    è una domanda della categoria e tipologia selezionata.
    */
    var result = [];
    for (var v in QueryCategoria.docs) {
      (result.add(v.data()));
    }
    return result;
  }
}
