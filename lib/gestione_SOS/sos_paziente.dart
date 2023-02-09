import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindcare/model/utente.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;

class SosWidget extends StatefulWidget {
  final Utente user;
  final String caregiverUID;
  const SosWidget({Key? key, required this.user, required this.caregiverUID})
      : super(key: key);

  @override
  _SosWidgetState createState() => _SosWidgetState();
}

class _SosWidgetState extends State<SosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _currentAddress;
  late Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    // Function to make the phone call
    // ignore: no_leading_underscores_for_local_identifiers, unused_element
    _makePhoneCall(String phoneNumber) async {
      String url = 'tel:$phoneNumber';
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // ignore: use_build_context_synchronously
        PanaraInfoDialog.show(
          context,
          title: "Localizzazione",
          message: "Localizzazione disattivata. Per favore attiva il servizio!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false, // optional parameter (default is true)
        );
        // ignore: use_build_context_synchronously

        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // ignore: use_build_context_synchronously
          PanaraInfoDialog.show(
            context,
            title: "Localizzazione",
            message:
                "I permessi per accedere alla localizazione sono stati negati!",
            buttonText: "Okay",
            onTapDismiss: () {
              Navigator.pop(context);
            },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false, // optional parameter (default is true)
          );
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // ignore: use_build_context_synchronously
        PanaraInfoDialog.show(
          context,
          title: "Localizzazione",
          message:
              "I permessi per accedere alla localizazione sono stati permanentemente negati! Non posso effettuare altre richieste!",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false, // optional parameter (default is true)
        );

        return false;
      }
      return true;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _getAddressFromLatLng(Position position) async {
      await placemarkFromCoordinates(
              _currentPosition.latitude, _currentPosition.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Future<void> getLocation() async {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => _currentPosition = position);
        _getAddressFromLatLng(_currentPosition);
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Future<void> _sendSMSAndroid(String phoneNumber) async {
      final Telephony telephony = Telephony.instance;
      await getLocation();
      telephony.sendSms(
          to: phoneNumber, message: "Indirizzo: $_currentAddress");
    }

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _sendSMS(String phoneNumber) async {
      await getLocation();
      final Uri url = Uri(
        scheme: 'sms',
        path: phoneNumber,
        query: encodeQueryParameters(<String, String>{
          'body':
              'SOS MINDCARE: AIUTO! Mi sono perso! Indirizzo: $_currentAddress'
        }),
      );
      if (!await launchUrl(url)) {
        throw 'Cannot lunch $url';
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers, unused_element

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                // ignore: sized_box_for_whitespace
                child: Container(
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: SvgPicture.asset(
                            'assets/images/undraw_fatherhood_-7-i19.svg',
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
                          height: 60,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 0),
                                  child: SelectionArea(
                                      child: AutoSizeText(
                                    'Da questa schermata puoi contattare i tuoi cari quando ne hai strettamente bisogno',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  )),
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        'Contatti di emergenza',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(widget.caregiverUID)
                        .collection('Pazienti')
                        .doc(widget.user.userID)
                        .collection('ContattiSOS')
                        .snapshots(),
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
                          return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        return ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            for (var item in data)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 10, 15, 10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 12,
                                        color: Color(0x14000000),
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: item['profileImagePath'] != ''
                                              ? Image.network(
                                                  item['profileImagePath'],
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/add_photo.png',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 4, 0, 0),
                                                  child: AutoSizeText(
                                                    item['name'] +
                                                        ' ' +
                                                        item['lastname'],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'IBM Plex Sans',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  item['cell'],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily:
                                                            'IBM Plex Sans',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300,
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
                                          buttonSize: 50,
                                          icon: const FaIcon(
                                            // ignore: deprecated_member_use
                                            Icons.textsms_outlined,
                                            color: Color(0xFF8E8E8E),
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            var number = '+39-' + item['cell'];
                                            //qui ci vuole sicuramente il numero di telefono contenuto in item['cell']
                                            if (Platform.isAndroid) {
                                              _sendSMS(number);
                                            } else if (Platform.isIOS) {
                                              _sendSMS(number);
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
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
