import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/models/unit_model.dart';

class UnitCardWidget extends StatelessWidget {
  const UnitCardWidget({
    super.key,
    required this.unit,
    required this.onTap,
    this.compact = false,
  });

  final UnitModel unit;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final p = (unit.progressPercent.clamp(0, 100)) / 100.0;
    return Material(
      color: AppColors.childCardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: compact ? 22 : 26,
                    backgroundColor: unit.accentColor.withOpacity(0.25),
                    child: Icon(unit.icon, color: unit.accentColor, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unit.title,
                          style: AppTextStyles.childBody.copyWith(fontSize: 17),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: p,
                            minHeight: 8,
                            backgroundColor: AppColors.childTextLight.withOpacity(0.15),
                            valueColor: const AlwaysStoppedAnimation(AppColors.childGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${unit.progressPercent}%',
                    style: AppTextStyles.childBody.copyWith(
                      color: AppColors.childGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            if (unit.isCompleted)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.scrimBlack12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check_circle, color: AppColors.childGreen, size: 40),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
