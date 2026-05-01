import 'package:flutter/material.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';

class ChildHomeHeader extends StatelessWidget {
  const ChildHomeHeader({super.key, required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.childPrimary, AppColors.childSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KİDLİNGUA',
                  style: AppTextStyles.childTitleLarge.copyWith(
                    color: AppColors.onLight,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.childPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    AppConstants.childAgeBadge,
                    style: AppTextStyles.childBody.copyWith(
                      color: AppColors.onLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: onSettings,
                  icon: const Icon(Icons.settings_outlined, color: AppColors.onLight),
                ),
              ),
              Image.asset(
                AppConstants.owlAvatar,
                width: 72,
                height: 72,
                errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.onLight, size: 56),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
