import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_theme.dart';

class KidLinguaApp extends StatelessWidget {
  const KidLinguaApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KidLingua',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.childTheme,
      routerConfig: router,
    );
  }
}
