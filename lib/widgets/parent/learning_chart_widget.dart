import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/learning_stats_daily_chart.dart';
import 'package:kidlingua/widgets/parent/learning_stats_monthly_chart.dart';
import 'package:kidlingua/widgets/parent/learning_stats_weekday_points_chart.dart';
import 'package:kidlingua/widgets/parent/learning_stats_weekly_chart.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';
import 'package:provider/provider.dart';

class LearningChartWidget extends StatefulWidget {
  const LearningChartWidget({super.key});

  @override
  State<LearningChartWidget> createState() => _LearningChartWidgetState();
}

class _LearningChartWidgetState extends State<LearningChartWidget> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();

    if (s.learningStatsEmpty) {
      return StatCardWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text('Henüz veri yok', style: AppTextStyles.parentBody.copyWith(color: AppColors.parentTextGray)),
          ),
        ),
      );
    }

    return StatCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Öğrenme İstatistikleri', style: AppTextStyles.parentTitle),
          const SizedBox(height: 12),
          const LearningStatsWeekdayPointsChart(),
          const SizedBox(height: 14),
          Row(
            children: [
              _TabChip(
                label: 'Günlük',
                selected: tab == 0,
                onTap: () => setState(() => tab = 0),
              ),
              const SizedBox(width: 8),
              _TabChip(
                label: 'Haftalık',
                selected: tab == 1,
                onTap: () => setState(() => tab = 1),
              ),
              const SizedBox(width: 8),
              _TabChip(
                label: 'Aylık',
                selected: tab == 2,
                onTap: () => setState(() => tab = 2),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: KeyedSubtree(
              key: ValueKey<int>(tab),
              child: switch (tab) {
                0 => const LearningStatsDailyChart(),
                1 => const LearningStatsWeeklyChart(),
                _ => const LearningStatsMonthlyChart(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? AppColors.parentPrimary.withOpacity(0.12) : AppColors.parentBackground,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.parentCaption.copyWith(
                color: selected ? AppColors.parentPrimary : AppColors.parentTextGray,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
