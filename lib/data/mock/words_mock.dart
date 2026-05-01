import 'package:kidlingua/core/constants/app_constants.dart';
import 'package:kidlingua/models/word_model.dart';

final List<WordModel> wordsMock = [
  WordModel(
    id: 'w1',
    name: 'ELMA',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '🍎',
    syllables: 'el-ma',
  ),
  WordModel(
    id: 'w2',
    name: 'KÖPEK',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '🐾',
    syllables: 'kö-pek',
  ),
  WordModel(
    id: 'w3',
    name: 'GÜNEŞ',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '☀️',
    syllables: 'gü-neş',
  ),
  WordModel(
    id: 'w4',
    name: 'BULUT',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '☁️',
    syllables: 'bu-lut',
  ),
  WordModel(
    id: 'w5',
    name: 'AĞAÇ',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '🌳',
    syllables: 'a-ğaç',
  ),
  WordModel(
    id: 'w6',
    name: 'FİL',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '🐘',
    syllables: 'fil',
  ),
  WordModel(
    id: 'w7',
    name: 'KIRMIZI',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '🎨',
    syllables: 'kır-mı-zı',
  ),
  WordModel(
    id: 'w8',
    name: 'ÜÇ',
    imageAsset: AppConstants.owlAvatar,
    categoryEmoji: '3️⃣',
    syllables: 'üç',
  ),
];

WordModel? wordById(String id) {
  try {
    return wordsMock.firstWhere((w) => w.id == id);
  } catch (_) {
    return null;
  }
}

List<WordModel> wordsForIds(List<String> ids) {
  return ids.map(wordById).whereType<WordModel>().toList();
}
