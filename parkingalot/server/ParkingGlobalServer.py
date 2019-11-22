from flask import Flask, escape, request
from pseudo_ParkingDB import Db, Parque

app = Flask(__name__)

@app.route('/info')
def info():
    db = Db()
    p = db.getInfo("hospital")
    dic = {"horario": p.horario, "lugares_max": p.lugares_max, "lugares_livres": p.lugares_livres, "lugares_def": p.lugares_info["def"], "lugares_elec" : p.lugares_info["elec"], "lugares_gpl": p.lugares_info["gpl"], "lugares_geral": p.lugares_info["geral"], "preco_hora": p.preco_hora}
    return str(dic)
