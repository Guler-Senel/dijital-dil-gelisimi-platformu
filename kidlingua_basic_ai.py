
#  KELİME ZORLUK MANTIĞI


def difficulty_to_level(difficulty, syllable_count):
    """
    JSON dosyasındaki difficulty alanını sayısal seviyeye çevirir.

    kolay -> 1
    orta  -> 2
    zor   -> 3

    Ek basit mantık:
    Eğer kelime 4 veya daha fazla heceliyse biraz daha zor kabul edilir.
    """

    difficulty = difficulty.lower().strip()

    if difficulty == "kolay":
        level = 1
    elif difficulty == "orta":
        level = 2
    elif difficulty == "zor":
        level = 3
    else:
        level = 1

    # Hece sayısı çok fazlaysa zorluk biraz artırılır
    if syllable_count >= 4 and level < 3:
        level += 1

    return level


#  KELİMELERİ DÜZ LİSTEYE ÇEVİRME

def extract_words(words_data):
    """
    JSON yapısı şu şekilde:
    ageGroups -> units -> words

    Bu fonksiyon tüm kelimeleri tek listeye çevirir.
    Böylece algoritma daha kolay çalışır.
    """

    all_words = []

    age_groups = words_data.get("ageGroups", [])

    for age_group in age_groups:
        age_range = age_group.get("ageRange")

        for unit in age_group.get("units", []):
            unit_id = unit.get("unitId")
            unit_title = unit.get("title")

            for word in unit.get("words", []):
                syllable_count = word.get("syllableCountApprox", 1)
                difficulty = word.get("difficulty", "kolay")

                clean_word = {
                    "id": word.get("id"),
                    "text": word.get("text"),
                    "ageRange": age_range,
                    "unitId": unit_id,
                    "unitTitle": unit_title,
                    "category": word.get("category"),
                    "difficulty": difficulty,
                    "difficultyLevel": difficulty_to_level(difficulty, syllable_count),
                    "syllableCount": syllable_count,
                    "imageFile": word.get("imageFile"),
                    "audioFile": word.get("audioFile")
                }

                all_words.append(clean_word)

    return all_words


# HİKAYELERİ ALMA

def extract_stories(stories_data):
    """
    Hikaye dosyasındaki internalOriginalStoryPlan listesini alır.
    Bu liste bizim kendi özgün hikayelerimizi temsil eder.
    """

    return stories_data.get("internalOriginalStoryPlan", [])


#  VİDEOLARI ALMA

def extract_videos(videos_data):
    """
    Video dosyasında yapı şu şekilde:
    videosByAgeRange -> 0-3 / 3-6 / 6-10

    Bu fonksiyon tüm videoları tek listeye çevirir.
    """

    all_videos = []

    videos_by_age = videos_data.get("videosByAgeRange", {})

    for age_range, video_list in videos_by_age.items():
        for video in video_list:
            video["ageRange"] = age_range
            all_videos.append(video)

    return all_videos


#  GÜNLÜK KELİME SEÇME

def select_daily_words(words, age_range, child_level, daily_count):
    """
    Çocuğun yaş grubuna ve seviyesine göre günlük kelime seçer.

    Örnek:
    age_range = "3-6"
    child_level = 1
    daily_count = 5

    Mantık:
    - Sadece çocuğun yaş grubundaki kelimeler alınır.
    - Çocuğun seviyesine uygun kelimeler seçilir.
    - Rastgele günlük kelime listesi oluşturulur.
    """

    suitable_words = []

    for word in words:
        same_age = word["ageRange"] == age_range
        suitable_level = word["difficultyLevel"] <= child_level

        if same_age and suitable_level:
            suitable_words.append(word)

    # Eğer seçilecek kelime azsa aynı yaş grubundaki tüm kelimelerden seç
    if len(suitable_words) < daily_count:
        suitable_words = [
            word for word in words
            if word["ageRange"] == age_range
        ]

    random.shuffle(suitable_words)

    return suitable_words[:daily_count]


#  SEVİYE GÜNCELLEME

def update_child_level(current_level, correct_answers, total_questions):
    """
    Çocuğun doğru cevap oranına göre seviyeyi günceller.

    Basit kural:
    - Başarı %80 veya üzeriyse seviye artar.
    - Başarı %40 veya altındaysa seviye düşer.
    - Diğer durumlarda seviye aynı kalır.
    """

    if total_questions == 0:
        return current_level, 0, "Soru çözülmediği için seviye değişmedi."

    success_rate = (correct_answers / total_questions) * 100

    if success_rate >= 80 and current_level < 3:
        new_level = current_level + 1
        message = "Başarı yüksek. Seviye artırıldı."
    elif success_rate <= 40 and current_level > 1:
        new_level = current_level - 1
        message = "Başarı düşük. Seviye düşürüldü."
    else:
        new_level = current_level
        message = "Seviye aynı kaldı."

    return new_level, success_rate, message


#  HİKAYE ÖNERME

