import certifi  # Sertifika doğrulaması için certifi kütüphanesini alır
import logging  # Uygulama loglarını yazdırmak için logging modülünü alır
import os  # Ortam değişkenlerini okumak için os modülünü kullanır
import ssl  # TLS/SSL bağlamını yapılandırmak için ssl modülünü alır
from typing import Any, List, Optional  # Tip açıklamaları için Any, List ve Optional tiplerini alır

from fastapi import FastAPI, HTTPException  # FastAPI uygulaması ve HTTP istisnaları için gerekli sınıflar
from fastapi.middleware.cors import CORSMiddleware  # CORS ara yazılımı eklemek için sınıfı alır
from motor.motor_asyncio import AsyncIOMotorClient  # MongoDB ile asenkron iletişim için Motor istemcisi
from pydantic import BaseModel  # Veri doğrulama için Pydantic BaseModel sınıfını içe aktarır
import uvicorn  # Uvicorn sunucusunu kod içinden başlatabilmek için import edilir

app = FastAPI(  # FastAPI uygulamasını başlatır
    title="KidLingua FastAPI Backend",  # API başlığını belirtir
    description="Çocuk eğitim uygulaması için temel backend API'si",  # API açıklamasını belirtir
    version="0.1.0"  # API sürüm numarasını belirtir
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Tüm kaynaklara izin verir, Xcode simülatörünün backend'e erişmesi için gerekli
    allow_credentials=True,  # Çerez ve kimlik doğrulama verilerine izin verir
    allow_methods=["*"],  # Tüm HTTP yöntemlerine izin verir
    allow_headers=["*"],  # Tüm başlıklara izin verir
)

# Uygulamayı 0.0.0.0 üzerinde çalıştırmak için terminalde aşağıdaki komutu kullanın:
# uvicorn main:app --host 0.0.0.0 --port 8001 --reload
# Bu yapılandırma Xcode simülatörünün yerel ağa erişebilmesini sağlar.

MONGODB_URI = os.getenv(
    "MONGODB_URI",
    "mongodb+srv://240541167:Direk714@yga.1fiz7v2.mongodb.net/?appName=YGA",
)  # Sağlanan MongoDB bağlantı URI'si; ortam değişkeniyle de geçilebilir
MONGO_DB_NAME = os.getenv("MONGO_DB_NAME", "kidlingua")  # Kullanılacak MongoDB veritabanı adı
MONGO_SERVER_SELECTION_TIMEOUT_MS = 5000  # MongoDB sunucu seçimi için zaman aşımı
mongo_client: Optional[AsyncIOMotorClient] = None  # Mongo istemcisini saklamaya hazır global değişken
mongo_db: Optional[Any] = None  # Mongo veritabanı bağlantısını saklamak için global değişken
logger = logging.getLogger(__name__)  # Uygulama içi hata ve durum logları için logger tanımlar

class Word(BaseModel):  # Kelime verisini tanımlayan Pydantic model sınıfı
    id: str  # Kelime kimliği
    name: str  # Kelime adı
    image_asset: str  # Kelime görsel adresi veya anahtarı
    category_emoji: str  # Kelime kategorisini gösteren emoji
    syllables: str  # Kelimenin hece yapısı

class Unit(BaseModel):  # Ders ünitesini tanımlayan Pydantic model sınıfı
    id: str  # Ünitenin benzersiz kimliği
    title: str  # Ünitenin başlığı
    progress_percent: int  # Ünitedeki ilerleme yüzdesi
    is_completed: bool  # Ünitenin tamamlanıp tamamlanmadığı durumu
    word_ids: List[str]  # Ünitede yer alan kelime kimlikleri listesi

class Story(BaseModel):  # Hikaye verisini tanımlayan Pydantic model sınıfı
    id: str  # Hikaye kimliği
    title: str  # Hikaye başlığı
    duration: str  # Hikaye süresi metin olarak
    image_asset: str  # Hikaye görsel adresi veya anahtarı
    is_completed: bool  # Hikayenin tamamlanıp tamamlanmadığı durumu
    is_new: bool  # Hikayenin yeni olup olmadığı durumu
    summary: str  # Hikaye özeti
    paragraphs: List[str]  # Hikaye metin parçalarının listesi

