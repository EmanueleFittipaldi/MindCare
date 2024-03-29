import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';

class Utente {
  final String userID;
  final String name;
  final String lastname;
  final String email;
  final String type;
  final DateTime date;
  final String profileImgPath;
  bool checkBiometric;
  Utente(
      {required this.userID,
      required this.name,
      required this.lastname,
      required this.email,
      required this.type,
      required this.date,
      required this.profileImgPath,
      required this.checkBiometric
      });

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'name': name,
        'lastname': lastname,
        'email': email,
        'type': type,
        'dateOfBirth': date,
        'profileImagePath': profileImgPath,
        'checkBiometric': checkBiometric
      };

  static Utente fromJson(Map<String, dynamic> json) => Utente(
        userID: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        email: json['email'],
        type: json['type'],
        date: json['dateOfBirth'],
        profileImgPath: json['profileImagePath'],
        checkBiometric: json['checkBiometric']
      );

  Future<void> createNewUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid);
    final json = toJson();
    await docUser.set(json);
  }

  Future<void> createPatient() async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(json['userID']);
    await docUser.set(json);
  }
}
