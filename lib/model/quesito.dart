import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/auth.dart';
import 'utente.dart';

class Quesito {
  final String quesitoID;
  final String? opzione1;
  final String? opzione2;
  final String? opzione3;
  final String? opzione4;
  final String? domanda;
  //è stato necessario introdurre anche questo
  //campo in quanto per un quesito del tipo associa immagine al nome ci sono 6
  //campi, mentre per un quesito del tipo associa nome ad immagine ci sono 7 campi.
  //Questo faceva si che non riuscivo a portarmi "Testo domanda" avanti.
  final String? domandaImmagine;
  final String? risposta;
  final String? categoria;
  final String? tipologia;
  Quesito(
      {required this.quesitoID,
      required this.opzione1,
      required this.opzione2,
      required this.opzione3,
      required this.opzione4,
      required this.domanda,
      required this.domandaImmagine,
      required this.risposta,
      required this.categoria,
      required this.tipologia});

  Map<String, dynamic> toJson() => {
        'quesitoID': quesitoID,
        'opzione1': opzione1,
        'opzione2': opzione2,
        'opzione3': opzione3,
        'opzione4': opzione4,
        'domanda': domanda,
        'domandaImmagine': domandaImmagine,
        'risposta': risposta,
        'categoria': categoria,
        'tipologia': tipologia
      };

  static Quesito fromJson(Map<String, dynamic> json) => Quesito(
      quesitoID: json['id'],
      opzione1: json['opzione1'],
      opzione2: json['opzione2'],
      opzione3: json['opzione3'],
      opzione4: json['opzione4'],
      domanda: json['domanda'],
      domandaImmagine: json['domandaImmagine'],
      risposta: json['risposta'],
      categoria: json['categoria'],
      tipologia: json['tipologia']);

  Future<void> createNewQuestion(Utente user, String quesitoIDGenerato) async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user') //collezione principale di tutti gli utenti
        .doc(Auth().currentUser?.uid) //prendo il caregiver corrente
        .collection('Pazienti') //prendo la collezione dei suoi pazienti
        .doc(user.userID) //prendo lo user che mi interessa
        .collection('Quesiti') //prendo la collezione dei quesiti
        .doc(quesitoIDGenerato);
    await docUser.set(json);
  }

  /*Questa funzione mi serve per generare un ID per il quesito. Se per 
  l'utente esso veniva creato in automatico dal processo di autenticazione
  per i quesiti ho bisogno di crearlo io manualmente.
  
  Rendere il metodo static lo rende accessibile dall'esterno senza dover 
  creare una istanza di questa classe per poter usare questo metodo.*/
  static String quesitoIdGenerator(int len) {
    var r = Random();
    const chars = '1234567890aAbBcCdDeEfFgGhHiIlLmMnNoOpPqQrRsStTuUvVzZ';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
}
