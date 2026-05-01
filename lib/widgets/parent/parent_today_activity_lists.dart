import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';

class ParentActivityVideoList extends StatelessWidget {
  const ParentActivityVideoList({super.key, required this.state});

  final KidLinguaState state;

  @override
  Widget build(BuildContext context) {
    if (state.todayVideoActivities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: state.todayVideoActivities.map((v) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Text('🎬', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(child: Text(v.title, style: AppTextStyles.parentBody)),
                Text(formatDurationLabel(v.duration), style: AppTextStyles.parentCaption),
                const SizedBox(width: 8),
                Icon(Icons.check_circle, color: AppColors.parentSuccess, size: 22),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ParentActivityStoryList extends StatelessWidget {
  const ParentActivityStoryList({super.key, required this.state});

  final KidLinguaState state;

  @override
  Widget build(BuildContext context) {
    if (state.todayStoryActivities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: state.todayStoryActivities.map((s) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Text('📖', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(child: Text(s.title, style: AppTextStyles.parentBody)),
                Text(s.durationLabel, style: AppTextStyles.parentCaption),
                const SizedBox(width: 8),
                Icon(Icons.check_circle, color: AppColors.parentSuccess, size: 22),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ParentActivityWordsGrid extends StatelessWidget {
  const ParentActivityWordsGrid({super.key, required this.state});

  final KidLinguaState state;

  @override
  Widget build(BuildContext context) {
    if (state.learnedWordsToday.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.learnedWordsToday.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.4,
        ),
        itemBuilder: (context, i) {
          final w = state.learnedWordsToday[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.parentPrimary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  w.word,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.parentBody.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                w.unitName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.parentSmall,
              ),
            ],
          );
        },
      ),
    );
  }
}
