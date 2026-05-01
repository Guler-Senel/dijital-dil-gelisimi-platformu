class TodayVideoActivityRow {
  const TodayVideoActivityRow({
    required this.title,
    required this.duration,
    this.completed = true,
  });

  final String title;
  final Duration duration;
  final bool completed;
}

class TodayStoryActivityRow {
  const TodayStoryActivityRow({
    required this.title,
    required this.durationLabel,
    this.completed = true,
  });

  final String title;
  final String durationLabel;
  final bool completed;
}

class LearnedWordToday {
  const LearnedWordToday({required this.word, required this.unitName});

  final String word;
  final String unitName;
}
