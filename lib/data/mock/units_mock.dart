import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/models/unit_model.dart';

final List<UnitModel> unitsMock = [
  UnitModel(
    id: 'u1',
    title: 'Renkler',
    progressPercent: 75,
    isCompleted: false,
    icon: Icons.palette_rounded,
    accentColor: AppColors.childPurple,
    wordIds: const ['w7'],
  ),
  UnitModel(
    id: 'u2',
    title: 'Hayvanlar',
    progressPercent: 25,
    isCompleted: false,
    icon: Icons.pets_rounded,
    accentColor: AppColors.childGreen,
    wordIds: const ['w2', 'w6'],
  ),
  UnitModel(
    id: 'u3',
    title: 'Yiyecekler',
    progressPercent: 50,
    isCompleted: false,
    icon: Icons.restaurant_rounded,
    accentColor: AppColors.childPrimary,
    wordIds: const ['w1'],
  ),
  UnitModel(
    id: 'u4',
    title: 'Şekiller',
    progressPercent: 100,
    isCompleted: true,
    icon: Icons.category_rounded,
    accentColor: AppColors.childBlue,
    wordIds: const ['w4', 'w5'],
  ),
  UnitModel(
    id: 'u5',
    title: 'Sayılar',
    progressPercent: 10,
    isCompleted: false,
    icon: Icons.looks_3_rounded,
    accentColor: AppColors.childSecondary,
    wordIds: const ['w8', 'w3'],
  ),
];

UnitModel? unitById(String id) {
  try {
    return unitsMock.firstWhere((u) => u.id == id);
  } catch (_) {
    return null;
  }
}
