from pseudo_ParkingDB import Db, Parque, User
import pickle


p1 = Parque("Estacionamento Centro Hospitalar Baixo Vouga", "Av. Padre Fernão de Oliveira\n Glória, 3800-164 Aveiro", 200, 140, {
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
    }, "hospital.JPG", "false")

p2 = Parque("Estacionamento da UA", "Av. Santo Francisco\n 3810-193 Aveiro", 180, 102, {
        "deficientes": 0, "electricos": 0, "geral": 180
    }, {
        "(Todos os dias)": {
            "(todas as horas)":0.00
        }
    },
    {
        "name":"UA", "contact":"+351 234 370 347"
    }, "ua.JPG", "true")

p3 = Parque("Estacionamento Piscina INDESP", "R. Sebastião de Magalhães Lima Glória\n 3810-164 Aveiro", 80, 35, {
        "deficientes": 0, "electricos": 0, "geral": 80
    }, {
        "Seg-Sex": {
            "09:00-20:00":1.00
        },
        "Fim-de-semana": {
            "(todas as horas)":0.00
        }
    },
    {
        "name":"MoveAveiro", "contact":"+351-234-406-387"
    }, "indesp.PNG", "false")

p4 = Parque("Estacionamento Jerónimo Campos", "Cais da fonte Nova\n 3810-164 Aveiro", 230, 102, {
        "deficientes": 0, "electricos": 0, "geral": 230
    }, {
        "Seg-Dom": {
            "(todas as horas)":0.00
        }
    },
    {
        "name":"Câmara Municipal de Aveiro", "contact":"+351-234-406-300"
    }, "melia.PNG", "true")

p5 = Parque("Estacionamento Conservatorio", "Av. Artur Ravara\n 3810-096 Aveiro", 40, 12, {
        "deficientes": 0, "electricos": 0, "geral": 40
    }, {
        "Seg-Dom": {
            "(todas as horas)":0.00
        }
    },
    {
        "name":"Câmara Municipal de Aveiro", "contact":"+351-234-406-300"
    }, "conservatorio.JPG", "true")

d = Db()
d.insertParkInfo({"40.634523 -8.656944":p1,
                    "40.629309 -8.654716":p2,
                    "40.637343 -8.645938":p3,
                    "40.637816 -8.644718":p4,
                    "40.636284 -8.654836":p5
                })

f = open("Users.txt", "wb")
pickle.dump({}, f)
f.close()