class Video(BaseModel):  # Video verisini tanımlayan Pydantic model sınıfı
    id: str  # Video kimliği
    title: str  # Video başlığı
    duration: str  # Video süresi metin olarak
    thumbnail_asset: str  # Video küçük resim adresi veya anahtarı
    category: str  # Video kategorisi metin olarak
    description: str  # Video açıklaması

class ParentTask(BaseModel):  # Ebeveyn görevini tanımlayan Pydantic model sınıfı
    id: str  # Görev kimliği
    kind: str  # Görev tipi (unit, video, story)
    title: str  # Görev başlığı
    completed: bool  # Görevin tamamlanma durumu
    unit_id: Optional[str] = None  # Ünite kimliği, varsa
    video_id: Optional[str] = None  # Video kimliği, varsa
    story_id: Optional[str] = None  # Hikaye kimliği, varsa

class TaskCreate(BaseModel):  # Yeni görev oluşturma isteği için Pydantic model sınıfı
    kind: str  # Görev tipi
    unit_id: Optional[str] = None  # Ünite kimliği, varsa
    video_id: Optional[str] = None  # Video kimliği, varsa
    story_id: Optional[str] = None  # Hikaye kimliği, varsa

class TaskUpdate(BaseModel):  # Görev güncelleme isteği için Pydantic model sınıfı
    completed: bool  # Görev tamamlanma durumunu güncellemek için alan

class PinUpdate(BaseModel):  # Ebeveyn PIN güncelleme isteği için model
    pin: str  # Yeni PIN değeri

DEFAULT_PARENT_PIN = "1234"  # Başlangıç ebeveyn PIN'i

words = [  # Uygulama için örnek kelime verilerini tanımlar
    Word(id="w1", name="Elma", image_asset="apple.png", category_emoji="🍎", syllables="el-ma"),
    Word(id="w2", name="Kedi", image_asset="cat.png", category_emoji="🐱", syllables="ke-di"),
    Word(id="w3", name="Üç", image_asset="three.png", category_emoji="🔢", syllables="üç"),
    Word(id="w4", name="Kare", image_asset="square.png", category_emoji="⬛", syllables="ka-re"),
]

units = [  # Uygulama için örnek ünite verilerini tanımlar
    Unit(id="u1", title="Renkler", progress_percent=75, is_completed=False, word_ids=["w1"]),
    Unit(id="u2", title="Hayvanlar", progress_percent=25, is_completed=False, word_ids=["w2"]),
    Unit(id="u3", title="Sayılar", progress_percent=10, is_completed=False, word_ids=["w3"]),
    Unit(id="u4", title="Şekiller", progress_percent=100, is_completed=True, word_ids=["w4"]),
]

stories = [  # Uygulama için örnek hikaye verilerini tanımlar
    Story(
        id="s1",
        title="Orman Macerası",
        duration="5 dakika",
        image_asset="forest_story.png",
        is_completed=False,
        is_new=True,
        summary="Küçük bir çocuğun ormanda yeni arkadaşlar bulması.",
        paragraphs=[
            "Küçük Ayşe sabah erkenden ormana gitti.",
            "Ormanda yeni bir dost buldu ve birlikte oynadılar.",
        ],
    ),
    Story(
        id="s2",
        title="Renkli Balonlar",
        duration="4 dakika",
        image_asset="balloons_story.png",
        is_completed=True,
        is_new=False,
        summary="Balonların gökyüzüne yolculuğu.",
        paragraphs=[
            "Şehirde herkes balonları izliyordu.",
            "Balonlar gökyüzünde dans ediyordu.",
        ],
    ),
]

videos = [  # Uygulama için örnek video verilerini tanımlar
    Video(
        id="v1",
        title="Hayvan Şarkısı",
        duration="3:20",
        thumbnail_asset="animals_video.png",
        category="songs",
        description="Hayvanları öğretici bir şarkı ile öğrenin.",
    ),
    Video(
        id="v2",
        title="Renkler Dersi",
        duration="4:10",
        thumbnail_asset="colors_video.png",
        category="lessons",
        description="Renkleri eğlenceli bir ders ile keşfedin.",
    ),
]

learning_stats = {  # Basit öğrenme istatistiklerini saklayan örnek veri nesnesi
    "daily_points": [8, 18, 6, 13],  # Günlük puan verileri
    "weekly_points": [45, 52, 49, 55, 60, 47, 50],  # Haftalık puan verileri
    "most_active_hour": "10:00-11:00",  # En aktif öğrenme saati
}

