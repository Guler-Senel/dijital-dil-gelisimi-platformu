import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/models/story_model.dart';

class StoryCardWidget extends StatelessWidget {
  const StoryCardWidget({
    super.key,
    required this.story,
    required this.onTap,
    this.height = 180,
    this.fullWidth = true,
  });

  final StoryModel story;
  final VoidCallback onTap;
  final double height;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fullTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              SizedBox(
                height: height,
                width: fullWidth ? double.infinity : 160,
                child: Image.asset(
                  story.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.childGreen, AppColors.childBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              if (story.isCompleted)
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.childGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '✓ TAMAMLANDI',
                      style: AppTextStyles.childBody.copyWith(
                        color: AppColors.onLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.scrimBlack65,
                        AppColors.fullTransparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.title,
                              style: AppTextStyles.childSectionTitle.copyWith(
                                color: AppColors.onLight,
                              ),
                            ),
                            Text(
                              '⏱ ${formatDurationLabel(story.duration)}',
                              style: AppTextStyles.childBodyLight.copyWith(
                                color: AppColors.onLight.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.childPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: onTap,
                          icon: const Icon(Icons.play_arrow_rounded, color: AppColors.onLight),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
