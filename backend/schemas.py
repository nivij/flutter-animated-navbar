from pydantic import BaseModel

class UserCreate(BaseModel):
    google_id: str
    email: str
    name: str
    profile_pic: str | None = None

class UserResponse(UserCreate):
    id: int

    class Config:
        from_attributes = True


