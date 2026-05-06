# KidLingua İçerik Dosyalama Paketi

Bu paket, KidLingua projesindeki içerikleri ayrı dosyalar halinde düzenlemek için hazırlanmıştır.

## Dosya Yapısı

```text
kidlingua_content_package/
├── 00_README_Dosya_Yapisi.md
├── 01_kelime_ve_uniteler.json
├── 02_hikayeler_ve_sesli_kaynaklar.json
├── 03_videolar_yas_grubuna_gore.json
├── 04_medya_teknik_gereksinimler.md
├── 05_ai_nlp_ebeveyn_paneli_detaylari.md
├── 06_backend_json_model_onerisi.md
└── 07_kaynaklar_ve_lisans_notlari.md
```

## Ne Değişti?

- Kelime listesi genişletildi.
- Kelimeler ünitelerin içine yerleştirildi.
- Her kelime için `ageRange`, `level`, `unitId`, `imageFile`, `audioFile`, `visualPromptTR`, `audioPromptTR` eklendi.
- Hikayeler için seslendirme zorunluluğu ayrıca belirtildi.
- Harici hikaye ve video kaynakları linkleriyle birlikte verildi.
- Telif/lisans kontrolü için ayrı not dosyası eklendi.

## Flutter İçin Kullanım Mantığı

1. Ebeveyn yaş grubunu seçer: `0-3`, `3-6`, `6-10`.
2. Uygulama `01_kelime_ve_uniteler.json` içinden ilgili `ageRange` değerini filtreler.
3. Günün kelimeleri için `dailyWordTargets` değerine göre 3, 5 veya 10 kelime seçilir.
4. Ünite ekranında `units[].words[]` listesi kullanılır.
5. Hikaye/video ekranları için `02_...json` ve `03_...json` dosyaları filtrelenir.

## Önemli Not

Hazır video ve hikaye kaynaklarının çoğu teliflidir. Bu nedenle uygulamaya dosya olarak gömmek yerine resmi link/player kullanılmalı veya yazılı izin alınmalıdır.
