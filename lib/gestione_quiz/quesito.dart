import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth.dart';
import '../utente.dart';

class Quesito {
  final String quesitoID;
  final String opzione1;
  final String opzione2;
  final String opzione3;
  final String opzione4;
  final String? domanda;
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
      risposta: json['risposta'],
      categoria: json['categoria'],
      tipologia: json['tipologia']);

  Future<void> createNewQuestion(Utente user) async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user') //collezione principale di tutti gli utenti
        .doc(Auth().currentUser?.uid) //prendo il caregiver corrente
        .collection('Pazienti') //prendo la collezione dei suoi pazienti
        .doc(user.userID) //prendo lo user che mi interessa
        .collection('Quesiti') //prendo la collezione dei quesiti
        .doc();
    await docUser.set(json);
  }
}
