from flask import Flask, escape, request, Response
from pseudo_ParkingDB import Db, Parque, User
import json

#FLASK_APP=ParkingGlobalServer.py flask run --host=0.0.0.0

app = Flask(__name__)

@app.route('/parkInfo')
def parkInfo():
    db = Db()
    coordenadas = request.args.get("park", None)
    p = db.getParkInfo(coordenadas)
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

@app.route("/userInfo")
def userInfo():
    db = Db()
    name = request.args.get("name", None)
    u = db.getUser(name)
    print(u.reserva)
    dic = {
        "name": u.name,
        "password": u.password,
        "email": u.email,
        "telemovel": u.telemovel,
        "favoritos": u.favoritos,
        "reserva": {"coordenadas" : u.reserva.coordenadas,
                    "inicio" : {"data" : u.reserva.dataInicial, "hora" : u.reserva.horaInicial},
                    "fim" : {"data": u.reserva.dataFinal, "hora": u.reserva.horaFinal}
                    },
        "proprietario": u.proprietario
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
    error = db.insertUsers([User(data["user"], data["password"]), data["email"], data["phone"], data["especial"]])
    return Response(json.dumps({"exist_error": error}), mimetype="application/json")

@app.route("/allParksLocation")
def parks():
    db = Db()
    l_coordenadas = db.getAllParks()
    return Response(json.dumps({"Coordenadas" : l_coordenadas}), mimetype="application/json")

@app.route("/allParksInfo")
def parksInfo():
    db = Db()
    parques = db.getallParks()
    dic = {}
    for k in set(parques.keys()):
        p = parques[k]
        d = {
            "name": p.name,
            "location": p.location,
            "lugares_max": p.lugares_max,
            "lugares_livres": p.lugares_livres,
            "lugares_tipos": p.lugares_info,
            "pricetable": p.tabela_preco,
            "owner": p.owner
        }
        dic[k] = d
    return Response(json.dumps(dic), mimetype="application/json")
        






