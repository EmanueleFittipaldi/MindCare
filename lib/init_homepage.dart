import 'package:flutter/material.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/caregiver/opzioni.dart';
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
        'Paziente': HomePazienteWidget(
          caregiverUID: widget.carUID!,
        )
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      body: SafeArea(
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  Offstage(
                    offstage: _selectedIndex != 1,
                    child: Center(
                      child: OpzioniWidget(
                        user: widget.user,
                        caregiverUID: widget.carUID ?? '',
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: _selectedIndex != 0,
                    child: Center(
                      child: _widgetOptions.elementAt(0)[widget.user.type],
                    ),
                  ),
                ],
              ))),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 35),
            label: '',
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