parent_tasks: List[ParentTask] = []  # Ebeveyn tarafından atanan görev listesini tutar


def _clean_document(document: dict) -> dict:
    document = dict(document)  # Motor dökümünü düzenlenebilir bir dict'e çevirir
    document.pop("_id", None)  # MongoDB nesne kimliğini kaldırır
    return document  # Temizlenmiş dokümanı döner


def _get_db_or_503():
    # Veritabanı bağlantısı yoksa uygulamayı düşürmeden 503 döndürmek için koruma sağlar.
    if mongo_db is None:
        raise HTTPException(status_code=503, detail="Veritabanı bağlantısı şu anda kullanılamıyor")
    return mongo_db


@app.on_event("startup")
async def startup_db_client():
    global mongo_client, mongo_db
    try:
        mongo_client = AsyncIOMotorClient(
            MONGODB_URI,
            tls=True,  # TLS bağlantısı kullanır
            tlsCAFile=certifi.where(),  # certifi kök sertifikası dosyasını kullanır
            tlsAllowInvalidCertificates=True,  # Geliştirme ortamında yerel sertifika hatalarını bypass eder
            serverSelectionTimeoutMS=MONGO_SERVER_SELECTION_TIMEOUT_MS,  # Sunucu seçimi zaman aşımı
        )  # MongoDB bağlantısını kurar
        mongo_db = mongo_client[MONGO_DB_NAME]  # Belirtilen veritabanını seçer

        await mongo_client.admin.command("ping")  # Bağlantının çalıştığını kontrol eder

        await mongo_db.parent_settings.update_one(
            {"type": "pin"},
            {"$setOnInsert": {"type": "pin", "pin": DEFAULT_PARENT_PIN}},
            upsert=True,
        )  # PIN belgesi yoksa varsayılan değerle oluşturur

        if await mongo_db.learning_stats.count_documents({}) == 0:
            await mongo_db.learning_stats.insert_one({"type": "global", **learning_stats})  # İstatistik koleksiyonunu başlatır

        if await mongo_db.words.count_documents({}) == 0:
            await mongo_db.words.insert_many([word.dict() for word in words])  # Örnek kelime verilerini MongoDB'ye yazar

        if await mongo_db.units.count_documents({}) == 0:
            await mongo_db.units.insert_many([unit.dict() for unit in units])  # Örnek ünite verilerini MongoDB'ye yazar

        if await mongo_db.stories.count_documents({}) == 0:
            await mongo_db.stories.insert_many([story.dict() for story in stories])  # Örnek hikaye verilerini MongoDB'ye yazar

        if await mongo_db.videos.count_documents({}) == 0:
            await mongo_db.videos.insert_many([video.dict() for video in videos])  # Örnek video verilerini MongoDB'ye yazar
    except Exception as error:
        mongo_db = None  # Bağlantı kurulamadığında API'nin ayakta kalması için db referansını sıfırlar
        logger.exception("MongoDB baglantisi basarisiz; uygulama calismaya devam ediyor: %s", error)  # Hata logunu detaylı basar


@app.on_event("shutdown")
async def shutdown_db_client():
    if mongo_client is not None:  # Mongo istemcisi varsa kapatır
        mongo_client.close()  # Veritabanı bağlantısını kapatır


@app.get("/health")  # Sağlık kontrolü için endpoint
def health():
    return {"status": "ok"}  # Sağlık durumunu JSON olarak döner


@app.get("/units", response_model=List[Unit])  # Tüm üniteleri listeleyen endpoint
async def get_units():
    db = _get_db_or_503()  # Bağlantı yoksa kontrollü şekilde 503 döndürür
    docs = await db.units.find().to_list(100)  # MongoDB'den ünite dokümanlarını alır
    return [Unit(**_clean_document(doc)) for doc in docs]  # Pydantic modeline çevirip döner

@app.post("/units", response_model=Unit, status_code=201)  # Yeni ünite ekleyen endpoint
async def create_unit(unit: Unit):
    existing = await mongo_db.units.find_one({"id": unit.id})  # Aynı kimliğe sahip ünite var mı diye kontrol eder
    if existing is not None:
        raise HTTPException(status_code=400, detail="Aynı id'ye sahip ünite zaten var")  # Çakışma varsa hata döner
    await mongo_db.units.insert_one(unit.dict())  # Yeni ünite verisini MongoDB'ye ekler
    return unit  # Eklenen üniteyi döner



