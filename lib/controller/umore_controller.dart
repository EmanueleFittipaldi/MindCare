import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/umore.dart';

class UmoreController {
  Future<void> createUmore(
    String caregiverID,
    String user,
    String text,
  ) async {
    DateTime data = DateTime.now();
    var results =
        Sentiment().analysis(text, languageCode: LanguageCode.italian);
    var umoreID = umoreIDGenerator(28);
    Umore umore = Umore(
        text: text,
        score: results['score'],
        comparative: results['comparative'],
        data: data,
        umoreID: umoreID);
    final json = umore.toJson();
    final docUmore = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(user)
        .collection('Umore')
        .doc(umoreID);
    await docUmore.set(json);
  }

  static String umoreIDGenerator(int len) {
    var r = Random();
    const chars = '1234567890aAbBcCdDeEfFgGhHiIlLmMnNoOpPqQrRsStTuUvVzZ';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Future<bool> checkUmore(caregiverID, patientID) async {
    DateTime start =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime end =
        start.add(const Duration(hours: 23, minutes: 59, seconds: 59));
    var fIstance = FirebaseFirestore.instance.collection('user');
    var docSnapshot = await fIstance
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(patientID)
        .collection('Umore')
        .where('data', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .where('data', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .get();

    if (docSnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
