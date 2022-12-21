import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';

class ContattoSOS {
  final String contattoID;
  final String name;
  final String lastname;
  final String cell;
  final String profileImgPath;
  ContattoSOS(
      {required this.contattoID,
      required this.name,
      required this.lastname,
      required this.cell,
      required this.profileImgPath});

  Map<String, dynamic> toJson() => {
        'contattoID': contattoID,
        'name': name,
        'lastname': lastname,
        'cell': cell,
        'profileImagePath': profileImgPath,
      };

  static ContattoSOS fromJson(Map<String, dynamic> json) => ContattoSOS(
      contattoID: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      cell: json['cell'],
      profileImgPath: json['profileImagePath']);

  Future<void> createContatto() async {
    final json = toJson();
    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser?.uid)
        .collection('Pazienti')
        .doc(json['contattoID']);
    await docUser.set(json);
  }
}