@app.get("/units/{unit_id}", response_model=Unit)  # Belirli üniteyi getiren endpoint
async def get_unit(unit_id: str):
    doc = await mongo_db.units.find_one({"id": unit_id})  # Belirtilen id ile belgeyi arar
    if doc is None:
        raise HTTPException(status_code=404, detail="Ünite bulunamadı")  # Bulunamazsa 404 fırlatır
    return Unit(**_clean_document(doc))  # Eşleşen belgeyi döner


@app.get("/words", response_model=List[Word])  # Tüm kelimeleri listeleyen endpoint
async def get_words():
    db = _get_db_or_503()  # Bağlantı yoksa kontrollü şekilde 503 döndürür
    docs = await db.words.find().to_list(100)  # Tüm kelime verilerini MongoDB'den alır
    return [Word(**_clean_document(doc)) for doc in docs]  # Pydantic model listesi olarak döner

@app.post("/words", response_model=Word, status_code=201)  # Yeni kelime ekleyen endpoint
async def create_word(word: Word):
    existing = await mongo_db.words.find_one({"id": word.id})  # Aynı kimliğe sahip kelime var mı diye kontrol eder
    if existing is not None:
        raise HTTPException(status_code=400, detail="Aynı id'ye sahip kelime zaten var")  # Çakışma varsa hata döner
    await mongo_db.words.insert_one(word.dict())  # Yeni kelime verisini MongoDB'ye ekler
    return word  # Eklenen kelimeyi döner



@app.get("/words/{word_id}", response_model=Word)  # Belirli kelimeyi getiren endpoint
async def get_word(word_id: str):
    doc = await mongo_db.words.find_one({"id": word_id})  # İstenen kelime id'sini arar
    if doc is None:
        raise HTTPException(status_code=404, detail="Kelime bulunamadı")  # Yoksa 404 döner
    return Word(**_clean_document(doc))  # Eşleşen kelimeyi döner


@app.get("/stories", response_model=List[Story])  # Tüm hikayeleri listeleyen endpoint
async def get_stories():
    db = _get_db_or_503()  # Bağlantı yoksa kontrollü şekilde 503 döndürür
    docs = await db.stories.find().to_list(100)  # Hikaye dokümanlarını alır
    return [Story(**_clean_document(doc)) for doc in docs]  # Hikaye model listesi döner

@app.post("/stories", response_model=Story, status_code=201)  # Yeni hikaye ekleyen endpoint
async def create_story(story: Story):
    existing = await mongo_db.stories.find_one({"id": story.id})  # Aynı kimliğe sahip hikaye var mı diye kontrol eder
    if existing is not None:
        raise HTTPException(status_code=400, detail="Aynı id'ye sahip hikaye zaten var")  # Çakışma varsa hata döner
    await mongo_db.stories.insert_one(story.dict())  # Yeni hikaye verisini MongoDB'ye ekler
    return story  # Eklenen hikayeyi döner



@app.get("/stories/{story_id}", response_model=Story)  # Belirli hikayeyi getiren endpoint
async def get_story(story_id: str):
    doc = await mongo_db.stories.find_one({"id": story_id})  # Belirtilen id ile hikaye arar
    if doc is None:
        raise HTTPException(status_code=404, detail="Hikaye bulunamadı")  # Yoksa 404 döner
    return Story(**_clean_document(doc))  # Eşleşeni döner


@app.get("/videos", response_model=List[Video])  # Tüm videoları listeleyen endpoint
async def get_videos(category: Optional[str] = None):
    db = _get_db_or_503()  # Bağlantı yoksa kontrollü şekilde 503 döndürür
    query = {} if category is None else {"category": category}  # Filtreleme sorgusunu hazırlar
    docs = await db.videos.find(query).to_list(100)  # MongoDB'den film listelemesini alır
    return [Video(**_clean_document(doc)) for doc in docs]  # Pydantic model listesi döner

@app.post("/videos", response_model=Video, status_code=201)  # Yeni video ekleyen endpoint
async def create_video(video: Video):
    existing = await mongo_db.videos.find_one({"id": video.id})  # Aynı kimliğe sahip video var mı diye kontrol eder
    if existing is not None:
        raise HTTPException(status_code=400, detail="Aynı id'ye sahip video zaten var")  # Çakışma varsa hata döner
    await mongo_db.videos.insert_one(video.dict())  # Yeni video verisini MongoDB'ye ekler
    return video  # Eklenen videoyu döner



