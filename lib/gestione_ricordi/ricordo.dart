import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/auth.dart';

class Ricordo {
  final String titolo;
  final int annoRicordo;
  final String descrizione;
  final String filePath;

  Ricordo({
    required this.titolo,
    required this.annoRicordo,
    required this.descrizione,
    required this.filePath,
  });

  final docUser = FirebaseFirestore.instance.collection('user').doc();

  Map<String, dynamic> toJson() => {
        'titolo': titolo,
        'annoRicordo': annoRicordo,
        'descrizione': descrizione,
        'filePath': filePath
      };

  Future<void> createMemory(String user) async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(user)
        .collection('Ricordi')
        .doc();
    await docUser.set(json);
  }
}
