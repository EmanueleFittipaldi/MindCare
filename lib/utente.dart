import 'package:cloud_firestore/cloud_firestore.dart';

class Utente {

  final String userID;
  final String name;
  final String lastname;
  final String email;
  
  Utente({
    required this.userID,
    required this.name,
    required this.lastname,
    required this.email
  });
  
  final docUser = FirebaseFirestore.instance.collection('user').doc();

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'name': name,
    'lastname': lastname,
    'email': email
    };

  Future<void> createNewUser() async{

    final json = this.toJson();

    await docUser.set(json);
  }

}