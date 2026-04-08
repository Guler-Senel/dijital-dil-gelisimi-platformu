# ORM tablolarını oluşturmak için Base ve engine nesnelerini içe aktarır.
from app.database import Base, engine
# Model sınıflarının Base metadata içine kayıt edilmesi için import edilir.
import app.models  # noqa: F401


# Bu dosya doğrudan çalıştırıldığında tablo oluşturma işlemini başlatır.
if __name__ == "__main__":
    # Base'e kayıtlı tüm tabloları veritabanında oluşturur (yoksa oluşturur, varsa geçer).
    Base.metadata.create_all(bind=engine)
    # Konsola işlem tamamlandı bilgisi yazdırır.
    print("Veritabani ve tablolar olusturuldu.")
