import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/auth.dart';

class Utente {
  final String userID;
  final String name;
  final String lastname;
  final String email;
  final String type;
  final DateTime date;
  final String profileImgPath;
  Utente(
      {required this.userID,
      required this.name,
      required this.lastname,
      required this.email,
      required this.type,
      required this.date,
      required this.profileImgPath});

  final docUser = FirebaseFirestore.instance.collection('user').doc();
  final queryUser = FirebaseFirestore.instance.collection('user');

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'name': name,
        'lastname': lastname,
        'email': email,
        'type': type,
        'dateOfBirth': date,
        'profileImagePath': profileImgPath
      };

  static Utente fromJson(Map<String, dynamic> json) => Utente(
        userID: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        email: json['email'],
        type: json['type'],
        date: json['dateOfBirth'],
        profileImgPath: json['profileImagePath'],
      );

  Future<void> createNewUser() async {
    final json = toJson();
    await docUser.set(json);
  }

  String getName() {
    final name = queryUser.where("name", isEqualTo: "pasqualino").get();
    print("stampo il nome");
    print(name.toString());
    return name.toString();
  }
}