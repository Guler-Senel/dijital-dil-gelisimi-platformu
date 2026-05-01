import 'package:flutter/material.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/models/word_model.dart';

class UnitDetailHeader extends StatelessWidget {
  const UnitDetailHeader({super.key, required this.onBack, required this.progress});

  final VoidCallback onBack;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.childPrimary, AppColors.childSecondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onLight),
              ),
              Expanded(
                child: Text(
                  'KidLingua 🐾',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.onLight),
                ),
              ),
              Image.asset(
                AppConstants.owlAvatar,
                width: 40,
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.onLight),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.childTextLight.withOpacity(0.15),
              valueColor: const AlwaysStoppedAnimation(AppColors.childGreen),
            ),
          ),
        ),
      ],
    );
  }
}

class UnitWordStudyCard extends StatelessWidget {
  const UnitWordStudyCard({super.key, required this.word});

  final WordModel word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.childCardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.childText.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      word.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.childBackground,
                        alignment: Alignment.center,
                        child: Text(word.categoryEmoji, style: const TextStyle(fontSize: 72)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(word.name, style: AppTextStyles.childWordDisplay),
                const SizedBox(height: 8),
                Text(word.syllables, style: AppTextStyles.childBodyLight),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.childPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => playWordSoundPrint(word.name),
                    child: const Icon(Icons.volume_up_rounded, color: AppColors.onLight, size: 28),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Icon(Icons.visibility_rounded, color: AppColors.childPurple.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
