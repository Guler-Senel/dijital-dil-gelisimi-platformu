class StoryModel {
  const StoryModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.imageAsset,
    required this.isCompleted,
    required this.isNew,
    required this.summary,
    required this.paragraphs,
  });

  final String id;
  final String title;
  final Duration duration;
  final String imageAsset;
  final bool isCompleted;
  final bool isNew;
  final String summary;
  final List<String> paragraphs;
}
