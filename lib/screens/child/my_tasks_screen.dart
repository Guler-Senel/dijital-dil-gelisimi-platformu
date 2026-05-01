import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/child/child_assigned_task_widgets.dart';
import 'package:provider/provider.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<KidLinguaState>().parentAssignedTasks;

    return Scaffold(
      backgroundColor: AppColors.childBackground,
      appBar: AppBar(
        backgroundColor: AppColors.childCardBg,
        foregroundColor: AppColors.childText,
        title: Text('Görevlerim', style: AppTextStyles.childSectionTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: tasks.isEmpty
            ? const Center(child: ChildAssignedTasksEmpty())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, i) {
                  final t = tasks[i];
                  return ChildAssignedTaskCard(
                    task: t,
                    onStart: () => ChildAssignedTaskCard.navigateForTask(context, t),
                  );
                },
              ),
      ),
    );
  }
}
