import pickle

class Db:


    def __init__(self):
        #Dicionario com as informações de cada parque
        pass

    def insertParkInfo(self, park_dic):
        f = open("Parks.txt", "wb")
        pickle.dump(park_dic,f)
        f.close()

    def insertUsers(self, user_list):
        if(self.testUserValid(user_list)):
            f = open("Users.txt", "rb")
            du = pickle.load(f)
            f.close()
            for u in user_list:
                du[u.name] = u
            f = open("Users.txt", "wb")
            pickle.dump(du, f)
            f.close()
            return "true"
        return "false"            
          
    def testUserValid(self, user_list):
        f = open("Users.txt", "rb")
        du = pickle.load(f)
        f.close()
        keys = set(du.keys())
        return not any([True for u in user_list if (u.name in keys)])






    def getParkInfo(self, coords):
        f = open("Parks.txt", "rb")
        try:
            p=pickle.load(f)
            f.close()
            return p[coords]
        except:
            f.close()
            return None

    def getAllParks(self):
        f = open("Parks.txt", "rb")
        d = pickle.load(f)
        f.close()
        return list(d.keys())

    def getUser(self, name):
        f = open("Users.txt", "rb")
        du = pickle.load(f)
        f.close()
        if (name in set(du.keys())):
            return du[name]
        return None

    def getUserPassword(self, name):
        f = open("Users.txt", "rb")
        du = pickle.load(f)
        f.close()
        if (name in set(du.keys())):
            return du[name].password
        return ""
        


    def userValid(self, name, password):
        if (name == "batatinhas" and password == "batatinhas"):
            return "T"
        return "F"

    def getallParks(self):
        f = open("Parks.txt", "rb")
        p = pickle.load(f)
        f.close()
        return p

    def addFavorite(self, name, coordenadas):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        d[name].favoritos.append(coordenadas)
        f = open("Users.txt", "wb")
        pickle.dump(d, f)
        f.close()

    def removeFavorite(self, name, coordenadas):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        d[name].favoritos.remove(coordenadas)
        f = open("Users.txt", "wb")
        pickle.dump(d, f)
        f.close()

    def favoritesList(self, name):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        return d[name].favoritos

    def addReservation(self, name, coordenadas, dataInicial , horaInicial, dataFinal, horaFinal):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        d[name].reserva = Reserva(coordenadas, dataInicial , horaInicial, dataFinal, horaFinal)
        f = open("Users.txt", "wb")
        pickle.dump(d, f)
        f.close()

    def clearReservation(self, name):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        d[name].reserva = Reserva()
        f = open("Users.txt", "wb")
        pickle.dump(d, f)
        f.close()

    def addFunds(self, name, value):
        f = open("Users.txt", "rb")
        d = pickle.load(f)
        f.close()
        d[name].saldo += value
        f = open("Users.txt", "wb")
        pickle.dump(d, f)
        f.close()



class Parque:

    #hardcode para usarmos sempre o mesmos campos
    def __init__(self, name, location, l_max, l_l, lugares_info, tabela_preco, owner, image, public):
        self.name = name
        self.location = location
        self.lugares_max = l_max
        self.lugares_livres = l_l
        self.lugares_info = lugares_info
        self.tabela_preco = tabela_preco
        self.owner = owner
        self.image = image
        self.public = public

class User:

    def __init__(self, name, password, email, telemovel, proprietario):
        self.name = name
        self.password = password
        self.email = email
        self.telemovel = telemovel
        self.favoritos = [] #lista de coordenadas
        self.saldo = 0
        self.reserva = Reserva()     #dicionario com coordendas, objeto (data, hora partida) {c : 12123, {data : aefea, hora : 123}, {data : aefea, hora : 123}}
        self.proprietario = proprietario

class Reserva:

    def __init__(self, coordenadas="None", dataInicial="None" , horaInicial="None", dataFinal="None", horaFinal="None"):
        self.coordenadas = coordenadas
        self.dataInicial = dataInicial
        self.horaInicial = horaInicial
        self.dataFinal = dataFinal
        self.horaFinal = horaFinal


