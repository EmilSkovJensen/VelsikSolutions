from fastapi import FastAPI, Depends, HTTPException
from Database.DBConnection import DBConnection
from Database.Models.User import User
from auth import AuthHandler

app = FastAPI()
db = DBConnection()
auth_handler = AuthHandler()


@app.get("/")
async def root(user_id=Depends(auth_handler.auth_wrapper)):
    result = db.get_all_companies()
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

        db.insert_user(user)

        return {"message": "User created successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")


@app.post("/login")
async def login(data: dict):
    try:
        if not data:
            raise HTTPException(status_code=400, detail="Email and password are required")

        authenticated_user = db.compare_passwords(data.get("email"), data.get("password"))

        if authenticated_user:
            token = auth_handler.encode_token(authenticated_user[0])
            return {"token": token}
        else:
            raise HTTPException(status_code=401, detail="Invalid credentials")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {e}")