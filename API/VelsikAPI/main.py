from fastapi import FastAPI, Depends, HTTPException
from Database.APVConnection import APVConnection
from Database.Models.APV import APV
from Database.Models.Response import Response
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


@app.get("/apv/get_questions")
async def get_questions(apv_id: str):
    questions = apv_db.get_questions(apv_id)
    return {"questions": questions}


@app.get("/apv/get_types")
async def get_types(apv_category: str):
    types = apv_db.get_apv_types(apv_category)
    return {"types": types}


@app.get("/department/get_departments_and_users")
async def get_departments_and_users(company_id: int):
    departments = user_db.get_departments_and_users(company_id)

    return {"departments": departments}


@app.post("/apv/insert")
async def insert_apv(data: dict):
    try:
        apv = APV(
            apv_id=None,
            company_id=data.get("company_id"),
            start_date=data.get("start_date"),
            end_date=data.get("end_date"),
            questions=data.get("questions"),
            users=data.get("users")
        )

        apv_db.insert_apv(apv)

        return {"message": "APV created successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")


@app.get("/apv/get_remaining_apvs")
async def get_remaining_apvs(user_id: int):
    apvs = apv_db.get_apvs_by_user_id(user_id)
    return {"apvs": apvs}


@app.post("/apv/answer")
async def insert_response(data: dict):
    try:
        for obj in data['data']:
            response = Response(
                response_id=None,
                apv_question_id=obj["questionId"],
                user_id=obj["userId"],
                answer=obj["answer"],
                comment=obj["comment"]
            )

            apv_db.insert_response(response)

        apv_db.complete_apv(data["data"][0]["questionId"], data["data"][0]["userId"])

        return {"message": "Response inserted successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")


@app.get("/apv/get_response_statuses")
async def get_response_statuses(company_id: int):
    statuses = apv_db.get_apv_user_statuses(company_id)
    return {"statuses": statuses}
