import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/parent_login_numpad.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> with SingleTickerProviderStateMixin {
  final List<int> enteredPin = [];
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;
  bool _pinError = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onDigit(int d) {
    if (enteredPin.length >= 4) return;
    setState(() => enteredPin.add(d));
    if (enteredPin.length == 4) {
      final pin = enteredPin.join();
      final ok = context.read<KidLinguaState>().validatePin(pin);
      if (ok) {
        context.go('/parent-dashboard');
      } else {
        setState(() => _pinError = true);
        _shakeController.forward(from: 0).whenComplete(() {
          if (mounted) setState(() => _pinError = false);
        });
        setState(() => enteredPin.clear());
      }
    }
  }

  void _backspace() {
    if (enteredPin.isEmpty) return;
    setState(() => enteredPin.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.parentCard,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.eco_rounded, color: AppColors.parentPrimary, size: 28),
                  const SizedBox(width: 8),
                  Text('KidLingua', style: AppTextStyles.parentHeadline.copyWith(color: AppColors.parentPrimary)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.close_rounded, color: AppColors.parentText),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 72),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.parentPrimary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.lock_open_rounded, size: 40, color: AppColors.parentPrimary),
                ),
                const SizedBox(height: 18),
                Text('Ebeveyn Girişi', style: AppTextStyles.parentHeadline),
                const SizedBox(height: 8),
                Text(
                  'Devam etmek için şifrenizi girin',
                  style: AppTextStyles.parentCaption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                AnimatedBuilder(
                  animation: _shakeAnim,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnim.value, 0),
                      child: child,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (i) {
                      final filled = i < enteredPin.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filled ? AppColors.parentPrimary : AppColors.parentBorder,
                          border: Border.all(
                            color: _pinError ? AppColors.parentError : AppColors.parentBorder,
                            width: _pinError ? 2 : 1,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 28),
                ParentLoginNumpad(onDigit: _onDigit, onBackspace: _backspace),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: Text('İptal', style: AppTextStyles.parentBody.copyWith(color: AppColors.parentTextGray)),
                ),
                const Spacer(),
                Text(
                  'KIDLINGUA GÜVENLİ ERİŞİM',
                  style: AppTextStyles.parentSmall.copyWith(letterSpacing: 0.6),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
