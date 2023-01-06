import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/appbar/appbar_caregiver.dart';
import 'package:mindcare/dialog/confirm_dialog.dart';
import 'package:mindcare/gestione_SOS/sos_creazioneContatto.dart';
import 'package:mindcare/gestione_quiz/domanda_img_a_nome.dart';
import 'package:mindcare/gestione_quiz/domanda_nome_a_img.dart';
import 'package:mindcare/model/contattoSOS.dart';
import 'package:mindcare/model/quesito.dart';
import '../controller/auth.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../model/utente.dart';

class SOSCaregiverWidget extends StatefulWidget {
  final Utente user;
  const SOSCaregiverWidget({Key? key, required this.user}) : super(key: key);

  @override
  _SOSCaregiverWidgetState createState() => _SOSCaregiverWidgetState();
}

class _SOSCaregiverWidgetState extends State<SOSCaregiverWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).secondaryText),
        automaticallyImplyLeading: true,
        title: Text(
          'SOS',
          style: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'IBM Plex Sans',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
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
                    Container(
                      width: double.infinity,
                      height: 250,
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
                          bottomLeft: Radius.circular(155),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  25, 50, 0, 0),
                              child: Text(
                                'Gestione dei contatti di emergenza che il paziente può chiamare.',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/young-man-talking-on-mobile-phone-calling-concept-vector-40718994.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                            child: Text(
                              'Contatti di emergenza',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 25,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SOScontattoWidget(
                                      user: widget.user, item: null),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 0),
                            child: ListView(
                              //LISTVIEW
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  // Questo è il container che contiene la lista
                                  //delle domande
                                  child: Container(
                                    //CONTAINER
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .lineColor,
                                        width: 2,
                                      ),
                                    ),

                                    /*StreamBuilder per caricare dinamicamente
                               le domande da firebase*/
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(Auth().currentUser?.uid)
                                            .collection('Pazienti')
                                            .doc(widget.user.userID)
                                            .collection('contattiSOS')
                                            .snapshots(),
                                        //StreamBuilder per caricare i dati dei quesiti
                                        //funzione per ottenere i dati dei quesiti
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            var data = [];
                                            snapshot.data?.docs.forEach((doc) {
                                              //iterazione sui singoli documenti
                                              Map<String, dynamic>? quesitiMap =
                                                  doc.data(); //mappatura dei dati
                                              data.add(quesitiMap);
                                            });
                                            if (data.isEmpty) {
                                              //se la lista è vuota mostra 'Non ci sono domande'
                                              return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Non ci sono contatti!',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                color: const Color(
                                                                    0xFF57636C),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ]));
                                            }
                                            //altrimenti ritorna i diversi widget delle domande
                                            return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                /*Devo costruire il widget di un paziente rappresentato da un
                                          container per ogni paziente che ho recuperato in data. Per fare
                                          Questo utilizzo un for.*/
                                                children: [
                                                  for (var item in data)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              8, 8, 8, 8),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 80,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0, 0),
                                                            //ho pensato che è meglio inserire la categoria
                                                            //delle domande piuttosto che un numero progressivo
                                                            child: Text(
                                                              item['categoria'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      12,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            4,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      item[
                                                                          'domanda'],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'IBM Plex Sans',
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30,
                                                            borderWidth: 1,
                                                            buttonSize: 45,
                                                            icon: const Icon(
                                                              Icons.mode_edit,
                                                              color: Color(
                                                                  0xFF8E8E8E),
                                                              size: 25,
                                                            ),

                                                            /*Icona modificare un quesito*/
                                                            onPressed: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => SOScontattoWidget(
                                                                      user: widget
                                                                          .user,
                                                                      item: ContattoSOS(
                                                                          contattoID: item[
                                                                              'contattoID'],
                                                                          name: item[
                                                                              'name'],
                                                                          lastname: item[
                                                                              'lastname'],
                                                                          cell: item[
                                                                              'cell'],
                                                                          profileImgPath:
                                                                              item['profileImagePath']))));
                                                            },
                                                          ),
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30,
                                                            borderWidth: 1,
                                                            buttonSize: 45,
                                                            icon: const Icon(
                                                              Icons.cancel,
                                                              color: Color(
                                                                  0xFF8E8E8E),
                                                              size: 25,
                                                            ),
                                                            /*Icona per cancellare un quesito.
                                                      Alla pressione di questa icona viene cancellata
                                                      la domanda corrispondete da Firebase. */
                                                            onPressed:
                                                                () async {
                                                              var confirmDialogResponse =
                                                                  await showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return const ConfirmDialog(
                                                                          title:
                                                                              'Eliminazione Contatto',
                                                                          description:
                                                                              'Vuoi davvero eliminare il contatto?',
                                                                          textOptionConfirm:
                                                                              'Conferma',
                                                                          textOptionDelete:
                                                                              'Annulla',
                                                                        );
                                                                      });
                                                              if (confirmDialogResponse) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'user')
                                                                    .doc(Auth()
                                                                        .currentUser
                                                                        ?.uid)
                                                                    .collection(
                                                                        'Pazienti')
                                                                    .doc(widget
                                                                        .user
                                                                        .userID)
                                                                    .collection(
                                                                        'contattiSOS')
                                                                    .doc(item[
                                                                        'contattoID'])
                                                                    .delete();
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ]);
                                          }
                                          return const Text(
                                              'Caricamento dei contatti in corso...');
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ))
          ],
        ),
      ),
    );
  }
}
