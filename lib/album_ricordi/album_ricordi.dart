import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/album_ricordi/timeline.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/model/ricordo.dart';
import 'package:mindcare/model/utente.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class AlbumRicordiWidget extends StatefulWidget {
  final String caregiverUID;
  final Utente user;
  const AlbumRicordiWidget(
      {Key? key, required this.caregiverUID, required this.user})
      : super(key: key);

  @override
  _AlbumRicordiWidgetState createState() => _AlbumRicordiWidgetState();
}

class _AlbumRicordiWidgetState extends State<AlbumRicordiWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final tagsController = TextEditingController();
  String? tagSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppbarWidget(title: 'I miei ricordi')),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).backgroundPrimaryColor,
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(widget.caregiverUID)
                    .collection('Pazienti')
                    .doc(Auth().currentUser!.uid)
                    .collection('Ricordi')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Ricordo> doodles = [];
                    List<String> tags = ['Tutti i ricordi'];
                    snapshot.data?.docs.forEach((doc) async {
                      Map<String, dynamic>? memory = doc.data();
                      if (tagSelected == null ||
                          memory!['tags']
                              .contains(tagSelected!.toLowerCase())) {
                        doodles.add(Ricordo(
                            titolo: memory!['titolo'],
                            annoRicordo: memory['annoRicordo'],
                            descrizione: memory['descrizione'],
                            filePath: memory['filePath'],
                            ricordoID: memory['ricordoID'],
                            tipoRicordo: memory['tipoRicordo'],
                            tags: memory['tags']));
                      }
                      memory['tags'].forEach((e) {
                        var el = e.toString()[0].toUpperCase() +
                            e.toString().substring(1).toLowerCase();
                        if (!tags.contains(el)) {
                          tags.add(el);
                        }
                      });
                    });
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 30, 20, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 12,
                                      color: Color(0x14000000),
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: CustomDropdown.search(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  hintText: 'Cosa vuoi vedere?',
                                  items: tags,
                                  controller: tagsController,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == 'Tutti i ricordi') {
                                        tagSelected = null;
                                      } else {
                                        tagSelected = value;
                                      }
                                    });
                                  },
                                ))),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            child: TimelinePage(
                                caregiverUID: widget.caregiverUID,
                                doodles: doodles),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
