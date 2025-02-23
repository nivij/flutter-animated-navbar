from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from backend.database import get_db, engine, Base  # Use the correct folder name
from models import User
from schemas import UserCreate, UserResponse

app = FastAPI()

# Create Tables
async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.on_event("startup")
async def startup():
    await init_db()

# API to Create a User
@app.post("/users/", response_model=UserResponse)
async def create_user(user: UserCreate, db: AsyncSession = Depends(get_db)):
    async with db.begin():
        existing_user = await db.execute(select(User).where(User.google_id == user.google_id))
        if existing_user.scalar():
            raise HTTPException(status_code=400, detail="User already exists")

        new_user = User(**user.model_dump())
        db.add(new_user)
        await db.commit()
        await db.refresh(new_user)
        return new_user

@app.get("/users/", response_model=list[UserResponse])
async def get_users(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(User))
    return result.scalars().all()

