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
  final queryUser = FirebaseFirestore.instance.collection('user');

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'name': name,
    'lastname': lastname,
    'email': email
    };

  static Utente fromJson(Map<String, dynamic> json) => Utente(
    userID: json['id'],
    name: json['name'],
    lastname: json['lastname'],
    email: json['email']
  );

  Future<void> createNewUser() async{

    final json = this.toJson();

    await docUser.set(json);
  }

  String getName(){
    final name = queryUser.where("name", isEqualTo: "pasqualino").get();
    print("stampo il nome");
    print(name.toString());
    return name.toString();
  }

}