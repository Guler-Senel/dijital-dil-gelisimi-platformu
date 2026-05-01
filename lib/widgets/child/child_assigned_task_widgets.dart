import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/models/parent_assigned_task_model.dart';

class ChildAssignedTasksEmpty extends StatelessWidget {
  const ChildAssignedTasksEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.childCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.childTextLight.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Image.asset(
            AppConstants.owlAvatar,
            height: 56,
            errorBuilder: (_, __, ___) => const Icon(Icons.psychology, size: 48, color: AppColors.childPurple),
          ),
          const SizedBox(height: 10),
          Text('Henüz görev atanmadı', style: AppTextStyles.childBodyLight),
        ],
      ),
    );
  }
}

class ChildAssignedTaskCard extends StatelessWidget {
  const ChildAssignedTaskCard({
    super.key,
    required this.task,
    required this.onStart,
  });

  final ParentAssignedTask task;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.childCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.childText.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(task.iconEmoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: AppTextStyles.childBody.copyWith(fontWeight: FontWeight.w800, color: AppColors.childText),
                ),
                const SizedBox(height: 2),
                Text(
                  'Ebeveyn tarafından atandı',
                  style: AppTextStyles.childBodyLight.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          if (task.completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.childGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '✓ Tamamlandı',
                style: AppTextStyles.childBody.copyWith(
                  color: AppColors.onLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.childPrimary,
                foregroundColor: AppColors.onLight,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onStart,
              child: Text('Başla', style: AppTextStyles.childBody.copyWith(color: AppColors.onLight, fontSize: 13)),
            ),
        ],
      ),
    );
  }

  static void navigateForTask(BuildContext context, ParentAssignedTask task) {
    switch (task.kind) {
      case ParentAssignedTaskKind.unit:
        if (task.unitId != null) context.push('/unit/${task.unitId}');
        break;
      case ParentAssignedTaskKind.video:
        if (task.videoId != null) context.push('/video/${task.videoId}');
        break;
      case ParentAssignedTaskKind.story:
        if (task.storyId != null) context.push('/story/${task.storyId}');
        break;
    }
  }
}
