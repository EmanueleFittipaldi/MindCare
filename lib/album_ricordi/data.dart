import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Doodle {
  final String name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {required this.name,
      required this.time,
      required this.content,
      required this.doodle,
      required this.icon,
      required this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
      name: "Vacanze al mare",
      time: "1969",
      content: "",
      doodle: 'https://live.staticflickr.com/1741/42730982391_14826cb66e_b.jpg',
      icon: Icon(
        FontAwesomeIcons.circle,
        color: Color(0xFF36383C),
        size: 15,
      ),
      iconBackground: Colors.transparent),
  Doodle(
      name: "Giosuè che gioca",
      time: "1979",
      content: "",
      doodle: 'https://s.hdnux.com/photos/01/23/44/17/21906424/4/1200x0.jpg',
      icon: Icon(
        FontAwesomeIcons.circle,
        color: Color(0xFF36383C),
        size: 15,
      ),
      iconBackground: Colors.transparent),
];
