import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/models/video_model.dart';

class VideoCardWidget extends StatelessWidget {
  const VideoCardWidget({
    super.key,
    required this.video,
    required this.onTap,
    this.thumbnailHeight = 200,
    this.showCategory = true,
    this.compact = false,
  });

  final VideoModel video;
  final VoidCallback onTap;
  final double thumbnailHeight;
  final bool showCategory;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Material(
        color: AppColors.childCardBg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 96,
                  height: 64,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        video.thumbnailAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: AppColors.childBlue.withOpacity(0.3)),
                      ),
                      const Center(
                        child: Icon(Icons.play_circle_fill, color: AppColors.onLight, size: 32),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.childBody.copyWith(fontSize: 14),
                    ),
                    Text(
                      formatDurationLabel(video.duration),
                      style: AppTextStyles.childBodyLight.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      color: AppColors.fullTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: thumbnailHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      video.thumbnailAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.childSecondary.withOpacity(0.35),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.childPrimary.withOpacity(0.92),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.scrimBlack20,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.play_arrow_rounded, color: AppColors.onLight, size: 40),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.scrimBlack55,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          formatDurationLabel(video.duration),
                          style: AppTextStyles.childBody.copyWith(
                            color: AppColors.onLight,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              video.title,
              style: AppTextStyles.childBody.copyWith(fontWeight: FontWeight.w800),
            ),
            if (showCategory)
              Text(
                video.categoryLabel,
                style: AppTextStyles.childLink.copyWith(fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
