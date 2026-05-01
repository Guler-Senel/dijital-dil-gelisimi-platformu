import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

class LearningStatsWeeklyChart extends StatelessWidget {
  const LearningStatsWeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();
    final days = s.learningWeeklyDays;
    if (days.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
        ),
      );
    }
    final maxWords = days.map((d) => d.wordsLearned > d.targetWords ? d.wordsLearned : d.targetWords).reduce((a, b) => a > b ? a : b);
    final maxY = (maxWords + 2).toDouble();
    final maxIdx = days.indexWhere(
      (d) => d.wordsLearned == days.map((x) => x.wordsLearned).reduce((a, b) => a > b ? a : b),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              alignment: BarChartAlignment.spaceAround,
              groupsSpace: 8,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (v) => FlLine(color: AppColors.parentBorder.withOpacity(0.6), strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => AppColors.parentCard,
                  tooltipBorder: BorderSide(color: AppColors.parentBorder),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final i = group.x.toInt();
                    if (i < 0 || i >= days.length) return null;
                    final d = days[i];
                    if (rodIndex == 0) {
                      return BarTooltipItem(
                        '${d.dayLabel}: ${d.wordsLearned} kelime öğrenildi',
                        AppTextStyles.parentCaption.copyWith(color: AppColors.parentText, fontWeight: FontWeight.w700),
                      );
                    }
                    return BarTooltipItem(
                      'Hedef: ${d.targetWords} kelime',
                      AppTextStyles.parentSmall.copyWith(color: AppColors.parentTextGray),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 26,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= days.length) return const SizedBox.shrink();
                      final d = days[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '${d.wordsLearned}\n${d.targetWords}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.parentSmall.copyWith(fontWeight: FontWeight.w800, fontSize: 9),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (v, m) => Text(v.toInt().toString(), style: AppTextStyles.parentSmall),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= days.length) return const SizedBox.shrink();
                      return Text(days[i].dayLabel, style: AppTextStyles.parentSmall);
                    },
                  ),
                ),
              ),
              barGroups: List.generate(
                days.length,
                (i) {
                  final d = days[i];
                  final highlight = i == maxIdx;
                  return BarChartGroupData(
                    x: i,
                    barsSpace: 4,
                    barRods: [
                      BarChartRodData(
                        toY: d.wordsLearned.toDouble(),
                        width: 10,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        color: highlight ? AppColors.childSecondary : AppColors.parentPrimary,
                      ),
                      BarChartRodData(
                        toY: d.targetWords.toDouble(),
                        width: 10,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        color: AppColors.parentBorder,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Chip(
            backgroundColor: AppColors.parentPrimary.withOpacity(0.12),
            label: Text(
              'Bu hafta ${s.totalWeeklyWordsLearned} kelime öğrenildi',
              style: AppTextStyles.parentCaption.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _leg(AppColors.parentPrimary, 'Kelime'),
            const SizedBox(width: 12),
            _leg(AppColors.childSecondary, 'En yüksek gün'),
            const SizedBox(width: 12),
            _leg(AppColors.parentBorder, 'Hedef'),
          ],
        ),
      ],
    );
  }

  Widget _leg(Color c, String t) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(t, style: AppTextStyles.parentSmall),
      ],
    );
  }
}
