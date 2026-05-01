enum VideoCategory { all, songs, cartoon, lessons }

class VideoModel {
  const VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnailAsset,
    required this.category,
    required this.description,
  });

  final String id;
  final String title;
  final Duration duration;
  final String thumbnailAsset;
  final VideoCategory category;
  final String description;

  String get categoryLabel {
    switch (category) {
      case VideoCategory.songs:
        return 'Şarkılar';
      case VideoCategory.cartoon:
        return 'Çizgi Film';
      case VideoCategory.lessons:
        return 'Dersler';
      case VideoCategory.all:
        return 'Hepsi';
    }
  }
}
