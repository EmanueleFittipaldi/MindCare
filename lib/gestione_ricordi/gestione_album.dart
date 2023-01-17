import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/controller/album_controller.dart';
import 'package:mindcare/controller/auth.dart';
import 'package:mindcare/gestione_ricordi/creazione_ricordo.dart';
import 'package:mindcare/model/ricordo.dart';
import 'package:mindcare/model/utente.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';

class GestioneAlbumWidget extends StatefulWidget {
  final Utente user;
  const GestioneAlbumWidget({Key? key, required this.user}) : super(key: key);

  @override
  _GestioneAlbumWidgetState createState() => _GestioneAlbumWidgetState();
}

class _GestioneAlbumWidgetState extends State<GestioneAlbumWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarWidget(
          title: 'Album ricordi',
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 250,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 230,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Color(0x14000000),
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            alignment: const AlignmentDirectional(-0.0, 0),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.1, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8, 8, 8, 8),
                              child: SvgPicture.asset(
                                'assets/images/undraw_camera_re_cnp4.svg',
                                width: 300,
                                height: 170,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0.85),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 5, 20, 5),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: AutoSizeText(
                                          'Aggiungi o elimina ricordi dall\'album del paziente',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 20, 0),
                            child: Text(
                              'Ricordi',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 22,
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RicordoImmagineWidget(
                                        userID: widget.user.userID,
                                        memoryItem: null,
                                      )));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 20),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .doc(Auth().currentUser?.uid)
                              .collection('Pazienti')
                              .doc(widget.user.userID)
                              .collection('Ricordi')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var data = [];
                              snapshot.data?.docs.forEach((doc) {
                                //iterazione sui singoli documenti
                                Map<String, dynamic>? memoryMap =
                                    doc.data(); //mappatura dei dati
                                data.add(memoryMap);
                              });

                              if (data.isNotEmpty) {
                                return ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    for (int i = 0; i < data.length; i++)
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 0, 15, 10),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x14000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8, 8, 8, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                    width: 80,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0, 0),
                                                    child: Text(
                                                      data[i]['tipoRicordo'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                fontSize: 12,
                                                              ),
                                                    )),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Text(
                                                            data[i]['titolo'],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 45,
                                                  icon: const Icon(
                                                    Icons.mode_edit,
                                                    color: Color(0xFF8E8E8E),
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RicordoImmagineWidget(
                                                                    userID: widget
                                                                        .user
                                                                        .userID,
                                                                    memoryItem:
                                                                        Ricordo(
                                                                      titolo: data[
                                                                              i]
                                                                          [
                                                                          'titolo'],
                                                                      annoRicordo:
                                                                          data[i]
                                                                              [
                                                                              'annoRicordo'],
                                                                      descrizione:
                                                                          data[i]
                                                                              [
                                                                              'descrizione'],
                                                                      filePath:
                                                                          data[i]
                                                                              [
                                                                              'filePath'],
                                                                      ricordoID:
                                                                          data[i]
                                                                              [
                                                                              'ricordoID'],
                                                                      tipoRicordo:
                                                                          data[i]
                                                                              [
                                                                              'tipoRicordo'],
                                                                      tags: data[
                                                                              i]
                                                                          [
                                                                          'tags'],
                                                                    ))));
                                                  },
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 45,
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_forever_outlined,
                                                    color: Color(0xFF8E8E8E),
                                                    size: 25,
                                                  ),
                                                  onPressed: () async {
                                                    var confirmDialogResponse =
                                                        await PanaraConfirmDialog
                                                            .show(
                                                      context,
                                                      title:
                                                          "Eliminazione ricordo",
                                                      message:
                                                          "Vuoi davvero eliminare il ricordo? L'azione non è riversibile!",
                                                      confirmButtonText:
                                                          "Conferma",
                                                      cancelButtonText:
                                                          "Annulla",
                                                      onTapCancel: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      onTapConfirm: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      panaraDialogType:
                                                          PanaraDialogType
                                                              .normal,

                                                      barrierDismissible:
                                                          false, // optional parameter (default is true)
                                                    );

                                                    if (confirmDialogResponse) {
                                                      AlbumController()
                                                          .deleteMemory(
                                                              widget
                                                                  .user.userID,
                                                              Auth()
                                                                  .currentUser
                                                                  ?.uid,
                                                              data[i]
                                                                  ['ricordoID'],
                                                              data[i]
                                                                  ['filePath']);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              } else {
                                return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Non ci sono ricordi!',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'IBM Plex Sans',
                                                  color:
                                                      const Color(0xFF57636C),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ]));
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
