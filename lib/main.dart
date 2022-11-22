import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindcare/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MindCare());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

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
