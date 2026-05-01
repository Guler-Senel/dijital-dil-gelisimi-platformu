import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/parent_pin_change_sheet.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';
import 'package:provider/provider.dart';

class ParentSettingsScreen extends StatelessWidget {
  const ParentSettingsScreen({super.key});

  static String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _showPinSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.parentCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => const ParentPinChangeSheet(),
    );
  }

  Future<void> _pickTime(BuildContext context, {required bool isStart}) async {
    final state = context.read<KidLinguaState>();
    final initial = isStart ? state.startTime : state.endTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.parentPrimary, surface: AppColors.parentCard),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked == null || !context.mounted) return;
    if (isStart) {
      await context.read<KidLinguaState>().setStartTime(picked);
    } else {
      await context.read<KidLinguaState>().setEndTime(picked);
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Verileri sıfırla', style: AppTextStyles.parentTitle),
        content: Text(
          'Tüm ilerleme ve ayarlar silinecek. Emin misiniz?',
          style: AppTextStyles.parentBody,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.parentError),
            child: const Text('Sıfırla'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await context.read<KidLinguaState>().resetAllData();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Veriler sıfırlandı', style: AppTextStyles.parentBody)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<KidLinguaState>();

    return Scaffold(
      backgroundColor: AppColors.parentBackground,
      appBar: AppBar(
        backgroundColor: AppColors.parentPrimary,
        foregroundColor: AppColors.onLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Ayarlar', style: AppTextStyles.parentTitle.copyWith(color: AppColors.onLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StatCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔒 Güvenlik', style: AppTextStyles.parentTitle),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.lock_outline, color: AppColors.parentPrimary),
                    title: Text('Ebeveyn Şifresini Değiştir', style: AppTextStyles.parentBody),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.parentTextGray),
                    onTap: () => _showPinSheet(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            StatCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('⏱ Ekran Süresi', style: AppTextStyles.parentTitle),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Günlük Süre Limiti', style: AppTextStyles.parentBody),
                    value: s.dailyLimitEnabled,
                    activeThumbColor: AppColors.onLight,
                    activeTrackColor: AppColors.parentPrimary,
                    onChanged: (v) => context.read<KidLinguaState>().setDailyLimitEnabled(v),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: s.dailyLimitEnabled
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  '${s.dailyLimitMinutes} dakika',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.parentHeadline.copyWith(
                                    color: AppColors.parentPrimary,
                                    fontSize: 28,
                                  ),
                                ),
                                Slider(
                                  value: s.dailyLimitMinutes.toDouble().clamp(15, 180),
                                  min: 15,
                                  max: 180,
                                  divisions: 11,
                                  activeColor: AppColors.parentPrimary,
                                  label: '${s.dailyLimitMinutes} dk',
                                  onChanged: (v) {
                                    context.read<KidLinguaState>().setDailyLimitMinutes(v.round());
                                  },
                                ),
                                Text(
                                  'Çocuk bu süreyi aşınca uyarı verilir',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.parentCaption,
                                ),
                              ],
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ),
                  const Divider(height: 28),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Kullanım Saati Kısıtla', style: AppTextStyles.parentBody),
                    value: s.timeRestrictionEnabled,
                    activeThumbColor: AppColors.onLight,
                    activeTrackColor: AppColors.parentPrimary,
                    onChanged: (v) => context.read<KidLinguaState>().setTimeRestrictionEnabled(v),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: s.timeRestrictionEnabled
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text('Başlangıç Saati', style: AppTextStyles.parentBody),
                                  trailing: OutlinedButton(
                                    onPressed: () => _pickTime(context, isStart: true),
                                    child: Text(_formatTime(s.startTime)),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text('Bitiş Saati', style: AppTextStyles.parentBody),
                                  trailing: OutlinedButton(
                                    onPressed: () => _pickTime(context, isStart: false),
                                    child: Text(_formatTime(s.endTime)),
                                  ),
                                ),
                                Text(
                                  'Bu saatler dışında uygulama kilitlenir',
                                  style: AppTextStyles.parentCaption,
                                ),
                              ],
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ),
                  const Divider(height: 28),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Mola Hatırlatıcısı', style: AppTextStyles.parentBody),
                    value: s.breakReminderEnabled,
                    activeThumbColor: AppColors.onLight,
                    activeTrackColor: AppColors.parentPrimary,
                    onChanged: (v) => context.read<KidLinguaState>().setBreakReminderEnabled(v),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    child: s.breakReminderEnabled
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.parentBackground,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.parentBorder),
                                  ),
                                  child: DropdownButton<String>(
                                    value: ['20', '30', '45'].contains(s.breakInterval) ? s.breakInterval : '20',
                                    underline: const SizedBox.shrink(),
                                    borderRadius: BorderRadius.circular(12),
                                    items: const [
                                      DropdownMenuItem(value: '20', child: Text('Her 20 dakikada bir')),
                                      DropdownMenuItem(value: '30', child: Text('Her 30 dakikada bir')),
                                      DropdownMenuItem(value: '45', child: Text('Her 45 dakikada bir')),
                                    ],
                                    onChanged: (v) {
                                      if (v != null) context.read<KidLinguaState>().setBreakInterval(v);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Çocuğa düzenli mola vermesini hatırlatır',
                                style: AppTextStyles.parentCaption,
                              ),
                            ],
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            StatCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📚 İçerik', style: AppTextStyles.parentTitle),
                  const SizedBox(height: 8),
                  Text('Çocuğun Yaş Grubu', style: AppTextStyles.parentBody),
                  const SizedBox(height: 10),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('0-3')),
                      ButtonSegment(value: 1, label: Text('3-6')),
                      ButtonSegment(value: 2, label: Text('6-10')),
                    ],
                    selected: {s.ageGroupIndexSafe},
                    onSelectionChanged: (Set<int> next) {
                      if (next.isEmpty) return;
                      context.read<KidLinguaState>().setAgeGroup(next.first);
                    },
                    multiSelectionEnabled: false,
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.onLight;
                        }
                        return AppColors.parentText;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.parentPrimary;
                        }
                        return AppColors.parentBackground;
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Text('Günlük Kelime Hedefi', style: AppTextStyles.parentBody)),
                      DropdownButton<int>(
                        value: [3, 5, 10].contains(s.dailyWordGoal) ? s.dailyWordGoal : 5,
                        underline: const SizedBox.shrink(),
                        items: const [
                          DropdownMenuItem(value: 3, child: Text('3 kelime')),
                          DropdownMenuItem(value: 5, child: Text('5 kelime')),
                          DropdownMenuItem(value: 10, child: Text('10 kelime')),
                        ],
                        onChanged: (v) {
                          if (v != null) context.read<KidLinguaState>().setDailyWordGoal(v);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            StatCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ℹ️ Hakkında', style: AppTextStyles.parentTitle),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Uygulama Versiyonu', style: AppTextStyles.parentBody),
                    trailing: Text('1.0.0', style: AppTextStyles.parentCaption),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Gizlilik Politikası', style: AppTextStyles.parentBody),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.parentTextGray),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Yakında')),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Kullanım Koşulları', style: AppTextStyles.parentBody),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.parentTextGray),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Yakında')),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.delete_outline, color: AppColors.parentError),
                    title: Text(
                      'Verileri Sıfırla',
                      style: AppTextStyles.parentBody.copyWith(color: AppColors.parentError),
                    ),
                    onTap: () => _confirmReset(context),
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
