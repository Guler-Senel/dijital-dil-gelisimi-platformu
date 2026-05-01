import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';

class StatCardWidget extends StatelessWidget {
  const StatCardWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.parentCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.parentBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.parentText.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class StatHeaderRow extends StatelessWidget {
  const StatHeaderRow({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: AppTextStyles.parentTitle),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
