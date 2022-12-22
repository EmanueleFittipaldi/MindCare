import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/report.dart';

class ReportController {
  getReportInRange(userID, startDate, endDate) async {
    var fIstance = FirebaseFirestore.instance.collection('user');

    QuerySnapshot docSnapshot = await fIstance
        .doc(Auth().currentUser!.uid)
        .collection('Pazienti')
        .doc(userID)
        .collection('Report')
        .where('dataInizio', isLessThanOrEqualTo: Timestamp.fromDate(endDate!))
        .where('dataInizio',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate!))
        .orderBy('dataInizio', descending: false)
        .get();

    List<Report> reportData = [];

    for (var j = 0; j < docSnapshot.docs.length; j++) {
      var report = docSnapshot.docs[j].data() as Map<String, dynamic>?;
      reportData.add(Report(
          mappaRisposte: Map.from(report!['mappaRisposte']),
          tempoImpiegato: report['tempoImpiegato'],
          dataInizio: (report['dataInizio'] as Timestamp).toDate(),
          risposteCorrette: report['risposteCorrette'],
          risposteErrate: report['risposteErrate'],
          precisione: report['precisione'],
          reportID: report['reportID'],
          tipologia: report['tipologia'],
          categoria: report['categoria'],
          umore: report['umore']));
    }

    return reportData;
  }
}
