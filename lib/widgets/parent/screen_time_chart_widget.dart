import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';

class ScreenTimeChartWidget extends StatelessWidget {
  const ScreenTimeChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StatCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatHeaderRow(
            title: 'Ekran Süresi',
            trailing: Icon(Icons.schedule_rounded, color: AppColors.parentPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            '47 dk',
            style: AppTextStyles.parentHeadline.copyWith(color: AppColors.parentPrimary),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(
                  flex: 47,
                  child: Container(height: 14, color: AppColors.parentPrimary),
                ),
                Expanded(
                  flex: 30,
                  child: Container(height: 14, color: AppColors.childBlue),
                ),
                Expanded(
                  flex: 23,
                  child: Container(height: 14, color: AppColors.parentTextGray.withOpacity(0.35)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (v, m) {
                        const labels = ['EĞİTİM', 'OYUN', 'DİĞER'];
                        final i = v.toInt();
                        if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(labels[i], style: AppTextStyles.parentSmall),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 22,
                        width: 18,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        color: AppColors.parentPrimary,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 15,
                        width: 18,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        color: AppColors.childBlue,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 10,
                        width: 18,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        color: AppColors.parentTextGray.withOpacity(0.45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
