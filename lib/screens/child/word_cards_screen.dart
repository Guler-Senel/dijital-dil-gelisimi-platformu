import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/data/mock/words_mock.dart';
import 'package:provider/provider.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';

class WordCardsScreen extends StatelessWidget {
  const WordCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coins = context.watch<KidLinguaState>().coins;

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      'KELİMELERİM',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.childSectionTitle.copyWith(
                        color: AppColors.onLight,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: AppColors.onLight.withOpacity(0.2),
                    label: Text(
                      '🪙 $coins',
                      style: AppTextStyles.childBody.copyWith(color: AppColors.onLight),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.childSecondary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.childSecondary,
                      child: const Icon(Icons.wb_sunny_outlined, color: AppColors.childText),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Günün Kelimeleri', style: AppTextStyles.childSectionTitle),
                          Text(
                            'Bugün 5 yeni kelime öğreniyoruz!',
                            style: AppTextStyles.childBodyLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: wordsMock.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) {
                  final w = wordsMock[i];
                  final bg = pastelBackgroundAt(i);
                  return Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.childText.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      w.imageAsset,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 150,
                                        height: 150,
                                        color: AppColors.childCardBg,
                                        alignment: Alignment.center,
                                        child: Text(w.categoryEmoji, style: const TextStyle(fontSize: 48)),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(w.name, style: AppTextStyles.childWordDisplay.copyWith(fontSize: 28)),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.childPrimary,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  onPressed: () => playWordSoundPrint(w.name),
                                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.onLight),
                                  label: Text(
                                    '🔊 DİNLE',
                                    style: AppTextStyles.childBody.copyWith(color: AppColors.onLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 18,
                          top: 18,
                          child: Text(w.categoryEmoji, style: const TextStyle(fontSize: 28)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