@app.get("/videos/{video_id}", response_model=Video)  # Belirli videoyu getiren endpoint
async def get_video(video_id: str):
    doc = await mongo_db.videos.find_one({"id": video_id})  # İstenen video id'sini arar
    if doc is None:
        raise HTTPException(status_code=404, detail="Video bulunamadı")  # Yoksa 404 döner
    return Video(**_clean_document(doc))  # Eşleşeni döner


@app.get("/parent/tasks", response_model=List[ParentTask])  # Ebeveyn görevlerini listeleyen endpoint
async def get_parent_tasks():
    db = _get_db_or_503()  # Bağlantı yoksa kontrollü şekilde 503 döndürür
    docs = await db.parent_tasks.find().to_list(100)  # Ebeveyn görevlerini MongoDB'den alır
    return [ParentTask(**_clean_document(doc)) for doc in docs]  # Model listesi olarak döner


if __name__ == "__main__":
    # Yerel ağdan (simülatör dahil) erişim için varsayılan host/port değerleri burada tanımlanır.
    uvicorn.run("main:app", host="0.0.0.0", port=int(os.getenv("PORT", "8001")), reload=True)


@app.post("/parent/tasks", response_model=ParentTask, status_code=201)  # Yeni görev ekleyen endpoint
async def create_parent_task(task: TaskCreate):
    if task.kind not in {"unit", "video", "story"}:  # Geçerli görev tipini sınar
        raise HTTPException(status_code=400, detail="Geçersiz görev türü")  # Hatalı istekse 400 döner
    task_id = f"task_{int(await mongo_db.parent_tasks.count_documents({})) + 1}"  # Yeni görev için benzersiz kimlik oluşturur
    title = ""
    if task.kind == "unit":
        title = f"Ünite: {task.unit_id}"
    elif task.kind == "video":
        title = f"Video: {task.video_id}"
    else:
        title = f"Hikaye: {task.story_id}"
    task_data = {
        "id": task_id,
        "kind": task.kind,
        "title": title,
        "completed": False,
        "unit_id": task.unit_id,
        "video_id": task.video_id,
        "story_id": task.story_id,
    }
    await mongo_db.parent_tasks.insert_one(task_data)  # Yeni görevi MongoDB'ye kaydeder
    return ParentTask(**task_data)  # Oluşturulan görevi döner


@app.put("/parent/tasks/{task_id}", response_model=ParentTask)  # Görev tamamlanma durumunu güncelleyen endpoint
async def update_parent_task(task_id: str, payload: TaskUpdate):
    result = await mongo_db.parent_tasks.update_one(
        {"id": task_id},
        {"$set": {"completed": payload.completed}},
    )  # Görev durumunu MongoDB'de günceller
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Görev bulunamadı")  # Yoksa 404 döner
    doc = await mongo_db.parent_tasks.find_one({"id": task_id})  # Güncellenmiş görevi alır
    return ParentTask(**_clean_document(doc))  # Döner


@app.get("/learning-stats")  # Öğrenme istatistiklerini getiren endpoint
async def get_learning_stats():
    doc = await mongo_db.learning_stats.find_one({"type": "global"}, {"_id": 0, "type": 0})  # İstatistikleri alır
    return doc if doc is not None else learning_stats  # Bulunmazsa varsayılan değeri döner


@app.get("/parent/pin")  # Mevcut ebeveyn PIN'ini dönen endpoint
async def get_parent_pin():
    doc = await mongo_db.parent_settings.find_one({"type": "pin"}, {"_id": 0, "pin": 1})  # PIN belgesini alır
    return {"pin": doc["pin"] if doc is not None else DEFAULT_PARENT_PIN}  # PIN'i döner


@app.put("/parent/pin")  # Ebeveyn PIN'ini güncelleyen endpoint
async def update_parent_pin(payload: PinUpdate):
    if len(payload.pin) < 4:  # PIN uzunluğunu minimum kontrol eder
        raise HTTPException(status_code=400, detail="PIN en az 4 haneli olmalıdır")  # Hatalı PIN ise 400 döner
    await mongo_db.parent_settings.update_one(
        {"type": "pin"},
        {"$set": {"pin": payload.pin}},
        upsert=True,
    )  # Yeni PIN değerini MongoDB'ye yazar
    return {"pin": payload.pin}  # Güncellenmiş PIN'i döner

