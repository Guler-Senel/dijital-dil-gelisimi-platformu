import 'package:flutter/material.dart';
import 'package:kidlingua/core/theme/app_colors.dart';
import 'package:kidlingua/core/theme/app_text_styles.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:kidlingua/widgets/parent/stat_card_widget.dart';
import 'package:kidlingua/data/mock/stories_mock.dart';
import 'package:kidlingua/data/mock/units_mock.dart';
import 'package:kidlingua/data/mock/videos_mock.dart';
import 'package:provider/provider.dart';

class TaskAssignWidget extends StatefulWidget {
  const TaskAssignWidget({super.key});

  @override
  State<TaskAssignWidget> createState() => _TaskAssignWidgetState();
}

class _TaskAssignWidgetState extends State<TaskAssignWidget> {
  String? unitId;
  String? videoId;
  String? storyId;

  @override
  Widget build(BuildContext context) {
    return StatCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Görev Ata', style: AppTextStyles.parentTitle),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: unitId,
            decoration: _fieldDeco('ÜNİTE SEÇİMİ'),
            items: unitsMock
                .map(
                  (u) => DropdownMenuItem(
                    value: u.id,
                    child: Text(u.title, style: AppTextStyles.parentBody),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => unitId = v),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: videoId,
            decoration: _fieldDeco('VİDEO SEÇİMİ'),
            items: videosMock
                .map(
                  (v) => DropdownMenuItem(
                    value: v.id,
                    child: Text(v.title, style: AppTextStyles.parentBody),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => videoId = v),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: storyId,
            decoration: _fieldDeco('HİKAYE SEÇİMİ'),
            items: storiesMock
                .map(
                  (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.title, style: AppTextStyles.parentBody),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => storyId = v),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.parentPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (unitId == null && videoId == null && storyId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lütfen en az bir seçim yapın.')),
                  );
                  return;
                }
                context.read<KidLinguaState>().addAssignedTask(
                      unitId: unitId,
                      videoId: videoId,
                      storyId: storyId,
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Görev kaydedildi.')),
                );
              },
              child: Text('Görevi Kaydet', style: AppTextStyles.parentBody.copyWith(color: AppColors.onLight)),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDeco(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.parentCaption,
      filled: true,
      fillColor: AppColors.parentBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.parentBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.parentBorder),
      ),
    );
  }
}
