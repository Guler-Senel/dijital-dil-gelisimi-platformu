# Doğum tarihi gibi alanlarda date, zaman damgalarında datetime tipini kullanmak için içe aktarır.
from datetime import date, datetime
# JSON-benzeri esnek payload tipleri için Any tipini içe aktarır.
from typing import Any

# Pydantic model tabanı ve yardımcı doğrulama/konfigürasyon tiplerini içe aktarır.
from pydantic import BaseModel, ConfigDict, EmailStr

# Cinsiyet alanında modelle aynı enum'u kullanmak için Gender içe aktarılır.
from app.models import Gender


# Parent ile ilgili ortak giriş alanlarını tutan temel şema.
class ParentBase(BaseModel):
    # Kimlik sağlayıcıdaki kullanıcı ID'si.
    clerk_user_id: str
    # Geçerli e-posta formatında ebeveyn e-postası.
    email: EmailStr
    # Ebeveynin tam adı.
    full_name: str


# Parent oluşturma isteğinde kullanılacak şema (şimdilik ParentBase ile aynı).
class ParentCreate(ParentBase):
    pass


# Parent okuma/yanıt şeması (DB'den gelen alanları da içerir).
class ParentRead(ParentBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Ebeveyn kaydının ID'si.
    id: str
    # Kaydın oluşturulma zamanı.
    created_at: datetime
    # Kaydın son güncellenme zamanı.
    updated_at: datetime


# Child ile ilgili ortak alanları tutan temel şema.
class ChildBase(BaseModel):
    # Çocuğun adı.
    name: str
    # Çocuğun doğum tarihi.
    date_of_birth: date
    # Çocuğun cinsiyeti.
    gender: Gender
    # Çocuğun avatar URL'si (opsiyonel).
    avatar_url: str | None = None


# Child oluşturma isteğinde parent_id ekleyen şema.
class ChildCreate(ChildBase):
    # Çocuğun bağlı olduğu ebeveyn ID'si.
    parent_id: str


# Child okuma/yanıt şeması.
class ChildRead(ChildBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Çocuk kaydının ID'si.
    id: str
    # Ebeveyn ID'si.
    parent_id: str
    # Kaydın oluşturulma zamanı.
    created_at: datetime


# Egzersiz kategorileri için ortak alanları tutar.
class ExerciseCategoryBase(BaseModel):
    # Kategori adı.
    name: str
    # Kategori açıklaması (opsiyonel).
    description: str | None = None


# Egzersiz kategorisi oluşturma isteği şeması.
class ExerciseCategoryCreate(ExerciseCategoryBase):
    pass


# Egzersiz kategorisi yanıt şeması.
class ExerciseCategoryRead(ExerciseCategoryBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Kategori kaydının ID'si.
    id: str


# Egzersiz için ortak alanları tanımlar.
class ExerciseBase(BaseModel):
    # Egzersiz başlığı.
    title: str
    # Hedef minimum yaş (ay).
    target_age_months_min: int
    # Hedef maksimum yaş (ay).
    target_age_months_max: int
    # Egzersiz içeriğini taşıyan esnek JSON veri yapısı.
    content_payload: dict[str, Any]


# Egzersiz oluşturma isteğinde category_id alanını ekler.
class ExerciseCreate(ExerciseBase):
    # Egzersizin bağlı olduğu kategori ID'si.
    category_id: str


# Egzersiz okuma/yanıt şeması.
class ExerciseRead(ExerciseBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Egzersiz kaydının ID'si.
    id: str
    # Egzersizin bağlı olduğu kategori ID'si.
    category_id: str


# Değerlendirme kaydı için ortak alanları tanımlar.
class AssessmentLogBase(BaseModel):
    # Ses kaydı URL'si (opsiyonel).
    audio_recording_url: str | None = None
    # AI metin dökümü (opsiyonel).
    ai_transcription: str | None = None
    # Doğruluk puanı (opsiyonel).
    accuracy_score: float | None = None
    # Yanıt süresi milisaniye cinsinden (opsiyonel).
    response_time_ms: int | None = None


# Değerlendirme kaydı oluşturma şeması.
class AssessmentLogCreate(AssessmentLogBase):
    # Kaydın bağlı olduğu çocuk ID'si.
    child_id: str
    # Kaydın bağlı olduğu egzersiz ID'si.
    exercise_id: str


# Değerlendirme kaydı okuma/yanıt şeması.
class AssessmentLogRead(AssessmentLogBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Değerlendirme kaydının ID'si.
    id: str
    # Çocuk ID'si.
    child_id: str
    # Egzersiz ID'si.
    exercise_id: str
    # Tamamlanma zamanı.
    completed_at: datetime


# Gelişim kilometre taşı verisi için ortak alanlar.
class DevelopmentMilestoneBase(BaseModel):
    # Yaş (ay cinsinden).
    month_age: int
    # Beklenen kelime sayısı.
    expected_vocabulary_size: int
    # Beklenen gelişim davranışının metinsel açıklaması.
    milestone_description: str


# Milestone oluşturma isteği şeması.
class DevelopmentMilestoneCreate(DevelopmentMilestoneBase):
    pass


# Milestone okuma/yanıt şeması.
class DevelopmentMilestoneRead(DevelopmentMilestoneBase):
    # ORM nesnesinden model üretimine izin verir.
    model_config = ConfigDict(from_attributes=True)

    # Milestone kaydının ID'si.
    id: str
