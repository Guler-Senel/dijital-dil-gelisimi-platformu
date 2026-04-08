# get_db fonksiyonunun dönüş tipi için Generator tipini içe aktarır.
from collections.abc import Generator
# Ortam değişkenlerinden veritabanı URL'si okumak için os modülünü içe aktarır.
import os

# SQLAlchemy motoru (engine) oluşturmak için create_engine fonksiyonunu içe aktarır.
from sqlalchemy import create_engine
# Session, Base sınıfı ve session factory için gerekli ORM araçlarını içe aktarır.
from sqlalchemy.orm import Session, declarative_base, sessionmaker


# Önce ortam değişkenindeki DATABASE_URL'i okur, yoksa SQLite dosyasını varsayılan kullanır.
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./kidlingua.db")

# SQLite kullanılıyorsa tek thread kısıtını gevşeten bağlantı ayarını belirler.
connect_args = {"check_same_thread": False} if DATABASE_URL.startswith("sqlite") else {}

# Veritabanı motorunu URL ve bağlantı ayarlarıyla oluşturur.
engine = create_engine(DATABASE_URL, connect_args=connect_args)
# Veritabanı oturumları üretmek için Session factory oluşturur.
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
# Tüm ORM modellerinin miras alacağı Base sınıfını üretir.
Base = declarative_base()


# Her API isteği için aç-kullan-kapat mantığında DB oturumu sağlayan dependency fonksiyonudur.
def get_db() -> Generator[Session, None, None]:
    # Yeni bir veritabanı oturumu açar.
    db = SessionLocal()
    try:
        # Endpoint içinde kullanılmak üzere oturumu dışarıya verir.
        yield db
    finally:
        # İş bittikten sonra bağlantı sızıntısı olmaması için oturumu kapatır.
        db.close()
