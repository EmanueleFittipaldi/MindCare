import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final Map<String, bool> mappaRisposte;
  final int tempoImpiegato;
  final DateTime dataInizio;
  final int risposteCorrette;
  final int risposteErrate;
  final double precisione;
  final String reportID;
  final String tipologia;
  final String categoria;
  int umore;
  Report(
      {required this.mappaRisposte,
      required this.tempoImpiegato,
      required this.dataInizio,
      required this.risposteCorrette,
      required this.risposteErrate,
      required this.precisione,
      required this.reportID,
      required this.tipologia,
      required this.categoria,
      required this.umore});

  Map<String, dynamic> toJson() => {
        'mappaRisposte': mappaRisposte,
        'tempoImpiegato': tempoImpiegato,
        'dataInizio': dataInizio,
        'risposteCorrette': risposteCorrette,
        'risposteErrate': risposteErrate,
        'precisione': precisione,
        'reportID': reportID,
        'tipologia': tipologia,
        'categoria': categoria,
        'umore': umore
      };

  static Report fromJson(Map<String, dynamic> json) => Report(
      mappaRisposte: json['mappaRisposte'],
      tempoImpiegato: json['tempoImpiegato'],
      dataInizio: json['dataInizio'],
      risposteCorrette: json['risposteCorrette'],
      risposteErrate: json['risposteErrate'],
      precisione: json['precisione'],
      reportID: json['reportID'],
      tipologia: json['tipologia'],
      categoria: json['categoria'],
      umore: json['umore']);

  Future<void> createReport(
      String caregiverID, String user, String reportIDGenerato) async {
    final json = toJson();
    final docReport = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(user)
        .collection('Report')
        .doc(reportIDGenerato);
    await docReport.set(json);
  }

  static String reportIDGenerator(int len) {
    var r = Random();
    const chars = '1234567890aAbBcCdDeEfFgGhHiIlLmMnNoOpPqQrRsStTuUvVzZ';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
}
