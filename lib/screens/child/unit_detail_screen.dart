import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/data/mock/units_mock.dart';
import 'package:kidlingua/data/mock/words_mock.dart';
import 'package:kidlingua/navigation/app_router.dart';
import 'package:kidlingua/widgets/child/unit_detail_widgets.dart';

class UnitDetailScreen extends StatefulWidget {
  const UnitDetailScreen({super.key, required this.unitId});

  final String unitId;

  @override
  State<UnitDetailScreen> createState() => _UnitDetailScreenState();
}

class _UnitDetailScreenState extends State<UnitDetailScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final unit = unitById(widget.unitId);
    if (unit == null) {
      return Scaffold(
        body: Center(child: Text('Ünite bulunamadı', style: AppTextStyles.childBody)),
      );
    }
    final words = wordsForIds(unit.wordIds);
    if (words.isEmpty) {
      return Scaffold(
        body: Center(child: Text('Kelime bulunamadı', style: AppTextStyles.childBody)),
      );
    }
    final total = words.length;
    final word = words[currentIndex.clamp(0, total - 1)];
    final progress = (currentIndex + 1) / total;

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            UnitDetailHeader(onBack: () => context.pop(), progress: progress),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    UnitWordStudyCard(word: word),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.childGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          if (currentIndex >= total - 1) {
                            context.push(
                              '/unit-complete',
                              extra: UnitCompleteArgs(
                                unitTitle: '${unit.title} Ünitesi',
                                pointsEarned: 150,
                                elapsed: const Duration(minutes: 8, seconds: 12),
                              ),
                            );
                          } else {
                            setState(() => currentIndex++);
                          }
                        },
                        child: Text(
                          '✓ Onayla',
                          style: AppTextStyles.childBody.copyWith(
                            color: AppColors.onLight,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        total,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == currentIndex ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i <= currentIndex
                                ? AppColors.childPrimary
                                : AppColors.childTextLight.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
