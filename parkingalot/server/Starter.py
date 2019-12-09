from pseudo_ParkingDB import Db, Parque

u = Parque("Musica", "Seg-Sex 09:00-17:00", 140, 140, 5, 5, 0, 190, 10)
h = Parque("Hospital", "Seg-Sex 09:00-17:00", 200, 200, 5, 5, 0, 190, 10)
d = Db()
d.insertParkInfo([h, u])
