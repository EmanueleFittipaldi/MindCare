import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SosWidget extends StatefulWidget {
  const SosWidget({Key? key}) : super(key: key);

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
    // ignore: no_leading_underscores_for_local_identifiers
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

    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

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

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Future<void> _sendSMS(String phoneNumber) async {
      final Uri _url = Uri(
        scheme: 'sms',
        path: phoneNumber,
        query: encodeQueryParameters(
            <String, String>{'body': 'ciao sono un test'}),
      );
      if (!await launchUrl(_url)) {
        throw 'Cannot lunch $_url';
      }
    }

    Future<void> _sendSMSAndroid(String phoneNumber) async {
      final Telephony telephony = Telephony.instance;
      await getLocation();
      telephony.sendSms(
          to: phoneNumber, message: "Indirizzo: $_currentAddress");
    }

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
                child: Container(
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
                            'Qui puoi trovare una lista di contatti utili che puoi utilizzare ogni qualvolta ne \nhai strettamente bisogno.',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'IBM Plex Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        'Contatti di emergenza',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'IBM Plex Sans',
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 8),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/headline/public/2015/03/14/doctor.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: AutoSizeText(
                                          'Giovanni Boldini',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'IBM Plex Sans',
                                                fontSize: 20,
                                              ),
                                        ),
                                      ),
                                      AutoSizeText(
                                        'Psicologo',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'IBM Plex Sans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
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
                                  FontAwesomeIcons.phoneAlt,
                                  color: Color(0xFF8E8E8E),
                                  size: 30,
                                ),
                                onPressed: () {
                                  _sendSMSAndroid('+39-3312739420');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
