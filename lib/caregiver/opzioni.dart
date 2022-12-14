import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:mindcare/widget_tree.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../controller/auth.dart';
import '../autenticazione/login.dart';

import '../model/utente.dart';

class OpzioniWidget extends StatefulWidget {
  Utente user;
  final String caregiverUID;
  OpzioniWidget({Key? key, required this.user, required this.caregiverUID})
      : super(key: key);

  @override
  _OpzioniWidgetState createState() => _OpzioniWidgetState();
}

class _OpzioniWidgetState extends State<OpzioniWidget> {
  DateTime? datePicked;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textcontrollerData;

  late bool passwordVisibility1;
  TextEditingController? textController5;

  late bool passwordVisibility2;
  TextEditingController? textController6;

  late bool passwordVisibility3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: widget.user.name);
    textController2 = TextEditingController(text: widget.user.lastname);
    textController3 = TextEditingController(text: widget.user.email);
    textController4 = TextEditingController();
    textcontrollerData = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(widget.user.date));
    passwordVisibility1 = false;
    textController5 = TextEditingController();
    passwordVisibility2 = false;
    textController6 = TextEditingController();
    passwordVisibility3 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    textController6?.dispose();
    textcontrollerData?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: widget.user.type == 'Paziente'
                ? FirebaseFirestore.instance
                    .collection('user')
                    .doc(widget.caregiverUID)
                    .collection('Pazienti')
                    .snapshots()
                : FirebaseFirestore.instance.collection('user').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data;
                snapshot.data?.docs.forEach((doc) {
                  //iterazione sui singoli documenti
                  Map<String, dynamic>? cmap = doc.data();
                  if (cmap!['userID'] == Auth().currentUser!.uid) {
                    data = cmap;
                  } //mappatura dei dati
                });
                if (data != null) {
                  widget.user = Utente(
                      userID: data['userID'],
                      name: data['name'],
                      lastname: data['lastname'],
                      email: data['email'],
                      type: data['type'],
                      date: (data?['dateOfBirth'] as Timestamp).toDate(),
                      profileImgPath: data['profileImagePath']);

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
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
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              70, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: widget.user.profileImgPath != ''
                                        ? Image.network(
                                            widget.user.profileImgPath,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/add_photo.png',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.user.name} ${widget.user.lastname}',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: Text(
                                          "",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
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
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: ExpandableNotifier(
                            initialExpanded: false,
                            child: ExpandablePanel(
                              header: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 4, 0),
                                child: Text(
                                  'Modifica dati',
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              collapsed: SizedBox.shrink(),
                              expanded: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 5),
                                      child: TextFormField(
                                        validator: (value) {
                                          String val =
                                              value!.replaceAll(' ', '');
                                          if (value.isEmpty || val.isEmpty) {
                                            return 'Inserisci un nome!';
                                          }
                                          return null;
                                        },
                                        controller: textController1,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Nome:',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 5),
                                      child: TextFormField(
                                        validator: (value) {
                                          String val =
                                              value!.replaceAll(' ', '');
                                          if (value.isEmpty || val.isEmpty) {
                                            return 'Inserisci un cognome!';
                                          }
                                          return null;
                                        },
                                        controller: textController2,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Cognome:',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 5),
                                      child: Container(
                                        width: double.infinity,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .borderColor,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 12, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          10, 0, 12, 0),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Inserisci una data di nascita!';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        textcontrollerData,
                                                    autofocus: true,
                                                    readOnly: true,
                                                    obscureText: false,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'IBM Plex Sans',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      onConfirm: (date) {
                                                    setState(() {
                                                      datePicked = date;
                                                      textcontrollerData!
                                                          .text = datePicked ==
                                                              null
                                                          ? 'Data di nascita'
                                                          : DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(DateTime
                                                                  .parse(datePicked
                                                                      .toString()));
                                                    });
                                                  },
                                                      currentTime:
                                                          getCurrentTimestamp,
                                                      minTime:
                                                          DateTime(0, 0, 0),
                                                      maxTime: DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        DateTime.now().day,
                                                      ));
                                                },
                                                child: const Icon(
                                                  Icons.date_range_outlined,
                                                  color: Color(0xFF57636C),
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 5),
                                      child: TextFormField(
                                        validator: (value) {
                                          String val =
                                              value!.replaceAll(' ', '');
                                          if (value.isEmpty || val.isEmpty) {
                                            return 'Inserisci l\'email!';
                                          }
                                          RegExp regex = RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                          if (!regex.hasMatch(value)) {
                                            return 'Inserisci un\'email valida!';
                                          }
                                          return null;
                                        },
                                        controller: textController3,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 15),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          print('sto qui');
                                          print(widget.caregiverUID);
                                          print(widget.user.userID);
                                          var success = await UserController()
                                              .modificaDati(
                                                  textController1?.text
                                                      .toString(),
                                                  textController2?.text
                                                      .toString(),
                                                  textcontrollerData!.text,
                                                  textController3?.text
                                                      .toString(),
                                                  widget.user.type,
                                                  widget.user.userID,
                                                  widget.caregiverUID);
                                          if (success) {
                                            Fluttertoast.showToast(
                                                msg: 'Modifica avvenuta!');
                                          }
                                        },
                                        text: 'Salva',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 40,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              theme: const ExpandableThemeData(
                                tapHeaderToExpand: true,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15, 20, 15, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: ExpandableNotifier(
                            initialExpanded: false,
                            child: ExpandablePanel(
                              header: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 4, 0),
                                child: Text(
                                  'Termini & Servizi',
                                  style: FlutterFlowTheme.of(context).subtitle2,
                                ),
                              ),
                              collapsed: SizedBox.shrink(),
                              expanded: Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: Text(
                                          "L'utilizzo dei Servizi avviene a rischio dell'utente ed è soggetto alle seguenti esclusioni di responsabilità. I nostri Servizi sono forniti nello stato in cui si trovano, senza garanzie esplicite o implicite, ivi comprese, a titolo esemplificativo e non esaustivo, garanzie relative a commerciabilità, idoneità per scopo specifico, proprietà o non violazione di diritti di terzi e assenza di virus o altri codici informatici dannosi. Non forniamo alcuna garanzia in merito all'esattezza, alla completezza e all'utilità delle informazioni, al funzionamento, alla mancanza di errori, alla sicurezza o alla protezione dei nostri Servizi o al funzionamento dei nostri Servizi senza interruzioni, ritardi o difetti. Non deteniamo il controllo e non siamo responsabili del controllo della modalità o del momento di utilizzo dei Servizi o delle funzioni, dei servizi e delle interfacce fornite dai nostri Servizi. Non siamo responsabili e non abbiamo l'obbligo di controllare le azioni o le informazioni dei nostri utenti o di altri terzi. L'utente esenta noi, le nostre società controllate e affiliate e i rispettivi dirigenti, amministratori, dipendenti, partner e agenti da ogni reclamo, ricorso, azione legale, controversia, contenzioso o danno, noti e non noti, relativi a, derivanti da o collegati in qualsiasi modo a reclami che l'utente possa avere contro terzi. I diritti dell'utente non vengono modificati dalle presenti esclusioni di responsabilità se le leggi in vigore nel Paese o nel territorio in cui risiede, applicabili come conseguenza dell'utilizzo dei nostri Servizi, non lo permettono.",
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              theme: const ExpandableThemeData(
                                tapHeaderToExpand: true,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Center(
                                            child:
                                                CircularProgressIndicator()));
                                    var success = await UserController()
                                        .forgottenPassword(widget.user.email);
                                    if (success) {}
                                  },
                                  text: 'Modifica password',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 60,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    Auth().signOut();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WidgetTree()));
                                  },
                                  text: 'Esci',
                                  options: FFButtonOptions(
                                    width: 100,
                                    height: 60,
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
