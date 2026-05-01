import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/data/mock/stories_mock.dart';
import 'package:kidlingua/widgets/child/stories_widgets.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.childBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoryListAppBar(onBack: () => context.pop()),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hikaye Zamanı!',
                    style: AppTextStyles.childSectionTitle.copyWith(color: AppColors.childPrimary),
                  ),
                  Text(
                    'Hangi maceraya atılmak istersin?',
                    style: AppTextStyles.childBodyLight,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                itemCount: storiesMock.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) => StoryListRow(story: storiesMock[i]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: StoryOwlTipBox(),
            ),
          ],
        ),
      ),
    );
  }
}
