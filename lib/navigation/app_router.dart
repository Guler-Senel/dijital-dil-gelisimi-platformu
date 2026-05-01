import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/screens/child/child_home_screen.dart';
import 'package:kidlingua/screens/child/my_tasks_screen.dart';
import 'package:kidlingua/screens/child/stories_screen.dart';
import 'package:kidlingua/screens/child/story_detail_screen.dart';
import 'package:kidlingua/screens/child/unit_complete_screen.dart';
import 'package:kidlingua/screens/child/unit_detail_screen.dart';
import 'package:kidlingua/screens/child/units_screen.dart';
import 'package:kidlingua/screens/child/video_detail_screen.dart';
import 'package:kidlingua/screens/child/videos_screen.dart';
import 'package:kidlingua/screens/child/word_cards_screen.dart';
import 'package:kidlingua/screens/parent/parent_dashboard_screen.dart';
import 'package:kidlingua/screens/parent/parent_login_screen.dart';
import 'package:kidlingua/screens/parent/parent_settings_screen.dart';

class UnitCompleteArgs {
  const UnitCompleteArgs({
    required this.unitTitle,
    required this.pointsEarned,
    required this.elapsed,
  });

  final String unitTitle;
  final int pointsEarned;
  final Duration elapsed;
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ChildHomeScreen(),
      ),
      GoRoute(
        path: '/words',
        builder: (context, state) => const WordCardsScreen(),
      ),
      GoRoute(
        path: '/my-tasks',
        builder: (context, state) => const MyTasksScreen(),
      ),
      GoRoute(
        path: '/units',
        builder: (context, state) => const UnitsScreen(),
      ),
      GoRoute(
        path: '/unit/:unitId',
        builder: (context, state) {
          final id = state.pathParameters['unitId'] ?? '';
          return UnitDetailScreen(unitId: id);
        },
      ),
      GoRoute(
        path: '/unit-complete',
        builder: (context, state) {
          final extra = state.extra as UnitCompleteArgs?;
          return UnitCompleteScreen(
            unitTitle: extra?.unitTitle ?? 'Ünite',
            pointsEarned: extra?.pointsEarned ?? 150,
            elapsed: extra?.elapsed ?? const Duration(minutes: 8, seconds: 12),
          );
        },
      ),
      GoRoute(
        path: '/stories',
        builder: (context, state) => const StoriesScreen(),
      ),
      GoRoute(
        path: '/story/:storyId',
        builder: (context, state) {
          final id = state.pathParameters['storyId'] ?? '';
          return StoryDetailScreen(storyId: id);
        },
      ),
      GoRoute(
        path: '/videos',
        builder: (context, state) => const VideosScreen(),
      ),
      GoRoute(
        path: '/video/:videoId',
        builder: (context, state) {
          final id = state.pathParameters['videoId'] ?? '';
          return VideoDetailScreen(videoId: id);
        },
      ),
      GoRoute(
        path: '/parent-login',
        builder: (context, state) => const ParentLoginScreen(),
      ),
      GoRoute(
        path: '/parent-dashboard',
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: '/parent-settings',
        builder: (context, state) => const ParentSettingsScreen(),
      ),
    ],
  );
}
