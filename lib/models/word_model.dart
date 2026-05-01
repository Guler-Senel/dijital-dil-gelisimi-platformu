import 'package:flutter/material.dart';

class WordModel {
  const WordModel({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.categoryEmoji,
    required this.syllables,
  });

  final String id;
  final String name;
  final String imageAsset;
  final String categoryEmoji;
  final String syllables;

  IconData? get categoryIcon {
    switch (id) {
      case 'w1':
        return Icons.apple;
      case 'w2':
        return Icons.pets;
      default:
        return null;
    }
  }
}
