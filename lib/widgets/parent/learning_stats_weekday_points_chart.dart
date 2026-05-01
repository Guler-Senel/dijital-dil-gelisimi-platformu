import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

class LearningStatsWeekdayPointsChart extends StatelessWidget {
  const LearningStatsWeekdayPointsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();
    final bars = s.learningWeekdayBars;
    if (bars.isEmpty) {
      return const SizedBox.shrink();
    }
    final maxY = bars.map((b) => b.earnedPoints > b.targetPoints ? b.earnedPoints : b.targetPoints).reduce((a, b) => a > b ? a : b) + 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Haftalık puan (Pzt–Cum)', style: AppTextStyles.parentCaption.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              alignment: BarChartAlignment.spaceAround,
              groupsSpace: 6,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (v) => FlLine(color: AppColors.parentBorder.withOpacity(0.55), strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => AppColors.parentCard,
                  tooltipBorder: BorderSide(color: AppColors.parentBorder),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final i = group.x.toInt();
                    if (i < 0 || i >= bars.length) return null;
                    final b = bars[i];
                    if (rodIndex == 0) {
                      return BarTooltipItem(
                        '${b.dayLabel}: ${b.earnedPoints} puan kazanıldı',
                        AppTextStyles.parentCaption.copyWith(color: AppColors.parentText, fontWeight: FontWeight.w700),
                      );
                    }
                    return BarTooltipItem(
                      'Hedef: ${b.targetPoints} puan',
                      AppTextStyles.parentSmall.copyWith(color: AppColors.parentTextGray),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= bars.length) return const SizedBox.shrink();
                      return Text(
                        '${bars[i].earnedPoints}',
                        style: AppTextStyles.parentSmall.copyWith(fontWeight: FontWeight.w800, fontSize: 10),
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
                    reservedSize: 22,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= bars.length) return const SizedBox.shrink();
                      return Text(bars[i].dayLabel, style: AppTextStyles.parentSmall);
                    },
                  ),
                ),
              ),
              barGroups: List.generate(
                bars.length,
                (i) {
                  final b = bars[i];
                  return BarChartGroupData(
                    x: i,
                    barsSpace: 3,
                    barRods: [
                      BarChartRodData(
                        toY: b.earnedPoints.toDouble(),
                        width: 9,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        color: AppColors.parentPrimary,
                      ),
                      BarChartRodData(
                        toY: b.targetPoints.toDouble(),
                        width: 9,
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
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dot(AppColors.parentPrimary, 'Kazanılan'),
            const SizedBox(width: 14),
            _dot(AppColors.parentBorder, 'Hedeflenen'),
          ],
        ),
      ],
    );
  }

  Widget _dot(Color c, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.parentSmall),
      ],
    );
  }
}
