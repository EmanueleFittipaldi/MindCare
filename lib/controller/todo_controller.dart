import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/model/todo.dart';

class ToDoController {
  Future<void> createToDo(String userID, String text, DateTime data) async {
    var todoID = todoIDGenerator(28);
    TimeOfDay hourC = const TimeOfDay(hour: 00, minute: 00);
    ToDo todo = ToDo(
        todoID: todoID,
        text: text,
        oraCompleted: '${hourC.hour}:${hourC.minute}',
        completed: false,
        data: data);
    todo.crateToDo(userID);
  }

  static String todoIDGenerator(int len) {
    var r = Random();
    const chars = '1234567890aAbBcCdDeEfFgGhHiIlLmMnNoOpPqQrRsStTuUvVzZ';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Future<void> updateToDo(String userID, String text, DateTime data,
      String todoID, String timeOfDay, bool completed) async {
    ToDo todo = ToDo(
        todoID: todoID,
        text: text,
        oraCompleted: timeOfDay,
        completed: completed,
        data: data);

    await todo.crateToDo(userID);
  }

  Future<void> updateCompleted(String userID, String caregiverID, String todoID,
      String oraCompleted, bool completed) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('ToDoList')
        .doc(todoID)
        .update({'completed': completed, 'oraCompleted': oraCompleted});
  }

  Future<void> deleteToDo(userID, caregiverID, todoID) async {
    var user = FirebaseFirestore.instance.collection('user');
    var docSnapshot = user
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('ToDoList')
        .doc(todoID); //riferimento al documento da eliminare
    await FirebaseFirestore.instance
        .runTransaction((Transaction deleteTransaction) async {
      deleteTransaction.delete(docSnapshot); //transazione per l'eliminazione
    });
  }
}
