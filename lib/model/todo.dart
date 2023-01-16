import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcare/controller/auth.dart';

class ToDo {
  final String todoID;
  final String text;
  final String oraCompleted;
  final bool completed;
  final DateTime data;
  ToDo({
    required this.todoID,
    required this.text,
    required this.oraCompleted,
    required this.completed,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'todoID': todoID,
        'text': text,
        'oraCompleted': oraCompleted,
        'completed': completed,
        'data': data
      };

  static ToDo fromJson(Map<String, dynamic> json) => ToDo(
      todoID: json['todoID'],
      text: json['text'],
      oraCompleted: json['oraCompleted'],
      completed: json['completed'],
      data: json['data']);

  Future<void> crateToDo(String userID) async {
    final json = toJson();

    final docUser = FirebaseFirestore.instance
        .collection('user')
        .doc(Auth().currentUser!.uid)
        .collection('Pazienti')
        .doc(userID)
        .collection('ToDoList')
        .doc(todoID);
    await docUser.set(json);
  }
}
