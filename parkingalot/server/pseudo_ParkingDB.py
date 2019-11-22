class Db:

    def __init__(self):
        #Dicionario com as informações de cada parque

        h = Parque("Seg-Sex 09:00-17:00", 200, 200, 5, 5, 0, 190, 10)
        self.parques = {"hospital" : h, "musica" : h, "ua" : h}

    def getInfo(self, nome_parque):
        return self.parques[nome_parque]


class Parque:

    #hardcode para usarmos sempre o mesmos campos
    def __init__(self, horario, l_max, l_l, l_def, l_elec, l_gpl, l_geral, preco_hora):
        self.horario = "Seg-Sex 09:00-17:00"
        self.lugares_max = 200
        self.lugares_livres = 200
        self.lugares_info = {"def": 5, "elec": 5, "gpl": 0, "geral": 190}
        self.preco_hora = 10 #centimos



