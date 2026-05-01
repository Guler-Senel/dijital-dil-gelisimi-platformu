import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/parent_login_numpad.dart';
import 'package:provider/provider.dart';

class ParentPinChangeSheet extends StatefulWidget {
  const ParentPinChangeSheet({super.key});

  @override
  State<ParentPinChangeSheet> createState() => _ParentPinChangeSheetState();
}

class _ParentPinChangeSheetState extends State<ParentPinChangeSheet> with SingleTickerProviderStateMixin {
  int step = 0;
  final List<int> entered = [];
  String? _newPin;
  bool _error = false;
  late AnimationController _shake;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(vsync: this, duration: const Duration(milliseconds: 420));
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shake, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  Future<void> _completePinChange(String pin) async {
    await context.read<KidLinguaState>().setParentPin(pin);
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Şifre güncellendi ✓')),
    );
  }

  void _shakeError() {
    setState(() => _error = true);
    _shake.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _error = false);
    });
  }

  void _onDigit(int d) {
    if (entered.length >= 4) return;
    setState(() => entered.add(d));
    if (entered.length < 4) return;

    final pin = entered.join();

    if (step == 0) {
      if (!context.read<KidLinguaState>().validatePin(pin)) {
        _shakeError();
        setState(() => entered.clear());
        return;
      }
      setState(() {
        entered.clear();
        step = 1;
      });
      return;
    }

    if (step == 1) {
      _newPin = pin;
      setState(() {
        entered.clear();
        step = 2;
      });
      return;
    }

    if (step == 2) {
      if (pin != _newPin) {
        _shakeError();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Şifreler eşleşmiyor', style: AppTextStyles.parentBody)),
        );
        setState(() => entered.clear());
        return;
      }
      unawaited(_completePinChange(pin));
    }
  }

  void _backspace() {
    if (entered.isEmpty) return;
    setState(() => entered.removeLast());
  }

  String _title() {
    switch (step) {
      case 0:
        return 'Mevcut Şifre';
      case 1:
        return 'Yeni Şifre';
      default:
        return 'Yeni Şifre Tekrar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Ebeveyn Şifresini Değiştir', style: AppTextStyles.parentTitle),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 8),
          Text(_title(), style: AppTextStyles.parentCaption),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _shakeAnim,
            builder: (context, child) {
              return Transform.translate(offset: Offset(_shakeAnim.value, 0), child: child);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final filled = i < entered.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? AppColors.parentPrimary : AppColors.parentBorder,
                    border: Border.all(
                      color: _error ? AppColors.parentError : AppColors.parentBorder,
                      width: _error ? 2 : 1,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          ParentLoginNumpad(onDigit: _onDigit, onBackspace: _backspace),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal', style: AppTextStyles.parentBody.copyWith(color: AppColors.parentTextGray)),
          ),
        ],
      ),
    );
  }
}
