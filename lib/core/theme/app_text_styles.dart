import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidlingua/core/theme/app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle childTitleLarge = GoogleFonts.fredoka(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.childText,
    height: 1.1,
  );

  static TextStyle childTitleMedium = GoogleFonts.fredoka(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.childText,
  );

  static TextStyle childSectionTitle = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.childText,
  );

  static TextStyle childBody = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.childText,
  );

  static TextStyle childBodyLight = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.childTextLight,
  );

  static TextStyle childLink = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.childPrimary,
  );

  static TextStyle childWordDisplay = GoogleFonts.fredoka(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.childPrimary,
  );

  static TextStyle parentHeadline = GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.parentText,
  );

  static TextStyle parentTitle = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.parentText,
  );

  static TextStyle parentBody = GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.parentText,
  );

  static TextStyle parentCaption = GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.parentTextGray,
  );

  static TextStyle parentSmall = GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.parentTextGray,
  );
}
