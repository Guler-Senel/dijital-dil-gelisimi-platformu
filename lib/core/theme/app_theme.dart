import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidlingua/core/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData childTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.childBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.childPrimary,
      brightness: Brightness.light,
      primary: AppColors.childPrimary,
      secondary: AppColors.childSecondary,
      surface: AppColors.childCardBg,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.childText,
    ),
  );

  static ThemeData parentTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.parentBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.parentPrimary,
      brightness: Brightness.light,
      primary: AppColors.parentPrimary,
      surface: AppColors.parentCard,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.parentText,
    ),
  );
}
