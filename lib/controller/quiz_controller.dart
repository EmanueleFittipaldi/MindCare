import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/controller/image_upload.dart';
import 'package:mindcare/model/quesito.dart';
import 'package:mindcare/model/utente.dart';

class QuizController {
  /*
  Funzione che permette di reperire tutti i quesiti di un determinato paziente
  specificando una categoria ed una tipologia. 
  */
  getQuesiti(String categoria, String tipologia, String userID,
      String caregiverID) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('Quesiti');

    // ignore: non_constant_identifier_names
    QuerySnapshot QueryCategoria = await collectionRef
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

/*Questa funzione preleva tutti i quesiti per una specifica categoria e tipologia.
Se sono più di 10, allora ne sceglie in maniera casuale esattamente 10 quesiti,
altrimenti restituisce tutti i quesiti prelevati. */
  getRandomQuesiti(String categoria, String tipologia, String userID,
      String caregiverID) async {
    List<dynamic> quesiti =
        await getQuesiti(categoria, tipologia, userID, caregiverID);
    if (quesiti.length > 10) {
      Set quesitiEstratti = <int>{};
      List<dynamic> quesitiScelti = [];

      final random = Random();
      int numeroQuesito = 0;
      while (quesitiScelti.length < 10) {
        numeroQuesito = random.nextInt(quesiti.length);
        if (!quesitiEstratti.contains(numeroQuesito)) {
          quesitiEstratti.add(numeroQuesito);
          quesitiScelti.add(quesiti[numeroQuesito]);
        }
      }
      return quesitiScelti;
    } else {
      return quesiti;
    }
  }

