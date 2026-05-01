abstract final class AppConstants {
  static const String appName = 'KidLingua';
  static const String childAgeBadge = '3-6 YAŞ';
  static const String owlAvatar = 'assets/images/owl_avatar.png';
  static const String owlGraduate = 'assets/images/owl_graduate.png';

  static const String defaultParentPin = '1234';
  static const String prefsPinKey = 'kidlingua_parent_pin';
  static const String prefsAgeGroupIndex = 'kidlingua_age_group';
  static const String prefsDailyLimitEnabled = 'kidlingua_daily_limit_enabled';
  static const String prefsDailyLimitMinutes = 'kidlingua_daily_limit_minutes';
  static const String prefsTimeRestrictionEnabled = 'kidlingua_time_restriction_enabled';
  static const String prefsStartMinutes = 'kidlingua_start_minutes';
  static const String prefsEndMinutes = 'kidlingua_end_minutes';
  static const String prefsBreakReminderEnabled = 'kidlingua_break_reminder_enabled';
  static const String prefsBreakInterval = 'kidlingua_break_interval';
  static const String prefsDailyWordGoal = 'kidlingua_daily_word_goal';

  static const List<String> allKidLinguaPrefsKeys = [
    prefsPinKey,
    prefsAgeGroupIndex,
    prefsDailyLimitEnabled,
    prefsDailyLimitMinutes,
    prefsTimeRestrictionEnabled,
    prefsStartMinutes,
    prefsEndMinutes,
    prefsBreakReminderEnabled,
    prefsBreakInterval,
    prefsDailyWordGoal,
  ];

  static const int defaultCoins = 124;
}
