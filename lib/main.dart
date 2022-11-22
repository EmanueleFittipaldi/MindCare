import 'package:flutter/material.dart';
import 'package:mindcare/caregiver/home_caregiver.dart';
import 'package:mindcare/login.dart';
import 'package:mindcare/paziente/home_paziente.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mindcare/widget_tree.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const WidgetTree(),
    );
  }
}
