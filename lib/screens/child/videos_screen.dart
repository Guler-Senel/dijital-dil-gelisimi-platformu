import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/data/mock/videos_mock.dart';
import 'package:kidlingua/models/video_model.dart';
import 'package:kidlingua/widgets/child/video_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  VideoCategory filter = VideoCategory.all;

  @override
  Widget build(BuildContext context) {
    final coins = context.watch<KidLinguaState>().coins;
    final list = videosFiltered(filter);

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onLight),
                  ),
                  Expanded(
                    child: Text(
                      'DİL BAHÇESİ',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.onLight, fontSize: 18),
                    ),
                  ),
                  Chip(
                    backgroundColor: AppColors.onLight.withOpacity(0.2),
                    label: Text('🪙 $coins', style: AppTextStyles.childBody.copyWith(color: AppColors.onLight)),
                  ),
                  Image.asset(
                    AppConstants.owlAvatar,
                    width: 36,
                    height: 36,
                    errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.onLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _FilterChip(
                    label: 'Hepsi',
                    selected: filter == VideoCategory.all,
                    onTap: () => setState(() => filter = VideoCategory.all),
                  ),
                  _FilterChip(
                    label: 'Şarkılar',
                    selected: filter == VideoCategory.songs,
                    onTap: () => setState(() => filter = VideoCategory.songs),
                  ),
                  _FilterChip(
                    label: 'Çizgi Film',
                    selected: filter == VideoCategory.cartoon,
                    onTap: () => setState(() => filter = VideoCategory.cartoon),
                  ),
                  _FilterChip(
                    label: 'Dersler',
                    selected: filter == VideoCategory.lessons,
                    onTap: () => setState(() => filter = VideoCategory.lessons),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, i) {
                  final v = list[i];
                  return VideoCardWidget(
                    video: v,
                    onTap: () => context.push('/video/${v.id}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: selected ? AppColors.childPrimary : AppColors.parentCard,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              label,
              style: AppTextStyles.childBody.copyWith(
                color: selected ? AppColors.onLight : AppColors.childText,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
