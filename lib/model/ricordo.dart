import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';

class Ricordo {
  final String titolo;
  final int annoRicordo;
  final String descrizione;
  final String filePath;
  final String ricordoID;
  final String tipoRicordo;
  final List tags;
  Ricordo({
    required this.titolo,
    required this.annoRicordo,
    required this.descrizione,
    required this.filePath,
    required this.ricordoID,
    required this.tipoRicordo,
    required this.tags,
  });

  final docUser = FirebaseFirestore.instance.collection('user').doc();

  Map<String, dynamic> toJson() => {
        'titolo': titolo,
        'annoRicordo': annoRicordo,
        'descrizione': descrizione,
        'filePath': filePath,
        'ricordoID': ricordoID,
        'tipoRicordo': tipoRicordo,
        'tags': tags
      };

  Future<void> createMemory(String user) async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(user)
        .collection('Ricordi')
        .doc(ricordoID);

    await docUser.set(json);
  }
}
