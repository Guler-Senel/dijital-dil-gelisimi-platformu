import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

class LearningStatsDailyChart extends StatelessWidget {
  const LearningStatsDailyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();
    final slots = s.learningHourlySlots;
    if (slots.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
        ),
      );
    }
    final maxY = slots.map((e) => e.points).reduce((a, b) => a > b ? a : b) + 6;
    final best = s.mostActiveHourlySlot;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toplam: ${s.totalDailyPoints} puan | En aktif: ${best?.label ?? '-'}',
          style: AppTextStyles.parentCaption.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY > 20 ? 5 : 2,
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
                    if (i < 0 || i >= slots.length) return null;
                    final slot = slots[i];
                    return BarTooltipItem(
                      '${slot.label}: ${slot.points.toStringAsFixed(0)} puan kazanıldı',
                      AppTextStyles.parentCaption.copyWith(color: AppColors.parentText, fontWeight: FontWeight.w700),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: (v, m) => Text(
                      v.toInt().toString(),
                      style: AppTextStyles.parentSmall,
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= slots.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          slots[i].label.replaceAll('-', '\n'),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.parentSmall.copyWith(fontSize: 9),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(
                slots.length,
                (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: slots[i].points,
                      width: 18,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      color: AppColors.parentPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
