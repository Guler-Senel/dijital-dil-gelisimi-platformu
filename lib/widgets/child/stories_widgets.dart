import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/models/story_model.dart';

class StoryListAppBar extends StatelessWidget {
  const StoryListAppBar({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.childText),
          ),
          Expanded(
            child: Text(
              'DİL BAHÇESİ',
              textAlign: TextAlign.center,
              style: AppTextStyles.childSectionTitle.copyWith(fontSize: 18),
            ),
          ),
          Image.asset(
            AppConstants.owlAvatar,
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.childPurple),
          ),
        ],
      ),
    );
  }
}

class StoryListRow extends StatelessWidget {
  const StoryListRow({super.key, required this.story});

  final StoryModel story;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.childCardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/story/${story.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                height: 180,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      story.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.childGreen, AppColors.childBlue],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: story.isCompleted ? AppColors.childGreen : AppColors.childSecondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          story.isCompleted ? '✓ TAMAMLANDI' : 'YENİ',
                          style: AppTextStyles.childBody.copyWith(
                            color: AppColors.childText,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: AppTextStyles.childSectionTitle.copyWith(
                            color: AppColors.childPrimary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '⏱ ${formatDurationLabel(story.duration)}',
                          style: AppTextStyles.childBodyLight,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: story.isCompleted ? AppColors.childGreen : AppColors.childPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => context.push('/story/${story.id}'),
                      icon: Icon(
                        story.isCompleted ? Icons.replay_rounded : Icons.play_arrow_rounded,
                        color: AppColors.onLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryOwlTipBox extends StatelessWidget {
  const StoryOwlTipBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.childSecondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.childSecondary.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Image.asset(
            AppConstants.owlAvatar,
            width: 48,
            height: 48,
            errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.childPurple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Günde bir hikaye okuyarak yeni kelimeler öğrenebilirsin!',
              style: AppTextStyles.childBodyLight,
            ),
          ),
        ],
      ),
    );
  }
}
