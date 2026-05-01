import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/data/mock/stories_mock.dart';
import 'package:kidlingua/data/mock/units_mock.dart';
import 'package:kidlingua/data/mock/videos_mock.dart';
import 'package:kidlingua/models/learning_stats_models.dart';
import 'package:kidlingua/models/parent_activity_models.dart';
import 'package:kidlingua/models/parent_assigned_task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KidLinguaState extends ChangeNotifier {
  KidLinguaState() {
    unawaited(loadAllPreferences());
  }

  int coins = AppConstants.defaultCoins;
  int ageGroupIndex = 1;
  String _storedPin = AppConstants.defaultParentPin;

  bool dailyLimitEnabled = false;
  int dailyLimitMinutes = 60;
  bool timeRestrictionEnabled = false;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 20, minute: 0);
  bool breakReminderEnabled = false;
  String breakInterval = '20';
  int dailyWordGoal = 5;

  final List<ParentAssignedTask> parentAssignedTasks = [];

  final List<TodayVideoActivityRow> todayVideoActivities = const [
    TodayVideoActivityRow(
      title: 'Alfabe Şarkısı ve Dans',
      duration: Duration(minutes: 3, seconds: 45),
    ),
    TodayVideoActivityRow(
      title: 'Sayıları Sayalım',
      duration: Duration(minutes: 2, seconds: 55),
    ),
  ];

  final List<TodayStoryActivityRow> todayStoryActivities = const [
    TodayStoryActivityRow(title: 'Orman Macerası', durationLabel: '5 dakika'),
  ];

  final List<LearnedWordToday> learnedWordsToday = const [
    LearnedWordToday(word: 'GÜNEŞ', unitName: 'Şekiller Ünitesi'),
    LearnedWordToday(word: 'AĞAÇ', unitName: 'Şekiller Ünitesi'),
    LearnedWordToday(word: 'KİTAP', unitName: 'Yiyecekler Ünitesi'),
    LearnedWordToday(word: 'ELMA', unitName: 'Yiyecekler Ünitesi'),
  ];

  final List<LearningHourlySlot> learningHourlySlots = const [
    LearningHourlySlot(label: '09:00-10:00', points: 8),
    LearningHourlySlot(label: '10:00-11:00', points: 18),
    LearningHourlySlot(label: '11:00-12:00', points: 6),
    LearningHourlySlot(label: '14:00-15:00', points: 13),
  ];

  final List<LearningWeekdayBar> learningWeekdayBars = const [
    LearningWeekdayBar(dayLabel: 'Pzt', earnedPoints: 40, targetPoints: 60),
    LearningWeekdayBar(dayLabel: 'Sal', earnedPoints: 55, targetPoints: 60),
    LearningWeekdayBar(dayLabel: 'Çar', earnedPoints: 48, targetPoints: 60),
    LearningWeekdayBar(dayLabel: 'Per', earnedPoints: 62, targetPoints: 60),
    LearningWeekdayBar(dayLabel: 'Cum', earnedPoints: 50, targetPoints: 60),
  ];

  final List<LearningWeeklyDay> learningWeeklyDays = const [
    LearningWeeklyDay(dayLabel: 'Pzt', wordsLearned: 4, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Sal', wordsLearned: 7, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Çar', wordsLearned: 3, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Per', wordsLearned: 5, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Cum', wordsLearned: 2, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Cmt', wordsLearned: 1, targetWords: 6),
    LearningWeeklyDay(dayLabel: 'Paz', wordsLearned: 1, targetWords: 6),
  ];

  final List<LearningMonthlyWeek> learningMonthlyWeeks = const [
    LearningMonthlyWeek(label: '1. Hafta', earned: 20, target: 25),
    LearningMonthlyWeek(label: '2. Hafta', earned: 24, target: 25),
    LearningMonthlyWeek(label: '3. Hafta', earned: 22, target: 25),
    LearningMonthlyWeek(label: '4. Hafta', earned: 23, target: 25),
  ];

  bool learningStatsEmpty = false;

  String get parentPin => _storedPin;

  int get ageGroupIndexSafe => ageGroupIndex.clamp(0, 2);

  int get dailyWordGoalSafe => dailyWordGoal.clamp(3, 10);

  int get totalWeeklyWordsLearned =>
      learningWeeklyDays.fold(0, (a, b) => a + b.wordsLearned);

  int get totalMonthlyWordsLearned => 89;

  LearningHourlySlot? get mostActiveHourlySlot {
    if (learningHourlySlots.isEmpty) return null;
    return learningHourlySlots.reduce((a, b) => a.points >= b.points ? a : b);
  }

  int get totalDailyPoints =>
      learningHourlySlots.fold(0.0, (a, b) => a + b.points).round();

  Future<void> loadAllPreferences() async {
    final p = await SharedPreferences.getInstance();
    _storedPin = p.getString(AppConstants.prefsPinKey) ?? AppConstants.defaultParentPin;
    ageGroupIndex = p.getInt(AppConstants.prefsAgeGroupIndex) ?? 1;
    dailyLimitEnabled = p.getBool(AppConstants.prefsDailyLimitEnabled) ?? false;
    dailyLimitMinutes = p.getInt(AppConstants.prefsDailyLimitMinutes) ?? 60;
    dailyLimitMinutes = dailyLimitMinutes.clamp(15, 180);
    if ((dailyLimitMinutes - 15) % 15 != 0) {
      dailyLimitMinutes = (((dailyLimitMinutes / 15).round() * 15).clamp(15, 180)).toInt();
    }
    timeRestrictionEnabled = p.getBool(AppConstants.prefsTimeRestrictionEnabled) ?? false;
    final sm = p.getInt(AppConstants.prefsStartMinutes);
    final em = p.getInt(AppConstants.prefsEndMinutes);
    startTime = sm != null ? _timeFromMinutes(sm) : const TimeOfDay(hour: 9, minute: 0);
    endTime = em != null ? _timeFromMinutes(em) : const TimeOfDay(hour: 20, minute: 0);
    breakReminderEnabled = p.getBool(AppConstants.prefsBreakReminderEnabled) ?? false;
    breakInterval = p.getString(AppConstants.prefsBreakInterval) ?? '20';
    if (!['20', '30', '45'].contains(breakInterval)) breakInterval = '20';
    dailyWordGoal = p.getInt(AppConstants.prefsDailyWordGoal) ?? 5;
    if (![3, 5, 10].contains(dailyWordGoal)) dailyWordGoal = 5;
    notifyListeners();
  }

  TimeOfDay _timeFromMinutes(int total) {
    final h = (total ~/ 60).clamp(0, 23);
    final m = (total % 60).clamp(0, 59);
    return TimeOfDay(hour: h, minute: m);
  }

  int _minutesOf(TimeOfDay t) => t.hour * 60 + t.minute;

  Future<void> _savePreferences() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(AppConstants.prefsPinKey, _storedPin);
    await p.setInt(AppConstants.prefsAgeGroupIndex, ageGroupIndex);
    await p.setBool(AppConstants.prefsDailyLimitEnabled, dailyLimitEnabled);
    await p.setInt(AppConstants.prefsDailyLimitMinutes, dailyLimitMinutes);
    await p.setBool(AppConstants.prefsTimeRestrictionEnabled, timeRestrictionEnabled);
    await p.setInt(AppConstants.prefsStartMinutes, _minutesOf(startTime));
    await p.setInt(AppConstants.prefsEndMinutes, _minutesOf(endTime));
    await p.setBool(AppConstants.prefsBreakReminderEnabled, breakReminderEnabled);
    await p.setString(AppConstants.prefsBreakInterval, breakInterval);
    await p.setInt(AppConstants.prefsDailyWordGoal, dailyWordGoal);
  }

  Future<void> setParentPin(String pin) async {
    if (pin.length != 4) return;
    _storedPin = pin;
    await _savePreferences();
    notifyListeners();
  }

  bool validatePin(String pin) => pin == _storedPin;

  void addCoins(int amount) {
    coins += amount;
    notifyListeners();
  }

  Future<void> setAgeGroup(int index) async {
    ageGroupIndex = index.clamp(0, 2);
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setDailyLimitEnabled(bool v) async {
    dailyLimitEnabled = v;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setDailyLimitMinutes(int v) async {
    dailyLimitMinutes = (((v / 15).round() * 15).clamp(15, 180)).toInt();
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setTimeRestrictionEnabled(bool v) async {
    timeRestrictionEnabled = v;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setStartTime(TimeOfDay t) async {
    startTime = t;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setEndTime(TimeOfDay t) async {
    endTime = t;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setBreakReminderEnabled(bool v) async {
    breakReminderEnabled = v;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> setBreakInterval(String v) async {
    if (['20', '30', '45'].contains(v)) {
      breakInterval = v;
      await _savePreferences();
      notifyListeners();
    }
  }

  Future<void> setDailyWordGoal(int v) async {
    if ([3, 5, 10].contains(v)) {
      dailyWordGoal = v;
      await _savePreferences();
      notifyListeners();
    }
  }

  Future<void> resetAllData() async {
    final p = await SharedPreferences.getInstance();
    for (final k in AppConstants.allKidLinguaPrefsKeys) {
      await p.remove(k);
    }
    parentAssignedTasks.clear();
    _storedPin = AppConstants.defaultParentPin;
    ageGroupIndex = 1;
    dailyLimitEnabled = false;
    dailyLimitMinutes = 60;
    timeRestrictionEnabled = false;
    startTime = const TimeOfDay(hour: 9, minute: 0);
    endTime = const TimeOfDay(hour: 20, minute: 0);
    breakReminderEnabled = false;
    breakInterval = '20';
    dailyWordGoal = 5;
    coins = AppConstants.defaultCoins;
    await _savePreferences();
    notifyListeners();
  }

  void addAssignedTask({String? unitId, String? videoId, String? storyId}) {
    final base = DateTime.now().millisecondsSinceEpoch;
    if (unitId != null) {
      final u = unitById(unitId);
      if (u != null) {
        parentAssignedTasks.add(
          ParentAssignedTask(
            id: 'task_u_${base}_$unitId',
            kind: ParentAssignedTaskKind.unit,
            title: u.title,
            unitId: unitId,
          ),
        );
      }
    }
    if (videoId != null) {
      final v = videoById(videoId);
      if (v != null) {
        parentAssignedTasks.add(
          ParentAssignedTask(
            id: 'task_v_${base}_$videoId',
            kind: ParentAssignedTaskKind.video,
            title: v.title,
            videoId: videoId,
          ),
        );
      }
    }
    if (storyId != null) {
      final s = storyById(storyId);
      if (s != null) {
        parentAssignedTasks.add(
          ParentAssignedTask(
            id: 'task_s_${base}_$storyId',
            kind: ParentAssignedTaskKind.story,
            title: s.title,
            storyId: storyId,
          ),
        );
      }
    }
    notifyListeners();
  }

  void setAssignedTaskCompleted(String id, {bool completed = true}) {
    for (final t in parentAssignedTasks) {
      if (t.id == id) {
        t.completed = completed;
        notifyListeners();
        return;
      }
    }
  }
}
