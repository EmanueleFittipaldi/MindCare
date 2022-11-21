import 'package:flutter/material.dart';
import 'package:mindcare/login.dart';
import 'package:mindcare/Quiz/categoria.dart';
import 'package:mindcare/Quiz/tipologia.dart';

import 'homeCaregiver.dart';
import 'homePaziente.dart';

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