def recommend_story(stories, age_range, selected_words):
    """
    Seçilen günlük kelimelerle ilişkili bir hikaye önerir.

    Mantık:
    - Hikaye yaş grubu aynı olmalı.
    - Hikayenin targetWords listesinde günlük kelimelerden biri geçerse önerilir.
    """

    selected_word_texts = []

    for word in selected_words:
        selected_word_texts.append(word["text"])

    best_story = None
    best_score = 0

    for story in stories:
        if story.get("ageRange") != age_range:
            continue

        target_words = story.get("targetWords", [])

        score = 0

        for word_text in selected_word_texts:
            if word_text in target_words:
                score += 1

        if score > best_score:
            best_score = score
            best_story = story

    return best_story, best_score


# 1 VİDEO ÖNERME

def recommend_video(videos, age_range, selected_words):
    """
    Seçilen kelimelerin kategorilerine göre basit video önerir.

    Mantık:
    - Video yaş grubu aynı olmalı.
    - Kelime kategorisi video targetSkills içinde geçiyorsa video önerilir.
    """

    selected_categories = []

    for word in selected_words:
        category = word["category"].lower()
        selected_categories.append(category)

    best_video = None
    best_score = 0

    for video in videos:
        if video.get("ageRange") != age_range:
            continue

        target_skills = video.get("targetSkills", [])

        score = 0

        for category in selected_categories:
            for skill in target_skills:
                skill = skill.lower()

                if category in skill or skill in category:
                    score += 1

        if score > best_score:
            best_score = score
            best_video = video

    return best_video, best_score


#  ANA PROGRAM

def main():
    print("KidLingua Basit AI / NLP Modülü Başladı\n")

    # JSON dosyalarını oku
    words_data = load_json(WORDS_FILE)
    stories_data = load_json(STORIES_FILE)
    videos_data = load_json(VIDEOS_FILE)

    # Verileri düz listeye çevir
    words = extract_words(words_data)
    stories = extract_stories(stories_data)
    videos = extract_videos(videos_data)

    print(f"Toplam kelime sayısı: {len(words)}")
    print(f"Toplam hikaye sayısı: {len(stories)}")
    print(f"Toplam video sayısı: {len(videos)}")

    print("\n-----------------------------------")

    # Örnek çocuk profili
    child_age_range = "3-6"
    child_level = 1
    daily_count = 5

    print("Çocuk Profili")
    print(f"Yaş grubu: {child_age_range}")
    print(f"Mevcut seviye: {child_level}")
    print(f"Günlük kelime hedefi: {daily_count}")

    print("\n-----------------------------------")

    # Günlük kelime seç
    daily_words = select_daily_words(
        words=words,
        age_range=child_age_range,
        child_level=child_level,
        daily_count=daily_count
    )

    print("Bugün Seçilen Kelimeler:")

    for word in daily_words:
        print(
            f"- {word['text']} | "
            f"Ünite: {word['unitTitle']} | "
            f"Kategori: {word['category']} | "
            f"Zorluk: {word['difficulty']} | "
            f"Seviye: {word['difficultyLevel']}"
        )

    print("\n-----------------------------------")

    # Örnek cevap sonucu
    # Diyelim çocuk 5 sorudan 4 tanesini doğru yaptı
    correct_answers = 4
    total_questions = 5

    new_level, success_rate, message = update_child_level(
        current_level=child_level,
        correct_answers=correct_answers,
        total_questions=total_questions
    )

    print("Seviye Güncelleme Sonucu")
    print(f"Doğru cevap: {correct_answers}/{total_questions}")
    print(f"Başarı oranı: %{success_rate:.1f}")
    print(f"Yeni seviye: {new_level}")
    print(f"Mesaj: {message}")

    print("\n-----------------------------------")

    # Hikaye öner
    story, story_score = recommend_story(
        stories=stories,
        age_range=child_age_range,
        selected_words=daily_words
    )

    print("Önerilen Hikaye")

    if story:
        print(f"Hikaye adı: {story.get('title')}")
        print(f"Yaş grubu: {story.get('ageRange')}")
        print(f"Hedef kelimeler: {story.get('targetWords')}")
        print(f"Ses dosyası: {story.get('audioFile')}")
        print(f"Eşleşme skoru: {story_score}")
    else:
        print("Uygun hikaye bulunamadı.")

    print("\n-----------------------------------")

    # Video öner
    video, video_score = recommend_video(
        videos=videos,
        age_range=child_age_range,
        selected_words=daily_words
    )

    print("Önerilen Video")

    if video:
        print(f"Video adı: {video.get('title')}")
        print(f"Kategori: {video.get('category')}")
        print(f"Kaynak: {video.get('sourceOwner')}")
        print(f"Link: {video.get('sourceUrl')}")
        print(f"Eşleşme skoru: {video_score}")
    else:
        print("Uygun video bulunamadı.")

    print("\n-----------------------------------")
    print("Program bitti.")


if __name__ == "__main__":
    main()
