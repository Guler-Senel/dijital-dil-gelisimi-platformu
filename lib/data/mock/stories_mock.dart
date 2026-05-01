import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/models/story_model.dart';

final List<StoryModel> storiesMock = [
  StoryModel(
    id: 's1',
    title: 'Orman Macerası',
    duration: const Duration(minutes: 4, seconds: 30),
    imageAsset: AppConstants.owlAvatar,
    isCompleted: true,
    isNew: false,
    summary:
        'Minik baykuş ormanda yeni dostlar edinir; ağaçlar, hayvanlar ve renkli çiçeklerle Türkçe kelimeler öğrenir.',
    paragraphs: const [
      'Bir varmış bir yokmuş, yeşil bir ormanda küçük bir baykuş yaşarmış.',
      'Baykuş her gün ağaçlardan meyve isimlerini tekrar edermiş: elma, armut, kiraz…',
      'Ormanda köpek ve kediyle oynayıp hayvanları tanımış.',
      'Ve sonunda macerasını mutlulukla bitirmiş.',
    ],
  ),
  StoryModel(
    id: 's2',
    title: 'Gökkuşağı Köprüsü',
    duration: const Duration(minutes: 3, seconds: 15),
    imageAsset: AppConstants.owlAvatar,
    isCompleted: false,
    isNew: true,
    summary: 'Renkleri ve doğayı anlatan neşeli bir yolculuk.',
    paragraphs: const [
      'Yağmurdan sonra gökyüzünde gökkuşağı belirir.',
      'Kırmızı, sarı, mavi… Tüm renkler dans eder.',
    ],
  ),
  StoryModel(
    id: 's3',
    title: 'Deniz Altında Bir Gün',
    duration: const Duration(minutes: 5, seconds: 0),
    imageAsset: AppConstants.owlAvatar,
    isCompleted: false,
    isNew: true,
    summary: 'Balıklar ve deniz canlılarıyla kelime öğrenme hikayesi.',
    paragraphs: const [
      'Mavi suların altında rengarenk balıklar yüzer.',
      'Deniz yıldızı ve yengeç de oyuna katılır.',
    ],
  ),
];

StoryModel? storyById(String id) {
  try {
    return storiesMock.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
}
