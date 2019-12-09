import pickle

class Db:


    def __init__(self):
        #Dicionario com as informações de cada parque

        h = Parque("Hospital", "Seg-Sex 09:00-17:00", 200, 200, 5, 5, 0, 190, 10)

    def insertParkInfo(self, park_list):
        f = open("Parks.txt", "ab+")
        for p in park_list:
            pickle.dump(p, f)
        f.close()

    def getParkInfo(self, nome_parque):
        f = open("Parks.txt", "rb")
        try:
            while True:
                p = pickle.load(f)
                print(p.name)
                if nome_parque == p.name:
                    f.close()
                    return p
        except:
            f.close()
            return None

    def userValid(self, name, password):
        if (name == "batatinhas" and password == "batatinhas"):
            return "T"
        return "F"


class Parque:

    #hardcode para usarmos sempre o mesmos campos
    def __init__(self, name, horario, l_max, l_l, l_def, l_elec, l_gpl, l_geral, preco_hora):
        self.name = name
        self.horario = horario
        self.lugares_max = l_max
        self.lugares_livres = l_l
        self.lugares_info = {"def": l_def, "elec": l_elec, "gpl": l_gpl, "geral": l_geral}
        self.preco_hora = preco_hora #centimos




