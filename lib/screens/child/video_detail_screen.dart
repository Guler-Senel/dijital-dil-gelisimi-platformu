import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/data/mock/videos_mock.dart';
import 'package:kidlingua/widgets/child/video_card_widget.dart';
import 'package:kidlingua/widgets/child/video_detail_widgets.dart';

class VideoDetailScreen extends StatelessWidget {
  const VideoDetailScreen({super.key, required this.videoId});

  final String videoId;

  static const String _placeholderImageUrl =
      'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&q=80';

  @override
  Widget build(BuildContext context) {
    final video = videoById(videoId);
    if (video == null) {
      return Scaffold(
        body: Center(child: Text('Video bulunamadı', style: AppTextStyles.childBody)),
      );
    }
    final others = videosMock.where((v) => v.id != video.id).take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            VideoDetailGradientBar(onBack: () => context.pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VideoDetailPlayer(video: video, imageUrl: _placeholderImageUrl),
                    const SizedBox(height: 14),
                    Text(
                      video.title,
                      style: AppTextStyles.childTitleMedium.copyWith(color: AppColors.childPrimary),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.parentCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.childTextLight.withOpacity(0.15)),
                      ),
                      child: Text(video.description, style: AppTextStyles.childBodyLight),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.childSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Favorilere eklendi.')),
                              );
                            },
                            child: Text(
                              '⭐ Favorilere Ekle',
                              style: AppTextStyles.childBody.copyWith(color: AppColors.childText),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 52,
                          height: 52,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: AppColors.parentCard,
                              foregroundColor: AppColors.childText,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: AppColors.childTextLight.withOpacity(0.2)),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Paylaşım yakında.')),
                              );
                            },
                            child: const Icon(Icons.share_rounded),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Sıradaki Videolar', style: AppTextStyles.childSectionTitle),
                        ),
                        TextButton(
                          onPressed: () => context.push('/videos'),
                          child: Text('Hepsini Gör', style: AppTextStyles.childLink),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...others.map(
                      (v) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: VideoCardWidget(
                          video: v,
                          compact: true,
                          onTap: () => context.pushReplacement('/video/${v.id}'),
                        ),
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
