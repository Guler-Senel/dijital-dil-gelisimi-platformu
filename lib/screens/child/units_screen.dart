import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/data/mock/units_mock.dart';
import 'package:kidlingua/models/unit_model.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.childPrimary, AppColors.childSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onLight),
                  ),
                  Expanded(
                    child: Text(
                      'ÜNİTELER',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.onLight, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      AppConstants.owlAvatar,
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) => const Icon(Icons.psychology, color: AppColors.onLight),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: unitsMock.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) => _UnitListCard(unit: unitsMock[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitListCard extends StatelessWidget {
  const _UnitListCard({required this.unit});

  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    final p = unit.progressPercent / 100.0;
    return Material(
      color: AppColors.childCardBg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.push('/unit/${unit.id}'),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: unit.accentColor.withOpacity(0.25),
                    child: Icon(unit.icon, color: unit.accentColor, size: 34),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(unit.title, style: AppTextStyles.childBody.copyWith(fontSize: 18)),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: p,
                            minHeight: 10,
                            backgroundColor: AppColors.childTextLight.withOpacity(0.12),
                            valueColor: const AlwaysStoppedAnimation(AppColors.childGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 14,
              top: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: unit.isCompleted ? AppColors.childGreen : AppColors.parentCard,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: AppColors.scrimBlack06, blurRadius: 8),
                  ],
                ),
                child: Text(
                  unit.isCompleted ? '✓' : '%${unit.progressPercent}',
                  style: AppTextStyles.childBody.copyWith(
                    color: unit.isCompleted ? AppColors.onLight : AppColors.childText,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            if (unit.isCompleted)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.scrimBlack10,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check_circle, color: AppColors.childGreen, size: 44),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
