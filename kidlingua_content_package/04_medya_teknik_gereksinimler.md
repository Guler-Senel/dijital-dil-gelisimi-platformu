# Medya Teknik Gereksinimleri

## 1. Kelime Görselleri

Her kelime için bir kare görsel önerilir.

- Format: PNG veya JPG
- Oran: 1:1 kare
- Minimum çözünürlük: 512x512 px
- Stil:
  - 0-3 yaş: çok sade, tek obje, parlak ama yumuşak renkler
  - 3-6 yaş: çizgi + gerçekçi karışık, detay biraz artabilir
  - 6-10 yaş: daha açıklayıcı, gerçek hayattan nesneler kullanılabilir

Örnek dosya yolu:

```text
assets/images/words/0_3/anne.png
assets/images/words/3_6/kalem.png
assets/images/words/6_10/bilgisayar.png
```

## 2. Kelime Sesleri

Her kelime için kısa MP3 telaffuz dosyası gerekir.

- Format: MP3
- Süre: 1-2 saniye
- Dil: Türkçe
- Ses: net, yavaş, çocuk dostu
- Arka plan: sessiz, müziksiz

Örnek dosya yolu:

```text
assets/audio/words/0_3/anne.mp3
assets/audio/words/3_6/kalem.mp3
assets/audio/words/6_10/bilgisayar.mp3
```

## 3. Hikaye Medyası

Her hikaye için iki temel medya gerekir:

- Kapak görseli: JPG/PNG, 16:9, minimum 800x450 px
- Ses dosyası: MP3, 3-8 dakika

Hikaye sesleri mutlaka doğal, çocuk dostu ve sakin bir anlatım temposunda olmalıdır. Çünkü bu bölümün ana amacı dinleme pratiğidir.

## 4. Video Medyası

Video içerikleri için iki seçenek vardır:

1. Harici stream URL kullanmak.
2. Lisans alınmış MP4 dosyasını uygulama tarafında kullanmak.

Önerilen güvenli yaklaşım: TRT Çocuk veya YouTube gibi kaynaklarda resmi link/player kullanmak, videoyu indirip uygulamaya eklememek.

## 5. Maskot Dosyaları

- Normal baykuş: `assets/images/mascot/owl_normal.png`
- Mezuniyet baykuşu: `assets/images/mascot/owl_graduation.png`
- Format: PNG, şeffaf arka plan
- Minimum çözünürlük: 512x512 px

## 6. Dosya Adlandırma Kuralı

Türkçe karakterler dosya adında kullanılmamalı.

Örnek:

```text
kırmızı → kirmizi.png / kirmizi.mp3
öğretmen → ogretmen.png / ogretmen.mp3
şelale → selale.png / selale.mp3
```
