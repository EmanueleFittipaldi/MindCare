import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/album_ricordi/ricordo_widget.dart';
import 'package:mindcare/controller/auth.dart';
// ignore: depend_on_referenced_packages
import 'package:timeline_list/timeline.dart';
// ignore: depend_on_referenced_packages
import 'package:timeline_list/timeline_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/ricordo.dart';

class TimelinePage extends StatefulWidget {
  final String caregiverUID;
  const TimelinePage({Key? key, required this.caregiverUID}) : super(key: key);
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Ricordo> doodles = [];
  String? fileName;
  @override
  Widget build(BuildContext context) {
    print(widget.caregiverUID);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(widget.caregiverUID)
            .collection('Pazienti')
            .doc(Auth().currentUser!.uid)
            .collection('Ricordi')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            doodles = [];
            snapshot.data?.docs.forEach((doc) async {
              Map<String, dynamic>? memory = doc.data();
              doodles.add(Ricordo(
                  titolo: memory!['titolo'],
                  annoRicordo: memory['annoRicordo'],
                  descrizione: memory['descrizione'],
                  filePath: memory['filePath'],
                  ricordoID: memory['ricordoID'],
                  tipoRicordo: memory['tipoRicordo']));
            });
            return timelineModel(TimelinePosition.Left);
          } else {
            return const Text('');
          }
        });
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: doodles.length,
      physics: const ClampingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    return TimelineModel(
        Card(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          color: const Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RicordoWidget(
                        ricordo: doodle,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  doodle.tipoRicordo == 'Immagine'
                      ? Image.network(
                          doodle.filePath,
                          width: MediaQuery.of(context).size.width * 1,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/add_photo.png",
                          width: MediaQuery.of(context).size.width * 1,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    doodle.annoRicordo.toString(),
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    doodle.titolo,
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: Colors.transparent,
        icon: const Icon(
          FontAwesomeIcons.circle,
          color: Color(0xFF36383C),
          size: 15,
        ));
  }
}
