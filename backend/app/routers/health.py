# FastAPI'de modüler endpoint grupları tanımlamak için APIRouter içe aktarılır.
from fastapi import APIRouter


# /health prefix'i ve health etiketiyle bir router nesnesi oluşturulur.
router = APIRouter(prefix="/health", tags=["health"])


# /health endpoint'i için GET metodu tanımlanır.
@router.get("")
# Servisin çalıştığını doğrulayan basit sağlık yanıtını döner.
def health_check() -> dict[str, str]:
    # Monitoring ve hızlı kontrol için kısa durum bilgisi verir.
    return {"status": "ok"}
