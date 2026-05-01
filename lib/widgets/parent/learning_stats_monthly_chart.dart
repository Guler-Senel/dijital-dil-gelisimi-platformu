import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

class LearningStatsMonthlyChart extends StatelessWidget {
  const LearningStatsMonthlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();
    final w = s.learningMonthlyWeeks;
    if (w.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Henüz veri yok', style: AppTextStyles.parentCaption.copyWith(color: AppColors.parentTextGray)),
        ),
      );
    }
    final maxY = w.map((e) => e.earned > e.target ? e.earned : e.target).reduce((a, b) => a > b ? a : b) + 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: (w.length - 1).toDouble(),
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (v) => FlLine(color: AppColors.parentBorder.withOpacity(0.6), strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => AppColors.parentCard,
                  tooltipBorder: BorderSide(color: AppColors.parentBorder),
                  getTooltipItems: (spots) {
                    return spots.map((spot) {
                      final i = spot.x.toInt().clamp(0, w.length - 1);
                      final week = w[i];
                      return LineTooltipItem(
                        '${week.label}\nKazanılan: ${week.earned.toStringAsFixed(0)} | Hedef: ${week.target.toStringAsFixed(0)}',
                        AppTextStyles.parentCaption.copyWith(color: AppColors.parentText, fontWeight: FontWeight.w700),
                      );
                    }).toList();
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
                    getTitlesWidget: (v, m) => Text(v.toInt().toString(), style: AppTextStyles.parentSmall),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (v, m) {
                      final i = v.toInt();
                      if (i < 0 || i >= w.length) return const SizedBox.shrink();
                      return Text(w[i].label, style: AppTextStyles.parentSmall);
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(w.length, (i) => FlSpot(i.toDouble(), w[i].earned)),
                  isCurved: true,
                  color: AppColors.parentPrimary,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.parentPrimary.withOpacity(0.08),
                  ),
                ),
                LineChartBarData(
                  spots: List.generate(w.length, (i) => FlSpot(i.toDouble(), w[i].target)),
                  isCurved: true,
                  color: AppColors.parentTextGray,
                  barWidth: 2,
                  dashArray: [6, 4],
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Chip(
            backgroundColor: AppColors.childSecondary.withOpacity(0.25),
            label: Text(
              'Bu ay ${s.totalMonthlyWordsLearned} kelime öğrenildi 🎉',
              style: AppTextStyles.parentCaption.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(width: 14, height: 3, color: AppColors.parentPrimary),
                const SizedBox(width: 6),
                Text('Kazanılan', style: AppTextStyles.parentSmall),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                CustomPaint(
                  size: const Size(14, 3),
                  painter: _DashPainter(color: AppColors.parentTextGray),
                ),
                const SizedBox(width: 6),
                Text('Hedef', style: AppTextStyles.parentSmall),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, size.height / 2), Offset(x + 3, size.height / 2), paint);
      x += 6;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
