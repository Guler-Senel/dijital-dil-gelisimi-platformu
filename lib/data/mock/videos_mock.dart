import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/models/video_model.dart';

final List<VideoModel> videosMock = [
  VideoModel(
    id: 'v1',
    title: 'Alfabe Şarkısı ve Dans',
    duration: const Duration(minutes: 3, seconds: 45),
    thumbnailAsset: AppConstants.owlAvatar,
    category: VideoCategory.songs,
    description:
        'Eğlenceli bir alfabe şarkısı ile harfleri ve sesleri birlikte öğrenin. Dans etmeyi unutmayın!',
  ),
  VideoModel(
    id: 'v2',
    title: 'Sayıları Sayalım',
    duration: const Duration(minutes: 2, seconds: 55),
    thumbnailAsset: AppConstants.owlAvatar,
    category: VideoCategory.cartoon,
    description: '1’den 10’a kadar sayıları çizgi film kahramanlarıyla keşfedin.',
  ),
  VideoModel(
    id: 'v3',
    title: 'Renkler Dersi',
    duration: const Duration(minutes: 4, seconds: 10),
    thumbnailAsset: AppConstants.owlAvatar,
    category: VideoCategory.lessons,
    description: 'Temel renk isimleri ve günlük örneklerle pekiştirme.',
  ),
  VideoModel(
    id: 'v4',
    title: 'Hayvan Sesleri',
    duration: const Duration(minutes: 1, seconds: 55),
    thumbnailAsset: AppConstants.owlAvatar,
    category: VideoCategory.songs,
    description: 'Kedi, köpek, inek ve daha fazlasının sesleriyle eğlenceli tekrar.',
  ),
];

VideoModel? videoById(String id) {
  try {
    return videosMock.firstWhere((v) => v.id == id);
  } catch (_) {
    return null;
  }
}

List<VideoModel> videosFiltered(VideoCategory cat) {
  if (cat == VideoCategory.all) return videosMock;
  return videosMock.where((v) => v.category == cat).toList();
}
