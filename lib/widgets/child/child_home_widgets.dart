import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/models/video_model.dart';
import 'package:kidlingua/widgets/child/video_card_widget.dart';

class ChildHomeSectionTitleRow extends StatelessWidget {
  const ChildHomeSectionTitleRow({super.key, required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.childSectionTitle)),
        TextButton(
          onPressed: onSeeAll,
          child: Text('Tümünü Gör', style: AppTextStyles.childLink),
        ),
      ],
    );
  }
}

class ChildHomeUnitsBanner extends StatelessWidget {
  const ChildHomeUnitsBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [AppColors.childPrimary, AppColors.childSecondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Üniteleri Keşfet →',
                  style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.onLight, fontSize: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  'Yeni maceralar seni bekliyor!',
                  style: AppTextStyles.childBodyLight.copyWith(color: AppColors.onLight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChildHomeVideoTile extends StatelessWidget {
  const ChildHomeVideoTile({super.key, required this.video, required this.onTap});

  final VideoModel video;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VideoCardWidget(
      video: video,
      thumbnailHeight: 110,
      showCategory: false,
      onTap: onTap,
    );
  }
}

class ChildBottomNavPill extends StatelessWidget {
  const ChildBottomNavPill({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.childPrimary.withOpacity(0.18) : AppColors.childCardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? AppColors.childPrimary : AppColors.childTextLight),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.childBody.copyWith(
                  color: selected ? AppColors.childPrimary : AppColors.childTextLight,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
