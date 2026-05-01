import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';

void playWordSoundPrint(String word) {
  debugPrint('ses çalınıyor: $word');
}

String formatDurationLabel(Duration d) {
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (d.inHours > 0) {
    final h = d.inHours.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
  return '$m:$s';
}

String formatClock(Duration d) {
  final m = d.inMinutes.toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$m:$s';
}

Color pastelBackgroundAt(int index) {
  return AppColors.childCardPastels[index % AppColors.childCardPastels.length];
}

Color wordCardTint(int index) {
  final tints = [
    AppColors.childPink.withOpacity(0.45),
    AppColors.childBlue.withOpacity(0.35),
    AppColors.childSecondary.withOpacity(0.4),
  ];
  return tints[index % tints.length];
}
