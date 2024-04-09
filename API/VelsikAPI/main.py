from fastapi import FastAPI, HTTPException
from Database.DBConnection import DBConnection
from Database.Models.User import User

app = FastAPI()
db = DBConnection()


@app.get("/")
async def root():
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

