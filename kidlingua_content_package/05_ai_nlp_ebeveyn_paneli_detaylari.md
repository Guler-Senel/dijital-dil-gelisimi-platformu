# AI / NLP ve Ebeveyn Paneli Detayları

## 1. Kelime Seçme Algoritması

Algoritma şu girdileri kullanabilir:

| Girdi | Açıklama |
|---|---|
| ageRange | 0-3, 3-6 veya 6-10 |
| currentLevel | 1, 2 veya 3 |
| seenWordIds | Daha önce gösterilen kelimeler |
| correctRateLast10 | Son 10 görevde doğru oranı |
| dailyTarget | 3, 5 veya 10 kelime |
| preferredUnits | Ebeveynin seçtiği veya çocuğun ilgilendiği üniteler |

Basit seçim mantığı:

```pseudo
filteredWords = words where ageRange == selectedAgeRange
remove words in seenWordIds from first priority
prefer words from currentLevel and preferredUnits
select dailyTarget number of words
```

## 2. Seviye Geçiş Kuralı

- Son 10 etkinlikte %80 ve üzeri başarı: seviye +1
- Son 10 etkinlikte %30 ve altı başarı: seviye -1
- Diğer durumlarda aynı seviye korunur

## 3. Ebeveyn Paneli İçin Metrikler

| Metrik | Açıklama | Grafik |
|---|---|---|
| Günlük kelime sayısı | Bugün öğrenilen yeni kelime | Etiket/list |
| Dinlenen hikaye | Hikaye adı, süre, tamamlandı bilgisi | Liste |
| İzlenen video | Video adı, kategori, süre | Liste |
| Ekran süresi | Toplam dakika + kategori dağılımı | Yatay bar |
| Haftalık puan | Gün gün kazanılan puan | Bar chart |
| Aylık gelişim | 4 haftalık ilerleme | Line chart |

## 4. Görev Atama Mantığı

Ebeveyn üç tür görev atayabilir:

1. Ünite görevi
2. Hikaye dinleme görevi
3. Video izleme görevi

Örnek görev objesi:

```json
{
  "taskId": "task_001",
  "childId": "child_001",
  "taskType": "story",
  "contentId": "story_original_003",
  "title": "Güneş Nerede?",
  "assignedBy": "parent",
  "status": "pending",
  "createdAt": "2026-05-04T12:00:00Z"
}
```

## 5. Dinleme Analizi Fikri

Hikaye bittikten sonra basit sorular sorulabilir:

- Hikayede hangi hayvan vardı?
- Güneş ne zaman çıkar?
- Bu kelimeyi duydun mu: “yağmur”?

Bu cevaplar çocuğun dinleme-anlama gelişimi için puanlanabilir.
