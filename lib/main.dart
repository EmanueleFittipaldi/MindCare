import 'package:flutter/material.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/login.dart';
import 'package:mindcare/paziente/home_paziente.dart';

void main() {
  runApp(const MindCare());
}

class MindCare extends StatelessWidget {
  const MindCare({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindCare',
      theme: ThemeData(),
      home: const HomeCaregiverWidget(),
    );
  }
}
