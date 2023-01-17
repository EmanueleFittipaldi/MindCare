import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/umore.dart';

class UmoreController {
  Future<String> createUmore(
      String caregiverID, String user, String text, String type) async {
    DateTime data = DateTime.now();
    var umoreID = umoreIDGenerator(28);
    var results = Sentiment()
        .analysis(text, languageCode: LanguageCode.italian, emoji: true);
    Umore umore = Umore(
        text: text,
        score: results['score'],
        comparative: results['comparative'],
        data: data,
        umoreID: umoreID,
        type: type);
    final json = umore.toJson();
    final docUmore = FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(user)
        .collection('Umore')
        .doc(umoreID);
    await docUmore.set(json);
    return umoreID;
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
      var isGiornaliero = false;
      for (var item in docSnapshot.docs) {
        if (item['type'] == 'giornaliero') {
          isGiornaliero = true;
        }
      }
      return isGiornaliero;
    }
    return false;
  }

  getUmoreDataInRange(userID, startDate, endDate) async {
    var fIstance = FirebaseFirestore.instance.collection('user');

    QuerySnapshot docSnapshot = await fIstance
        .doc(Auth().currentUser!.uid)
        .collection('Pazienti')
        .doc(userID)
        .collection('Umore')
        .where('data', isLessThanOrEqualTo: Timestamp.fromDate(endDate!))
        .where('data', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate!))
        .orderBy('data', descending: false)
        .get();

    List<Umore> umoreData = [];

    for (var j = 0; j < docSnapshot.docs.length; j++) {
      var item = docSnapshot.docs[j].data() as Map<String, dynamic>?;
      umoreData.add(Umore(
          text: item!['text'],
          score: item['score'],
          comparative: item['comparative'],
          data: (item['data'] as Timestamp).toDate(),
          umoreID: item['umoreID'],
          type: item['type']));
    }

    return umoreData;
  }
}
