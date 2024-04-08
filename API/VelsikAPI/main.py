from fastapi import FastAPI
from configparser import ConfigParser

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

if __name__ == "__main__":
    config = ConfigParser()
    config.read("appsettings.ini")
    print(config.get('Database', 'ConnectionString'))
