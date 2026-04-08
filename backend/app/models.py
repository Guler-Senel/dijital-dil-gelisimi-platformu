# Python enum tanımları için enum modülünü içe aktarır.
import enum
# UUID tabanlı benzersiz kimlik üretmek için uuid modülünü içe aktarır.
import uuid
# Tarih/saat alanlarının tipleri için datetime sınıfını içe aktarır.
from datetime import datetime

# SQLAlchemy kolon tiplerini ve ForeignKey tanımlarını içe aktarır.
from sqlalchemy import JSON, Date, DateTime, Enum, Float, ForeignKey, Integer, String, Text
# SQLAlchemy 2.0 stilinde typed mapping ve ilişki tanımları için araçları içe aktarır.
from sqlalchemy.orm import Mapped, mapped_column, relationship
# Veritabanı tarafında now() gibi fonksiyonları kullanmak için func içe aktarılır.
from sqlalchemy.sql import func

# Tüm modellerin kalıtım alacağı ortak Base sınıfını içe aktarır.
from app.database import Base


# Cinsiyet bilgisini sabit ve doğrulanabilir tutmak için enum tanımı.
class Gender(str, enum.Enum):
    # Erkek seçeneği.
    MALE = "MALE"
    # Kadın seçeneği.
    FEMALE = "FEMALE"
    # Diğer seçeneği.
    OTHER = "OTHER"


# Sistemdeki ebeveynleri tutan tablo modeli.
class Parent(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "parents"

    # Ebeveynin birincil anahtarı (UUID string).
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Clerk kimlik sağlayıcısındaki kullanıcı ID'si (benzersiz ve indeksli).
    clerk_user_id: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    # Ebeveyn e-posta adresi (benzersiz ve zorunlu).
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    # Ebeveynin tam adı.
    full_name: Mapped[str] = mapped_column(String(255), nullable=False)
    # Kaydın oluşturulma zamanı (DB tarafında otomatik atanır).
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    # Kaydın son güncellenme zamanı (her update'de yenilenir).
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False
    )

    # Bu ebeveyne ait çocuk kayıtlarıyla bire-çok ilişki.
    children: Mapped[list["Child"]] = relationship(
        back_populates="parent",
        cascade="all, delete-orphan",
    )


# Sistemdeki çocukları tutan tablo modeli.
class Child(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "children"

    # Çocuğun birincil anahtarı (UUID string).
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Çocuğun bağlı olduğu ebeveyn ID'si (silmede cascade).
    parent_id: Mapped[str] = mapped_column(String(36), ForeignKey("parents.id", ondelete="CASCADE"), nullable=False)
    # Çocuğun adı.
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    # Çocuğun doğum tarihi.
    date_of_birth: Mapped[datetime] = mapped_column(Date, nullable=False)
    # Çocuğun cinsiyet bilgisi.
    gender: Mapped[Gender] = mapped_column(Enum(Gender), nullable=False)
    # Opsiyonel avatar görsel URL'si.
    avatar_url: Mapped[str | None] = mapped_column(String(2048), nullable=True)
    # Çocuk kaydının oluşturulma zamanı.
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    # Çocuğun ebeveyn kaydına geri referansı.
    parent: Mapped["Parent"] = relationship(back_populates="children")
    # Çocuğa ait değerlendirme kayıtlarıyla bire-çok ilişki.
    assessment_logs: Mapped[list["AssessmentLog"]] = relationship(
        back_populates="child",
        cascade="all, delete-orphan",
    )


# Egzersizleri kategorize etmek için kategori tablosu modeli.
class ExerciseCategory(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "exercise_categories"

    # Kategorinin birincil anahtarı.
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Kategori adı.
    name: Mapped[str] = mapped_column(String(120), nullable=False)
    # Kategori açıklaması (opsiyonel).
    description: Mapped[str | None] = mapped_column(Text, nullable=True)

    # Kategori altında bulunan egzersizlerle bire-çok ilişki.
    exercises: Mapped[list["Exercise"]] = relationship(
        back_populates="category",
        cascade="all, delete-orphan",
    )


# Uygulamada sunulan egzersiz içeriklerini tutan model.
class Exercise(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "exercises"

    # Egzersizin birincil anahtarı.
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Egzersizin ait olduğu kategori ID'si.
    category_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("exercise_categories.id", ondelete="CASCADE"),
        nullable=False,
    )
    # Egzersiz başlığı.
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    # Hedef minimum yaş (ay cinsinden).
    target_age_months_min: Mapped[int] = mapped_column(Integer, nullable=False)
    # Hedef maksimum yaş (ay cinsinden).
    target_age_months_max: Mapped[int] = mapped_column(Integer, nullable=False)
    # Egzersiz içeriğini esnek JSON formatında saklar.
    content_payload: Mapped[dict] = mapped_column(JSON, nullable=False)

    # Egzersizin kategoriye geri referansı.
    category: Mapped["ExerciseCategory"] = relationship(back_populates="exercises")
    # Egzersize ait değerlendirme kayıtları.
    assessment_logs: Mapped[list["AssessmentLog"]] = relationship(back_populates="exercise")


# Çocukların egzersiz performans kayıtlarını tutan model.
class AssessmentLog(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "assessment_logs"

    # Değerlendirme kaydının birincil anahtarı.
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Kaydın bağlı olduğu çocuk ID'si.
    child_id: Mapped[str] = mapped_column(String(36), ForeignKey("children.id", ondelete="CASCADE"), nullable=False)
    # Kaydın bağlı olduğu egzersiz ID'si.
    exercise_id: Mapped[str] = mapped_column(String(36), ForeignKey("exercises.id", ondelete="CASCADE"), nullable=False)
    # Çocuğun ses kaydı URL'si (opsiyonel).
    audio_recording_url: Mapped[str | None] = mapped_column(String(2048), nullable=True)
    # AI tarafından oluşturulan metin dökümü (opsiyonel).
    ai_transcription: Mapped[str | None] = mapped_column(Text, nullable=True)
    # Doğruluk puanı (opsiyonel).
    accuracy_score: Mapped[float | None] = mapped_column(Float, nullable=True)
    # Yanıt süresi (milisaniye, opsiyonel).
    response_time_ms: Mapped[int | None] = mapped_column(Integer, nullable=True)
    # Egzersizin tamamlandığı zaman.
    completed_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    # Kayıt ile çocuk arasındaki ORM ilişkisi.
    child: Mapped["Child"] = relationship(back_populates="assessment_logs")
    # Kayıt ile egzersiz arasındaki ORM ilişkisi.
    exercise: Mapped["Exercise"] = relationship(back_populates="assessment_logs")


# Dil gelişim hedeflerini yaşa göre saklayan model.
class DevelopmentMilestone(Base):
    # Bu modelin bağlı olduğu fiziksel tablo adı.
    __tablename__ = "development_milestones"

    # Milestone kaydının birincil anahtarı.
    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    # Beklentinin ait olduğu yaş (ay cinsinden, indeksli).
    month_age: Mapped[int] = mapped_column(Integer, nullable=False, index=True)
    # Beklenen kelime dağarcığı büyüklüğü.
    expected_vocabulary_size: Mapped[int] = mapped_column(Integer, nullable=False)
    # Bu yaş aralığı için açıklayıcı gelişim hedef metni.
    milestone_description: Mapped[str] = mapped_column(Text, nullable=False)
