import 'package:flutter/material.dart';

class UnitModel {
  const UnitModel({
    required this.id,
    required this.title,
    required this.progressPercent,
    required this.isCompleted,
    required this.icon,
    required this.accentColor,
    required this.wordIds,
  });

  final String id;
  final String title;
  final int progressPercent;
  final bool isCompleted;
  final IconData icon;
  final Color accentColor;
  final List<String> wordIds;
}