  /*Questa funzione elimina l'immagine che c'era prima e carica quella
passata come parametro */
  Future<String> updateImage(String imagDomanda, String imagPrecedente) async {
    ImageUpload().deleteFile(imagPrecedente);
    return await ImageUpload().uploadImage(imagDomanda);
  }

/*Funzione che permette di modificare un questio del tipo  */
  updateQuesitoImgNome(
      String userID,
      Quesito? quesito,
      String? categoria,
      String? tipologia,
      String imagOp1,
      String imagOp2,
      String imagOp3,
      String imagOp4,
      String? domanda,
      String risposta,
      String? tempo,
      int? numeroTentativi) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(userID)
        .collection('Quesiti')
        .doc(quesito!.quesitoID)
        .update({
      'quesitoID': quesito.quesitoID,
      'opzione1': imagOp1 != ''
          ? await updateImage(imagOp1, quesito.opzione1!)
          : quesito.opzione1,
      'opzione2': imagOp2 != ''
          ? await updateImage(imagOp2, quesito.opzione2!)
          : quesito.opzione2,
      'opzione3': imagOp3 != ''
          ? await updateImage(imagOp3, quesito.opzione3!)
          : quesito.opzione3,
      'opzione4': imagOp4 != ''
          ? await updateImage(imagOp4, quesito.opzione4!)
          : quesito.opzione4,
      'domanda': domanda,
      'domandaImmagine': '',
      'risposta': risposta,
      'categoria': categoria,
      'tipologia': tipologia,
      'tempoRisposta': int.parse(tempo!),
      'numeroTentativi': numeroTentativi
    });
  }

  updateQuesitoNomeImg(
      String userID,
      Quesito? quesito,
      String? op1,
      String? op2,
      String? op3,
      String? op4,
      String? domanda,
      String imgDomanda,
      String? risposta,
      String? categoria,
      String? tipologia,
      String? tempoRisposta,
      int? numeroTentativi) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(userID)
        .collection('Quesiti')
        .doc(quesito!.quesitoID)
        .update({
      'quesitoID': quesito.quesitoID,
      'opzione1': op1,
      'opzione2': op2,
      'opzione3': op3,
      'opzione4': op4,
      'domanda': domanda,
      /*Se imagDomanda non è vuota allora significa che ho
                            cliccato sull'immagine e ne ho scelto una nuova. Altrimenti
                            Significa che devo riassegnare l'immagine che già c'era, e questa
                            la posso reperire dall'oggetto Quesito che ho passato in precedenza
                            a questo widget. */
      'domandaImmagine': imgDomanda != ''
          ? await updateImage(imgDomanda, quesito.domandaImmagine!)
          : quesito.domandaImmagine,
      'risposta': risposta,
      'categoria': categoria,
      'tipologia': tipologia,
      'tempoRisposta': int.parse(tempoRisposta!),
      'numeroTentativi': numeroTentativi
    });
  }

  creazioneQuesitoNomeImg(
      Utente user,
      String? op1,
      String? op2,
      String? op3,
      String? op4,
      String? domanda,
      String imageUrlDomanda,
      String? risposta,
      String? categoria,
      String? tipologia,
      String? tempoRisposta,
      int? numeroTentativi) {
    final quesitoIDGenerato = Quesito.quesitoIdGenerator(28);
    final quesito = Quesito(
        quesitoID: quesitoIDGenerato,
        opzione1: op1,
        opzione2: op2,
        opzione3: op3,
        opzione4: op4,
        domanda: domanda,
        domandaImmagine: imageUrlDomanda, //Titolo della domanda
        risposta: risposta, //Immagine 1, Immagine 2,...
        categoria: categoria,
        tipologia: tipologia,
        tempoRisposta: int.parse(tempoRisposta!),
        numeroTentativi: numeroTentativi);
    quesito.createNewQuestion(user, quesitoIDGenerato);
  }

  /*Funzione che si occupa della creazione di un questio */
  createQuesitoImgNome(
      Utente user,
      String imageUrlOp1,
      String imageUrlOp2,
      String imageUrlOp3,
      String imageUrlOp4,
      String? domanda,
      String? risposta,
      String? categoria,
      String? tipologia,
      String? tempo,
      int? numeroTentativi) {
    //Creazione del quesito
    final quesitoIDGenerato = Quesito.quesitoIdGenerator(28);
    final quesito = Quesito(
        quesitoID: quesitoIDGenerato,
        opzione1: imageUrlOp1,
        opzione2: imageUrlOp2,
        opzione3: imageUrlOp3,
        opzione4: imageUrlOp4,
        domanda: domanda, //Titolo della domanda
        domandaImmagine: '',
        risposta: risposta, //Immagine 1, Immagine 2,...
        categoria: categoria,
        tipologia: tipologia,
        tempoRisposta: int.parse(tempo!),
        numeroTentativi: numeroTentativi);
    quesito.createNewQuestion(user, quesitoIDGenerato);
  }

  getQuesitiByID(String userID, String caregiverID, quesitiID) async {
    var result = [];
    for (var id in quesitiID) {
      DocumentSnapshot collectionRef = await FirebaseFirestore.instance
          .collection('user')
          .doc(caregiverID)
          .collection('Pazienti')
          .doc(userID)
          .collection('Quesiti')
          .doc(id)
          .get();
      var data = collectionRef.get('risposta');
      var nOp = data.replaceAll(RegExp(r'[^0-9]'), '');
      result.add(Quesito(
          quesitoID: collectionRef.get('quesitoID'),
          opzione1: collectionRef.get('opzione1'),
          opzione2: collectionRef.get('opzione2'),
          opzione3: collectionRef.get('opzione3'),
          opzione4: collectionRef.get('opzione4'),
          domanda: collectionRef.get('domanda'),
          domandaImmagine: collectionRef.get('domandaImmagine'),
          // ignore: prefer_interpolation_to_compose_strings
          risposta: collectionRef.get('opzione' + nOp),
          categoria: collectionRef.get('categoria'),
          tipologia: collectionRef.get('tipologia'),
          tempoRisposta: collectionRef.get('tempoRisposta'),
          numeroTentativi: collectionRef.get('numeroTentativi')));
    }
    return result;
  }

  Future<void> deleteQuiz(caregiverUID, userUID, quesito) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(caregiverUID)
        .collection('Pazienti')
        .doc(userUID)
        .collection('Quesiti')
        .doc(quesito['quesitoID']);

    if (quesito['tipologia'] == 'Associa l\'immagine al nome') {
      await FirebaseStorage.instance.refFromURL(quesito['opzione1']).delete();
      await FirebaseStorage.instance.refFromURL(quesito['opzione2']).delete();
      await FirebaseStorage.instance.refFromURL(quesito['opzione3']).delete();
      await FirebaseStorage.instance
          .refFromURL(quesito['opzione4'])
          .delete(); //eliminazione immagine

    } else if (quesito['tipologia'] == 'Associa il nome all\'immagine') {
      await FirebaseStorage.instance
          .refFromURL(quesito['domandaImmagine'])
          .delete();
    } //riferimento al documento da eliminare
    await FirebaseFirestore.instance
        .runTransaction((Transaction deleteTransaction) async {
      deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
    });
  }
}
