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

  // List of labels
  static List<String> labels = [personal, work, finance, health, other];
  static Map<String, Color> tagColors = {
    "Personnel": personalColor,
    "Travail": workColor,
    "Finance": financeColor,
    "Santé": healthColor,
    "Autre": otherColor,
  };
  //
  static List<TagModel> tagsFromLabels(List<String> tags) {
    return List.generate(
      tags.length,
      (index) => TagModel(
        label: labels.where((element) => element == tags[index]).first,
        color: tagColors.entries
            .where((element) => element.key == tags[index])
            .first
            .value,
      ),
    );
  }
}
