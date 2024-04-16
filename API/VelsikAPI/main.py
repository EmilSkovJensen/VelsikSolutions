from fastapi import FastAPI, Depends, HTTPException
from Database.APVConnection import APVConnection
from Database.UserConnection import UserConnection
from Database.Models.User import User
from auth import AuthHandler
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional

app = FastAPI()
user_db = UserConnection()
apv_db = APVConnection()
auth_handler = AuthHandler()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust this according to your frontend's domain
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
    allow_credentials=True,
)


@app.get("/")
async def root(user_id=Depends(auth_handler.auth_wrapper)):
    result = user_db.get_all_companies()
    return {"companies": result}


@app.post("/user/insert")
async def insert_user(data: dict):
    try:
        user = User(
            user_id=None,
            company_id=data.get("company_id"),
            department_id=data.get("department_id"),
            email=data.get("email"),
            password=data.get("password"),
            firstname=data.get("firstname"),
            lastname=data.get("lastname"),
            phone_number=data.get("phone_number"),
            user_role=data.get("user_role")
        )

        user_db.insert_user(user)

        return {"message": "User created successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")


@app.post("/login")
async def login(data: dict):
    try:
        if not data:
            raise HTTPException(status_code=400, detail="Email and password are required")

        authenticated_user = user_db.compare_passwords(data.get("email"), data.get("password"))

        if authenticated_user:
            token = auth_handler.encode_token(authenticated_user[0])
            return {"token": token}
        else:
            raise HTTPException(status_code=401, detail="Invalid credentials")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")


@app.get("/decode_token")
async def decode_token(token: str):
    user_id = auth_handler.decode_token(token)
    return {"user_id": user_id}


@app.get("/user/getbyid")
async def get_user_by_id(user_id: int):
    user = user_db.get_user_by_user_id(user_id)
    return {"user": user}

@app.get("/apv/get_template_questions")
async def get_template_questions(apv_type: str):
    questions = apv_db.get_template_questions(apv_type)
    return {"questions": questions}
