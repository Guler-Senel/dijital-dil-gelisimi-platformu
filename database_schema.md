Sen uzman bir Backend Geliştiricisin. Aşağıdaki veritabanı şemasını incele ve bana *FastAPI* (Python) ve *SQLAlchemy* (veya SQLModel) kullanarak veritabanı modellerini (models), Pydantic şemalarını (schemas) ve temiz bir klasör mimarisiyle (routers, models, schemas, database.py vb.) temel yapıyı oluştur.

*PROJE BAĞLAMI VE KURALLAR:*
1.⁠ ⁠Bu, çocukların dil gelişimini ölçen bir mobil uygulamanın backend'idir. (Mobil taraf Flutter ile geliştiriliyor).
2.⁠ ⁠Kimlik doğrulama (Auth) işlemleri *Clerk* üzerinden yapılacaktır. Kendi veritabanımızda şifre (password_hash) TUTMUYORUZ. ⁠ Parents ⁠ tablosundaki ⁠ clerk_user_id ⁠, Clerk entegrasyonu için tek eşleştirme anahtarımızdır. Modelleri buna göre kurgula.
3.⁠ ⁠İlerleyen aşamalarda ⁠ AssessmentLogs ⁠ (değerlendirme kayıtları) tablosu üzerinden, çocuğun ses kayıtlarını alıp Whisper API gibi yapay zeka ses işleme servisleriyle analiz edeceğiz. Bu yüzden proje mimarisini servis (services) katmanı eklemeye uygun ve modüler kur.

*VERİTABANI ŞEMASI:*

# 1. Parents (Ebeveynler)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠clerk_user_id (String, Unique, Index) - Clerk'ten gelen ID
•⁠  ⁠email (String, Unique)
•⁠  ⁠full_name (String)
•⁠  ⁠created_at (Timestamp)
•⁠  ⁠updated_at (Timestamp)

# 2. Children (Çocuklar)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠parent_id (UUID, Foreign Key -> Parents.id)
•⁠  ⁠name (String)
•⁠  ⁠date_of_birth (Date)
•⁠  ⁠gender (Enum: MALE, FEMALE, OTHER)
•⁠  ⁠avatar_url (String, Nullable)
•⁠  ⁠created_at (Timestamp)

# 3. ExerciseCategories (Egzersiz Kategorileri)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠name (String)
•⁠  ⁠description (Text, Nullable)

# 4. Exercises (Egzersizler/Görevler)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠category_id (UUID, Foreign Key -> ExerciseCategories.id)
•⁠  ⁠title (String)
•⁠  ⁠target_age_months_min (Integer)
•⁠  ⁠target_age_months_max (Integer)
•⁠  ⁠content_payload (JSON) - Gösterilecek resim, beklenen kelime vb.

# 5. AssessmentLogs (Değerlendirme Kayıtları)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠child_id (UUID, Foreign Key -> Children.id)
•⁠  ⁠exercise_id (UUID, Foreign Key -> Exercises.id)
•⁠  ⁠audio_recording_url (String, Nullable)
•⁠  ⁠ai_transcription (String, Nullable) - Speech-to-Text sonucu
•⁠  ⁠accuracy_score (Float, Nullable) - Telaffuz doğruluk puanı
•⁠  ⁠response_time_ms (Integer, Nullable)
•⁠  ⁠completed_at (Timestamp)

# 6. DevelopmentMilestones (Gelişim Dönüm Noktaları)
•⁠  ⁠id (UUID, Primary Key)
•⁠  ⁠month_age (Integer) - Ör: 24 aylık
•⁠  ⁠expected_vocabulary_size (Integer)
•⁠  ⁠milestone_description (Text)

*İLİŞKİLER:*
•⁠  ⁠Parent -> Child: One-to-Many
•⁠  ⁠Child -> AssessmentLog: One-to-Many
•⁠  ⁠ExerciseCategory -> Exercise: One-to-Many
•⁠  ⁠Exercise -> AssessmentLog: One-to-Many

Lütfen adım adım ilerle. Önce klasör yapısını planla, ardından ⁠ database.py ⁠, ⁠ models.py ⁠ ve ⁠ schemas.py ⁠ dosyalarını yaz.