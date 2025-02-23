from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()

class User(Base):
    __tablename__ = "google_users"

    id = Column(Integer, primary_key=True, autoincrement=True)
    google_id = Column(String, unique=True, index=True, nullable=False)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    profile_pic = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
