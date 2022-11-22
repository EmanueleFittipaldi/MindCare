import 'auth.dart';
import 'home_page.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("sono dentro widgetTree - SnapShot");
          return HomePage();
        } else {
          print("sono dentro widgetTre - Snapshot NULL");
          return LoginWidget();
        }
      },
    );
  }
}