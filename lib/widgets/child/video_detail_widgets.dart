import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/models/video_model.dart';

class VideoDetailGradientBar extends StatelessWidget {
  const VideoDetailGradientBar({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
              'DİL BAHÇESİ',
              textAlign: TextAlign.center,
              style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.onLight, fontSize: 18),
            ),
          ),
          Image.asset(
            AppConstants.owlAvatar,
            width: 36,
            height: 36,
            errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.onLight),
          ),
        ],
      ),
    );
  }
}

class VideoDetailPlayer extends StatelessWidget {
  const VideoDetailPlayer({super.key, required this.video, required this.imageUrl});

  final VideoModel video;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppColors.videoBlack),
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Image.asset(
                video.thumbnailAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: AppColors.videoBlackSoft),
              ),
              errorWidget: (_, __, ___) => Image.asset(
                video.thumbnailAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: AppColors.videoBlackSoft),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.childPrimary.withOpacity(0.95),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded, color: AppColors.onLight, size: 44),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.35,
                    minHeight: 6,
                    backgroundColor: AppColors.scrimWhite24,
                    valueColor: const AlwaysStoppedAnimation(AppColors.childGreen),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
