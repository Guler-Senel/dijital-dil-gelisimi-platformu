import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/widgets/parent/learning_chart_widget.dart';
import 'package:kidlingua/widgets/parent/parent_bottom_nav_pills.dart';
import 'package:kidlingua/widgets/parent/parent_dashboard_header.dart';
import 'package:kidlingua/widgets/parent/parent_today_activities_card.dart';
import 'package:kidlingua/widgets/parent/screen_time_chart_widget.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';
import 'package:kidlingua/widgets/parent/task_assign_widget.dart';
import 'package:provider/provider.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  int navIndex = 1;

  @override
  Widget build(BuildContext context) {
    final age = context.watch<KidLinguaState>().ageGroupIndexSafe;

    return Scaffold(
      backgroundColor: AppColors.parentBackground,
      body: SafeArea(
        child: Column(
          children: [
            ParentDashboardHeader(
              onSettings: () => context.push('/parent-settings'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                child: Column(
                  children: [
                    StatCardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Merhaba 👋', style: AppTextStyles.parentTitle),
                          const SizedBox(height: 6),
                          Text('1 MAYIS 2026', style: AppTextStyles.parentCaption),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const ParentTodayActivitiesCard(),
                    const SizedBox(height: 12),
                    const ScreenTimeChartWidget(),
                    const SizedBox(height: 12),
                    const TaskAssignWidget(),
                    const SizedBox(height: 12),
                    const LearningChartWidget(),
                    const SizedBox(height: 12),
                    StatCardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seviye Seç', style: AppTextStyles.parentTitle),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _ageBtn(
                                  label: '0-3 yaş',
                                  selected: age == 0,
                                  onTap: () => context.read<KidLinguaState>().setAgeGroup(0),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ageBtn(
                                  label: '3-6 yaş',
                                  selected: age == 1,
                                  onTap: () => context.read<KidLinguaState>().setAgeGroup(1),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ageBtn(
                                  label: '6-10 yaş',
                                  selected: age == 2,
                                  onTap: () => context.read<KidLinguaState>().setAgeGroup(2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Müfredat seçilen seviyeye göre otomatik güncellenir.',
                            style: AppTextStyles.parentCaption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ParentBottomNavPills(
        navIndex: navIndex,
        onChild: () {
          setState(() => navIndex = 0);
          context.go('/');
        },
        onParent: () => setState(() => navIndex = 1),
      ),
    );
  }

  Widget _ageBtn({required String label, required bool selected, required VoidCallback onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? AppColors.parentPrimary : AppColors.fullTransparent,
        foregroundColor: selected ? AppColors.parentCard : AppColors.parentText,
        side: BorderSide(color: selected ? AppColors.parentPrimary : AppColors.parentBorder),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      child: Text(label, style: AppTextStyles.parentCaption.copyWith(fontWeight: FontWeight.w800)),
    );
  }
}
