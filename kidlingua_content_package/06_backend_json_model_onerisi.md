# Backend / JSON Model Önerisi

## 1. Content Collection Önerisi

Kelime, hikaye ve video ayrı collection/tablolarda tutulabilir.

### Word

```json
{
  "id": "w_0001",
  "text": "anne",
  "ageRange": "0-3",
  "level": 1,
  "unitId": "u_0_3_ailem",
  "category": "Aile",
  "imageUrl": "assets/images/words/0_3/anne.png",
  "audioUrl": "assets/audio/words/0_3/anne.mp3",
  "difficulty": "kolay",
  "isActive": true
}
```

### Unit

```json
{
  "unitId": "u_0_3_ailem",
  "title": "Ailem",
  "ageRange": "0-3",
  "level": 1,
  "icon": "👨‍👩‍👧",
  "wordIds": ["w_0001", "w_0002"],
  "points": 100,
  "isActive": true
}
```

### Story

```json
{
  "storyId": "story_original_001",
  "title": "Minik Kedinin Günü",
  "ageRange": "0-3",
  "durationSeconds": 180,
  "coverImage": "assets/images/stories/0_3/minik_kedinin_gunu.png",
  "audioFile": "assets/audio/stories/0_3/minik_kedinin_gunu.mp3",
  "sourceType": "KidLingua özgün hikaye",
  "sourceUrl": null,
  "targetWords": ["kedi", "süt", "uyku", "anne"],
  "isActive": true
}
```

### Video

```json
{
  "videoId": "vid_3_6_01",
  "title": "Ege ile Gaga",
  "ageRange": "3-6",
  "category": "Çizgi Film/Ders",
  "thumbnailUrl": "assets/images/videos/3_6/ege_ile_gaga.jpg",
  "streamUrl": "https://www.trtcocuk.net.tr/ege-ile-gaga",
  "sourceOwner": "TRT Çocuk",
  "isExternalStream": true,
  "needsLicenseCheck": true
}
```

## 2. API Endpoint Önerileri

```text
GET /content/words?ageRange=3-6
GET /content/units?ageRange=3-6
GET /content/stories?ageRange=3-6
GET /content/videos?ageRange=3-6&category=Şarkılar
POST /progress/word-completed
POST /progress/story-completed
POST /progress/video-watched
POST /parent/tasks
GET /parent/statistics?childId=...
```

## 3. Flutter Tarafında Filtreleme

Flutter içinde seçilen yaş grubu SharedPreferences veya backend profilinde tutulabilir.

```dart
final selectedAgeRange = parentSettings.ageRange; // "3-6"
final units = allUnits.where((u) => u.ageRange == selectedAgeRange).toList();
```
