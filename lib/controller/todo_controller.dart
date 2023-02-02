import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:mindcare/model/todo.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  Future<List> checkToDo(userID, caregiverID) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterNativeTimezone.getLocalTimezone(),
      ),
    );
    var start = tz.TZDateTime.now(tz.local);
    var end = tz.TZDateTime.now(tz.local)
        .add(Duration(hours: 23 - start.hour, minutes: 59 - start.minute));
    var fIstance = FirebaseFirestore.instance.collection('user');
    var docSnapshot = await fIstance
        .doc(caregiverID)
        .collection('Pazienti')
        .doc(userID)
        .collection('ToDoList')
        .where('data', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .where('data', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .orderBy('data', descending: false)
        .get();
    var listD = [];
    if (docSnapshot.docs.isNotEmpty) {
      for (var item in docSnapshot.docs) {
        if (item['completed'] == false) {
          var dateToDo = (item['data'] as Timestamp).toDate();
          listD.add(dateToDo.difference(start).inSeconds);
        }
      }
    }
    return listD;
  }
}
