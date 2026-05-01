import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/parent_today_activity_lists.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';
import 'package:provider/provider.dart';

class ParentTodayActivitiesCard extends StatefulWidget {
  const ParentTodayActivitiesCard({super.key});

  @override
  State<ParentTodayActivitiesCard> createState() => _ParentTodayActivitiesCardState();
}

class _ParentTodayActivitiesCardState extends State<ParentTodayActivitiesCard> {
  String? _expanded;

  void _toggle(String key) {
    setState(() => _expanded = _expanded == key ? null : key);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<KidLinguaState>();

    return StatCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatHeaderRow(
            title: 'Bugünkü Aktiviteler',
            trailing: Icon(Icons.schedule_rounded, color: AppColors.parentPrimary),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(
                label: '📹 ${state.todayVideoActivities.length} Video',
                selected: _expanded == 'videos',
                onTap: () => _toggle('videos'),
              ),
              _chip(
                label: '📖 ${state.todayStoryActivities.length} Hikaye',
                selected: _expanded == 'stories',
                onTap: () => _toggle('stories'),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded == 'videos'
                ? ParentActivityVideoList(state: state)
                : _expanded == 'stories'
                    ? ParentActivityStoryList(state: state)
                    : const SizedBox.shrink(),
          ),
          const Divider(height: 22),
          InkWell(
            onTap: () => _toggle('words'),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text('ÖĞRENİLEN KELİMELER', style: AppTextStyles.parentSmall),
                  const Spacer(),
                  Icon(
                    _expanded == 'words' ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.parentTextGray,
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded == 'words' ? ParentActivityWordsGrid(state: state) : const SizedBox.shrink(),
          ),
          if (_expanded != 'words')
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.learnedWordsToday
                    .map(
                      (w) => Chip(
                        backgroundColor: AppColors.parentPrimary.withOpacity(0.12),
                        label: Text(w.word, style: AppTextStyles.parentCaption),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _chip({required String label, required bool selected, required VoidCallback onTap}) {
    return Material(
      color: selected ? AppColors.parentPrimary.withOpacity(0.2) : AppColors.parentPrimary,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            label,
            style: AppTextStyles.parentCaption.copyWith(
              color: selected ? AppColors.parentPrimary : AppColors.onLight,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
