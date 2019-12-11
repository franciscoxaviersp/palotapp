from pseudo_ParkingDB import Db, Parque, User
import pickle


h = Parque("Estacionamento Centro Hospitalar Baixo Vouga", "Av. Padre Fernão de Oliveira, Glória, 3800-164 Aveiro", 140, 140, {
        "deficientes": 5, "electricos": 10, "geral": 185
    }, {
        "Seg-Sex": {
            "09:00-17:00":1.00,
            "17:00-20:00":0.50
        },
        "Fim-de-semana": {
            "(todas as horas)":0.00
        }
    },
    {
        "name":"MoveAveiro", "contact":"+351-234-406-387"
    })
d = Db()
d.insertParkInfo({"40.634523 -8.656944":h})

f = open("Users.txt", "wb")
pickle.dump({}, f)
f.close()


