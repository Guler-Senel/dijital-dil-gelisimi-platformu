from fastapi import FastAPI

from app.routers.health import router as health_router


app = FastAPI(title="KidLingua Backend", version="0.1.0")
app.include_router(health_router)


@app.get("/")
def root() -> dict[str, str]:
    return {"message": "KidLingua backend is running"}
