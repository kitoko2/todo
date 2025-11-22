// create tag model
import 'package:flutter/material.dart';

class TagModel {
  final String label;
  final Color color;

  TagModel({required this.label, required this.color});
}

class NoteTags {
  static String personal = "Personnel";
  static String work = "Travail";
  static String finance = "Finance";
  static String health = "Santé";
  static String other = "Autre";

  static Color personalColor = Colors.blue;
  static Color workColor = Colors.teal;
  static Color financeColor = Colors.brown;
  static Color healthColor = Colors.red;
  static Color otherColor = Colors.orange;

  static List<TagModel> tagsList = [
    TagModel(label: NoteTags.personal, color: NoteTags.personalColor),
    TagModel(label: NoteTags.work, color: NoteTags.workColor),
    TagModel(label: NoteTags.finance, color: NoteTags.financeColor),
    TagModel(label: NoteTags.health, color: NoteTags.healthColor),
    TagModel(label: NoteTags.other, color: NoteTags.otherColor),
  ];
}
