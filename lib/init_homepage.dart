import 'package:flutter/material.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/caregiver/opzioni.dart';
import 'package:mindcare/controller/user_controller.dart';
import 'package:mindcare/flutter_flow/flutter_flow_theme.dart';
import 'package:mindcare/paziente/home_paziente.dart';
import 'package:mindcare/model/utente.dart';

class InitHomepage extends StatefulWidget {
  final Utente user;
  final String? carUID;

  const InitHomepage({super.key, required this.user, required this.carUID});
  @override
  _InitHomepageState createState() => _InitHomepageState();
}

class _InitHomepageState extends State<InitHomepage> {
  int _selectedIndex = 0;
  var _widgetOptions = [];

  @override
  void initState() {
    _widgetOptions = [
      {
        'Caregiver': const HomeCaregiverWidget(),
        'Paziente': const HomePazienteWidget()
      },
      OpzioniWidget(
        user: widget.user,
        caregiverUID: widget.carUID ?? '',
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Logo_MindCare.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                  child: Text(
                    'MindCare',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'IBM Plex Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 35,
                        ),
                  ),
                ),
              ],
            ),
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Center(
                child: _selectedIndex == 1
                    ? _widgetOptions.elementAt(_selectedIndex)
                    : _widgetOptions
                        .elementAt(_selectedIndex)[widget.user.type],
              ))),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Impostazioni',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: FlutterFlowTheme.of(context).primaryColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
