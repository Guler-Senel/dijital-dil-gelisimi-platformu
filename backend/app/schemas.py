from datetime import date, datetime
from typing import Any

from pydantic import BaseModel, ConfigDict, EmailStr

from app.models import Gender


class ParentBase(BaseModel):
    clerk_user_id: str
    email: EmailStr
    full_name: str


class ParentCreate(ParentBase):
    pass


class ParentRead(ParentBase):
    model_config = ConfigDict(from_attributes=True)

    id: str
    created_at: datetime
    updated_at: datetime


class ChildBase(BaseModel):
    name: str
    date_of_birth: date
    gender: Gender
    avatar_url: str | None = None


class ChildCreate(ChildBase):
    parent_id: str


class ChildRead(ChildBase):
    model_config = ConfigDict(from_attributes=True)

    id: str
    parent_id: str
    created_at: datetime


class ExerciseCategoryBase(BaseModel):
    name: str
    description: str | None = None


class ExerciseCategoryCreate(ExerciseCategoryBase):
    pass


class ExerciseCategoryRead(ExerciseCategoryBase):
    model_config = ConfigDict(from_attributes=True)

    id: str


class ExerciseBase(BaseModel):
    title: str
    target_age_months_min: int
    target_age_months_max: int
    content_payload: dict[str, Any]


class ExerciseCreate(ExerciseBase):
    category_id: str


class ExerciseRead(ExerciseBase):
    model_config = ConfigDict(from_attributes=True)

    id: str
    category_id: str


class AssessmentLogBase(BaseModel):
    audio_recording_url: str | None = None
    ai_transcription: str | None = None
    accuracy_score: float | None = None
    response_time_ms: int | None = None


class AssessmentLogCreate(AssessmentLogBase):
    child_id: str
    exercise_id: str


class AssessmentLogRead(AssessmentLogBase):
    model_config = ConfigDict(from_attributes=True)

    id: str
    child_id: str
    exercise_id: str
    completed_at: datetime


class DevelopmentMilestoneBase(BaseModel):
    month_age: int
    expected_vocabulary_size: int
    milestone_description: str


class DevelopmentMilestoneCreate(DevelopmentMilestoneBase):
    pass


class DevelopmentMilestoneRead(DevelopmentMilestoneBase):
    model_config = ConfigDict(from_attributes=True)

    id: str
