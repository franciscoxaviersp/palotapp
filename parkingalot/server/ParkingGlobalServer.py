from flask import Flask, escape, request, Response
from pseudo_ParkingDB import Db, Parque
import json

app = Flask(__name__)

@app.route('/info')
def info():
    db = Db()
    p = db.getParkInfo("Musica")
    print(p)
    if p == None:
        return json.dumps({})
    dic = {"horario": p.horario, "lugares_max": p.lugares_max, "lugares_livres": p.lugares_livres, "lugares_def": p.lugares_info["def"], "lugares_elec" : p.lugares_info["elec"], "lugares_gpl": p.lugares_info["gpl"], "lugares_geral": p.lugares_info["geral"], "preco_hora": p.preco_hora}
    return json.dumps(dic)


@app.route("/login")
def login():
    user = request.args.get("user", None)
    print(user)
    if(user != "batatinhas"):
        return Response(json.dumps({}), mimetype="application/json")
    return Response(json.dumps({"batatinnhas": "batatinhas"}), mimetype="application/json")

    #if(user == None or password == None):
    #    return "F"

    #db = Db()
    #return db.userValid(user, password)




