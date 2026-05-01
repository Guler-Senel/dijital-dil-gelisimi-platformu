import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';

class UnitCompleteScreen extends StatelessWidget {
  const UnitCompleteScreen({
    super.key,
    required this.unitTitle,
    required this.pointsEarned,
    required this.elapsed,
  });

  final String unitTitle;
  final int pointsEarned;
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _DotsPatternPainter()),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const _Star(offset: Offset(-120, -30), filled: false),
                      const _Star(offset: Offset(110, -40), filled: true),
                      const _Star(offset: Offset(-90, 90), filled: true),
                      const _Star(offset: Offset(100, 80), filled: false),
                      Image.asset(
                        AppConstants.owlGraduate,
                        height: 140,
                        errorBuilder: (_, __, ___) => const Icon(Icons.school_rounded, size: 100, color: AppColors.childPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('🏆', style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 8),
                  Text(
                    'Tebrikler! 🎉',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.childTitleLarge.copyWith(color: AppColors.childPrimary, fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$unitTitle Tamamlandı!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.childBody.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.parentCard,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.childText.withOpacity(0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'PUAN +$pointsEarned',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.childPrimary),
                          ),
                        ),
                        Container(width: 1, height: 42, color: AppColors.childTextLight.withOpacity(0.2)),
                        Expanded(
                          child: Text(
                            'SÜRE ${formatClock(elapsed)}',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.childSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.childPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => context.go('/'),
                      child: Text(
                        'Ana Sayfaya Dön',
                        style: AppTextStyles.childBody.copyWith(color: AppColors.onLight, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({required this.offset, required this.filled});

  final Offset offset;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Text(
        filled ? '★' : '☆',
        style: TextStyle(
          fontSize: filled ? 28 : 22,
          color: filled ? AppColors.childSecondary : AppColors.childPink,
        ),
      ),
    );
  }
}

class _DotsPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.childSecondary.withOpacity(0.12);
    const step = 22.0;
    for (double y = 0; y < size.height; y += step) {
      for (double x = 0; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
