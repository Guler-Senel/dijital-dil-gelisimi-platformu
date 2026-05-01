import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';

class ParentLoginNumpad extends StatelessWidget {
  const ParentLoginNumpad({super.key, required this.onDigit, required this.onBackspace});

  final void Function(int) onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    Widget keyCell({String? label, IconData? icon, required VoidCallback onTap}) {
      return Material(
        color: AppColors.parentBackground,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: SizedBox(
            height: 64,
            child: Center(
              child: icon != null
                  ? Icon(icon, color: AppColors.parentPrimary)
                  : Text(
                      label ?? '',
                      style: AppTextStyles.parentHeadline.copyWith(
                        color: AppColors.parentPrimary,
                        fontSize: 26,
                      ),
                    ),
            ),
          ),
        ),
      );
    }

    Widget row(List<Widget> cells) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            for (final w in cells)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: w,
                ),
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          row([
            keyCell(label: '1', onTap: () => onDigit(1)),
            keyCell(label: '2', onTap: () => onDigit(2)),
            keyCell(label: '3', onTap: () => onDigit(3)),
          ]),
          row([
            keyCell(label: '4', onTap: () => onDigit(4)),
            keyCell(label: '5', onTap: () => onDigit(5)),
            keyCell(label: '6', onTap: () => onDigit(6)),
          ]),
          row([
            keyCell(label: '7', onTap: () => onDigit(7)),
            keyCell(label: '8', onTap: () => onDigit(8)),
            keyCell(label: '9', onTap: () => onDigit(9)),
          ]),
          row([
            const SizedBox.shrink(),
            keyCell(label: '0', onTap: () => onDigit(0)),
            keyCell(icon: Icons.backspace_outlined, onTap: onBackspace),
          ]),
        ],
      ),
    );
  }
}
