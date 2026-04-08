import enum
import uuid
from datetime import datetime

from sqlalchemy import JSON, Date, DateTime, Enum, Float, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.database import Base


class Gender(str, enum.Enum):
    MALE = "MALE"
    FEMALE = "FEMALE"
    OTHER = "OTHER"


class Parent(Base):
    __tablename__ = "parents"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    clerk_user_id: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    full_name: Mapped[str] = mapped_column(String(255), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False
    )

    children: Mapped[list["Child"]] = relationship(
        back_populates="parent",
        cascade="all, delete-orphan",
    )


class Child(Base):
    __tablename__ = "children"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    parent_id: Mapped[str] = mapped_column(String(36), ForeignKey("parents.id", ondelete="CASCADE"), nullable=False)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    date_of_birth: Mapped[datetime] = mapped_column(Date, nullable=False)
    gender: Mapped[Gender] = mapped_column(Enum(Gender), nullable=False)
    avatar_url: Mapped[str | None] = mapped_column(String(2048), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    parent: Mapped["Parent"] = relationship(back_populates="children")
    assessment_logs: Mapped[list["AssessmentLog"]] = relationship(
        back_populates="child",
        cascade="all, delete-orphan",
    )


class ExerciseCategory(Base):
    __tablename__ = "exercise_categories"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    name: Mapped[str] = mapped_column(String(120), nullable=False)
    description: Mapped[str | None] = mapped_column(Text, nullable=True)

    exercises: Mapped[list["Exercise"]] = relationship(
        back_populates="category",
        cascade="all, delete-orphan",
    )


class Exercise(Base):
    __tablename__ = "exercises"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    category_id: Mapped[str] = mapped_column(
        String(36),
        ForeignKey("exercise_categories.id", ondelete="CASCADE"),
        nullable=False,
    )
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    target_age_months_min: Mapped[int] = mapped_column(Integer, nullable=False)
    target_age_months_max: Mapped[int] = mapped_column(Integer, nullable=False)
    content_payload: Mapped[dict] = mapped_column(JSON, nullable=False)

    category: Mapped["ExerciseCategory"] = relationship(back_populates="exercises")
    assessment_logs: Mapped[list["AssessmentLog"]] = relationship(back_populates="exercise")


class AssessmentLog(Base):
    __tablename__ = "assessment_logs"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    child_id: Mapped[str] = mapped_column(String(36), ForeignKey("children.id", ondelete="CASCADE"), nullable=False)
    exercise_id: Mapped[str] = mapped_column(String(36), ForeignKey("exercises.id", ondelete="CASCADE"), nullable=False)
    audio_recording_url: Mapped[str | None] = mapped_column(String(2048), nullable=True)
    ai_transcription: Mapped[str | None] = mapped_column(Text, nullable=True)
    accuracy_score: Mapped[float | None] = mapped_column(Float, nullable=True)
    response_time_ms: Mapped[int | None] = mapped_column(Integer, nullable=True)
    completed_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    child: Mapped["Child"] = relationship(back_populates="assessment_logs")
    exercise: Mapped["Exercise"] = relationship(back_populates="assessment_logs")


class DevelopmentMilestone(Base):
    __tablename__ = "development_milestones"

    id: Mapped[str] = mapped_column(String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    month_age: Mapped[int] = mapped_column(Integer, nullable=False, index=True)
    expected_vocabulary_size: Mapped[int] = mapped_column(Integer, nullable=False)
    milestone_description: Mapped[str] = mapped_column(Text, nullable=False)
