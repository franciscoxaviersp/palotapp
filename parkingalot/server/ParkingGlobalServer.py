from flask import Flask, escape, request, Response
from pseudo_ParkingDB import Db, Parque, User
import json

#FLASK_APP=ParkingGlobalServer.py flask run --host=0.0.0.0

app = Flask(__name__)

@app.route('/info')
def info():
    db = Db()
    p = db.getParkInfo("40°38'N 8°39'W")
    print(p)
    if p == None:
        return json.dumps({})
    dic={
        "name":p.name,
        "location":p.location,
        "lugares_max":p.lugares_max,
        "lugares_livres":p.lugares_livres,
        "lugares_tipos":p.lugares_info,
        "pricetable":p.tabela_preco,
        "owner":p.owner
    }
    return Response(json.dumps(dic), mimetype="application/json")


@app.route("/login")
def login():
    user = request.args.get("user", None)
    db = Db()
    password = db.getUserPassword(user)
    if password == "":
        return Response(json.dumps({"exist_error": "true", "password" : ""}), mimetype="application/json")
    return Response(json.dumps({"exist_error": "false", "password" : password}), mimetype="application/json")


@app.route("/createUser", methods=["POST"])
def create():
    data = request.json
    db = Db()
    error = db.insertUsers([User(data["user"], data["password"])])
    return Response(json.dumps({"exist_error": error}), mimetype="application/json")




