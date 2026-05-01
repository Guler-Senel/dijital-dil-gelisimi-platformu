import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/data/mock/stories_mock.dart';

class StoryDetailScreen extends StatelessWidget {
  const StoryDetailScreen({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    final story = storyById(storyId);
    if (story == null) {
      return Scaffold(
        body: Center(child: Text('Hikaye bulunamadı', style: AppTextStyles.childBody)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          story.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.childGreen.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Text(story.title, style: AppTextStyles.childTitleMedium),
                        ),
                        Text(
                          '⏱ ${formatDurationLabel(story.duration)}',
                          style: AppTextStyles.childBodyLight,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(story.summary, style: AppTextStyles.childBodyLight),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.childPrimary,
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () => playWordSoundPrint(story.title),
                      icon: const Icon(Icons.volume_up_rounded, color: AppColors.onLight),
                      label: Text('Hikayeyi Dinle', style: AppTextStyles.childBody.copyWith(color: AppColors.onLight)),
                    ),
                    const SizedBox(height: 20),
                    Text('Hikaye', style: AppTextStyles.childSectionTitle),
                    const SizedBox(height: 8),
                    ...story.paragraphs.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(p, style: AppTextStyles.childBody.copyWith(height: 1.4)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
