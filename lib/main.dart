import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindcare/widget_tree.dart';
import 'package:mindcare/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
