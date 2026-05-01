import 'package:flutter/material.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';

class ParentDashboardHeader extends StatelessWidget {
  const ParentDashboardHeader({super.key, required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.childPrimary, AppColors.childSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Row(
        children: [
          Image.asset(
            AppConstants.owlAvatar,
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.parentCard),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'KİDLİNGUA',
              style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.parentCard, fontSize: 20),
            ),
          ),
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings_outlined, color: AppColors.parentCard),
          ),
        ],
      ),
    );
  }
}
