class LearningHourlySlot {
  const LearningHourlySlot({required this.label, required this.points});

  final String label;
  final double points;
}

class LearningWeekdayBar {
  const LearningWeekdayBar({
    required this.dayLabel,
    required this.earnedPoints,
    required this.targetPoints,
  });

  final String dayLabel;
  final int earnedPoints;
  final int targetPoints;
}

class LearningWeeklyDay {
  const LearningWeeklyDay({
    required this.dayLabel,
    required this.wordsLearned,
    required this.targetWords,
  });

  final String dayLabel;
  final int wordsLearned;
  final int targetWords;
}

class LearningMonthlyWeek {
  const LearningMonthlyWeek({
    required this.label,
    required this.earned,
    required this.target,
  });

  final String label;
  final double earned;
  final double target;
}
