import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindcare/gestione_SOS/sos_creazioneContatto.dart';
import 'package:mindcare/model/contattoSOS.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../controller/auth.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';
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
                              'assets/images/undraw_connecting_teams_re_hno7.svg',
                              width: 300,
                              height: 165,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-1, 0.8),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment:
                                        const AlignmentDirectional(0, 0.15),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 10),
                                      child: AutoSizeText(
                                        'Aggiungi o elimina contatti di emergenza',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            'Contatti di emergenza:',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'IBM Plex Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 50,
                          fillColor: FlutterFlowTheme.of(context).primaryColor,
                          icon: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            size: 25,
                          ),
                          onPressed: () async {
                            await Navigator.of(context).push(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(Auth().currentUser?.uid)
                            .collection('Pazienti')
                            .doc(widget.user.userID)
                            .collection('ContattiSOS')
                            .snapshots(),
                        //StreamBuilder per caricare i dati dei quesiti
                        //funzione per ottenere i dati dei quesiti
                        builder: (context, AsyncSnapshot snapshot) {
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Non ci sono contatti!',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color: const Color(0xFF57636C),
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ]));
                            }
                            //altrimenti ritorna i diversi widget delle domande
                            return ListView(
                              //LISTVIEW
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                for (var item in data)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 15, 10),
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
                                        borderRadius: BorderRadius.circular(30),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child:
                                                    item['profileImagePath'] !=
                                                            ''
                                                        ? Image.network(
                                                            item[
                                                                'profileImagePath'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'assets/images/add_photo.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        item['name'] +
                                                            ' ' +
                                                            item['lastname'],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'IBM Plex Sans',
                                                                  fontSize: 18,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        item['cell'],
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'IBM Plex Sans',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 45,
                                              icon: const Icon(
                                                Icons.mode_edit,
                                                color: Color(0xFF8E8E8E),
                                                size: 25,
                                              ),

                                              /*Icona modificare un quesito*/
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        SOScontattoWidget(
                                                            user: widget.user,
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
                                                                    item[
                                                                        'profileImagePath']))));
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 45,
                                              icon: const Icon(
                                                Icons.delete_forever_outlined,
                                                color: Color(0xFF8E8E8E),
                                                size: 25,
                                              ),
                                              /*Icona per cancellare un quesito.
                                                      Alla pressione di questa icona viene cancellata
                                                      la domanda corrispondete da Firebase. */
                                              onPressed: () async {
                                                var confirmDialogResponse =
                                                    await PanaraConfirmDialog
                                                        .show(
                                                  context,
                                                  title:
                                                      "Eliminazione contatto",
                                                  message:
                                                      "Vuoi davvero eliminare il contatto? L'azione non è riversibile!",
                                                  confirmButtonText: "Conferma",
                                                  cancelButtonText: "Annulla",
                                                  onTapCancel: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  onTapConfirm: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  panaraDialogType:
                                                      PanaraDialogType.normal,

                                                  barrierDismissible:
                                                      false, // optional parameter (default is true)
                                                );

                                                if (confirmDialogResponse) {
                                                  FirebaseFirestore.instance
                                                      .collection('user')
                                                      .doc(Auth()
                                                          .currentUser
                                                          ?.uid)
                                                      .collection('Pazienti')
                                                      .doc(widget.user.userID)
                                                      .collection('ContattiSOS')
                                                      .doc(item['contattoID'])
                                                      .delete();
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
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
