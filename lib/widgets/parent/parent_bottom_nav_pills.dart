import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';

class ParentBottomNavPills extends StatelessWidget {
  const ParentBottomNavPills({
    super.key,
    required this.navIndex,
    required this.onChild,
    required this.onParent,
  });

  final int navIndex;
  final VoidCallback onChild;
  final VoidCallback onParent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: _NavPill(
                label: 'Çocuk',
                icon: Icons.wb_sunny_rounded,
                selected: navIndex == 0,
                activeColor: AppColors.childPrimary,
                onTap: onChild,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NavPill(
                label: 'Ebeveyn',
                icon: Icons.shield_outlined,
                selected: navIndex == 1,
                activeColor: AppColors.childPrimary,
                onTap: onParent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? activeColor.withOpacity(0.18) : AppColors.parentCard,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? activeColor : AppColors.parentTextGray),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.parentBody.copyWith(
                  color: selected ? activeColor : AppColors.parentTextGray,
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
