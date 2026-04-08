# FastAPI uygulamasını oluşturmak için gerekli sınıfı içe aktarır.
from fastapi import FastAPI

# Sağlık kontrol endpoint'lerini bu dosyaya bağlamak için router'ı içe aktarır.
from app.routers.health import router as health_router


# Uygulamanın ana FastAPI nesnesini başlık ve sürüm bilgisiyle oluşturur.
app = FastAPI(title="KidLingua Backend", version="0.1.0")
# Health router'ını ana uygulamaya ekler.
app.include_router(health_router)


# Kök URL (/) için GET endpoint tanımlar.
@app.get("/")
# Kök endpoint çağrıldığında dönecek mesajı üretir.
def root() -> dict[str, str]:
    # API ayakta mı hızlıca test etmek için basit bir cevap döner.
    return {"message": "KidLingua backend is running"}
