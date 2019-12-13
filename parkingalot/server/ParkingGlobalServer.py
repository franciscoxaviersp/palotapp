from flask import Flask, escape, request, Response
from pseudo_ParkingDB import Db, Parque, User
import json
import math

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
        "owner":p.owner,
        "image":p.image
    }
    return Response(json.dumps(dic), mimetype="application/json")

@app.route("/userInfo")
def userInfo():
    db = Db()
    name = request.args.get("name", None)
    u = db.getUser(name)
    coords=u.reserva.coordenadas.split() if u.reserva.coordenadas!="None" else ["0","0"]
    dic = {
        "name": u.name,
        "password": u.password,
        "email": u.email,
        "telemovel": u.telemovel,
        "favoritos": u.favoritos,
        "saldo": u.saldo,
        "reserva": {"lat" : float(coords[0]),
                    "lon" : float(coords[1]),
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
    error = db.insertUsers([User(data["user"], data["password"], data["email"], data["phone"], data["especial"])])
    return Response(json.dumps({"exist_error": error}), mimetype="application/json")

@app.route("/allParksLocation")
def parks():
    db = Db()
    l_coordenadas = db.getAllParks()
    return Response(json.dumps({"Coordenadas" : l_coordenadas}), mimetype="application/json")

@app.route("/allParksInfo")
def parksInfo():
    db = Db()
    park = request.args.get("park", None)
    if park == None:
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
                "owner": p.owner,
                "image": p.image
            }
            dic[k] = d
        return Response(json.dumps(dic), mimetype="application/json")

    d = db.getallParks()
    ponto = park.split()
    parques = list(d.keys())
    parques.remove(park)
    pontos = [pa.split() for pa in parques]
    sorted(pontos, key=lambda p : haversineDistance(ponto, p))

    melhores = []
    if len(pontos) < 4:
        melhores = pontos
    else:
        melhores = pontos[0:3]
    melhores = [str(po[0])+" "+str(po[1]) for po in melhores]
    dic = {}
    for m in melhores:
        a = d[m]
        d = {
            "name": a.name,
            "location": a.location,
            "lugares_max": a.lugares_max,
            "lugares_livres": a.lugares_livres,
            "lugares_tipos": a.lugares_info,
            "pricetable": a.tabela_preco,
            "owner": a.owner,
            "image": a.image
        }
        dic[m] = d
    return Response(json.dumps(dic), mimetype="application/json")



def haversineDistance(p1, p2):
    for i in range(0,2):
        p1[i] = float(p1[i])
        p2[i] = float(p2[i])

    R_Terra = 6371*10**3
    fi1 = math.radians(p1[0])
    fi2 = math.radians(p2[0])

    deltafi = math.radians(p2[0] - p1[0])
    deltagama = math.radians(p2[1] - p1[1])

    a = math.sin(deltafi / 2) * math.sin(deltafi / 2) + math.cos(fi1) * math.cos(fi2) * math.sin(
        deltagama / 2) * math.sin(deltagama / 2)

    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    return R_Terra * c



@app.route("/addFavorite")
def addFavorite():
    db = Db()
    coordenadas = request.args.get("park", None)
    name = request.args.get("name", None)
    db.addFavorite(name, coordenadas)
    return Response(json.dumps({"resposta" : "ok"}), mimetype="application/json")

@app.route("/removeFavorite")
def removeFavorite():
    db = Db()
    coordenadas = request.args.get("park", None)
    name = request.args.get("name", None)
    db.removeFavorite(name, coordenadas)
    return Response(json.dumps({"resposta": "ok"}), mimetype="application/json")

@app.route("/allFavorites")
def allFavorites():
    db = Db()
    name = request.args.get("name", None)
    l = db.favoritesList(name)
    return Response(json.dumps({"favorites": l}), mimetype="application/json")

@app.route("/addReservation")
def addReservation():
    data = request.json  #nome, reserva
    db = Db()
    db.addReservation(data["nome"], data["reserva"]["lat"]+" "+data["reserva"]["lon"], data["reserva"]["inicio"]["data"], data["reserva"]["inicio"]["hora"], data["reserva"]["fim"]["data"], data["reserva"]["fim"]["hora"])
    return Response(json.dumps({"resposta": "ok"}), mimetype="application/json")

@app.route("/clearReservation")
def clearReservation():
    db = Db()
    name = request.args.get("name", None)
    db.clearReservation(name)
    return Response(json.dumps({"resposta": "ok"}), mimetype="application/json")

        






