import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/models/word_model.dart';

class WordCardWidget extends StatelessWidget {
  const WordCardWidget({
    super.key,
    required this.word,
    required this.backgroundColor,
    this.width = 160,
    this.height = 220,
    this.onTapSound,
  });

  final WordModel word;
  final Color backgroundColor;
  final double width;
  final double height;
  final VoidCallback? onTapSound;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.childText.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  word.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.childCardBg,
                    alignment: Alignment.center,
                    child: Text(
                      word.categoryEmoji,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              word.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.childTitleMedium.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Material(
              color: AppColors.childPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTapSound ??
                    () {
                      playWordSoundPrint(word.name);
                    },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.volume_up_rounded, color: AppColors.onLight),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
