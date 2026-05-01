import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/utils/helpers.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/child/child_assigned_task_widgets.dart';
import 'package:kidlingua/data/mock/stories_mock.dart';
import 'package:kidlingua/data/mock/units_mock.dart';
import 'package:kidlingua/data/mock/videos_mock.dart';
import 'package:kidlingua/data/mock/words_mock.dart';
import 'package:kidlingua/widgets/child/child_home_header.dart';
import 'package:kidlingua/widgets/child/child_home_widgets.dart';
import 'package:kidlingua/widgets/child/story_card_widget.dart';
import 'package:kidlingua/widgets/child/unit_card_widget.dart';
import 'package:kidlingua/widgets/child/word_card_widget.dart';
import 'package:provider/provider.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({super.key});

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final wordGoal = context.watch<KidLinguaState>().dailyWordGoalSafe;
    final dayWords = wordsMock.take(wordGoal).toList();
    final homeUnits = unitsMock.take(2).toList();
    final featuredStory = storiesMock.first;
    final gridVideos = videosMock.take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ChildHomeHeader(
              onSettings: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ayarlar yakında.')),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChildHomeSectionTitleRow(
                      title: '⭐ Günün Kelimeleri',
                      onSeeAll: () => context.push('/words'),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: dayWords.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          return WordCardWidget(
                            word: dayWords[i],
                            backgroundColor: wordCardTint(i),
                            onTapSound: () => playWordSoundPrint(dayWords[i].name),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    ChildHomeSectionTitleRow(
                      title: '🚀 Üniteler',
                      onSeeAll: () => context.push('/units'),
                    ),
                    const SizedBox(height: 10),
                    ChildHomeUnitsBanner(onTap: () => context.push('/units')),
                    const SizedBox(height: 12),
                    ...homeUnits.map(
                      (u) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: UnitCardWidget(
                          unit: u,
                          compact: true,
                          onTap: () => context.push('/unit/${u.id}'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ChildHomeSectionTitleRow(
                      title: '📖 Hikayeler',
                      onSeeAll: () => context.push('/stories'),
                    ),
                    const SizedBox(height: 10),
                    StoryCardWidget(
                      story: featuredStory,
                      onTap: () => context.push('/stories'),
                    ),
                    const SizedBox(height: 22),
                    ChildHomeSectionTitleRow(
                      title: '🎬 Videolar',
                      onSeeAll: () => context.push('/videos'),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gridVideos.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, i) {
                        final v = gridVideos[i];
                        return ChildHomeVideoTile(
                          video: v,
                          onTap: () => context.push('/videos'),
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    ChildHomeSectionTitleRow(
                      title: '📋 Görevlerim',
                      onSeeAll: () => context.push('/my-tasks'),
                    ),
                    const SizedBox(height: 10),
                    Consumer<KidLinguaState>(
                      builder: (context, state, _) {
                        if (state.parentAssignedTasks.isEmpty) {
                          return const ChildAssignedTasksEmpty();
                        }
                        return Column(
                          children: state.parentAssignedTasks
                              .map(
                                (t) => ChildAssignedTaskCard(
                                  task: t,
                                  onStart: () {
                                    ChildAssignedTaskCard.navigateForTask(context, t);
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: ChildBottomNavPill(
                  label: 'Çocuk',
                  icon: Icons.wb_sunny_rounded,
                  selected: navIndex == 0,
                  onTap: () => setState(() => navIndex = 0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChildBottomNavPill(
                  label: 'Ebeveyn',
                  icon: Icons.shield_outlined,
                  selected: navIndex == 1,
                  onTap: () async {
                    setState(() => navIndex = 1);
                    await context.push('/parent-login');
                    if (mounted) setState(() => navIndex = 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
