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
                du[u.name] = u.password
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
            print(p)
            return p[coords]
        except:
            f.close()
            return None

    def getUserPassword(self, name):
        f = open("Users.txt", "rb")
        du = pickle.load(f)
        f.close()
        if (name in set(du.keys())):
            return du[name]
        return ""
        


    def userValid(self, name, password):
        if (name == "batatinhas" and password == "batatinhas"):
            return "T"
        return "F"


class Parque:

    #hardcode para usarmos sempre o mesmos campos
    def __init__(self, name, location, l_max, l_l, lugares_info, tabela_preco, owner):
        self.name = name
        self.location = location
        self.lugares_max = l_max
        self.lugares_livres = l_l
        self.lugares_info = lugares_info
        self.tabela_preco = tabela_preco
        self.owner = owner

class User:

    def __init__(self, name, password):
        self.name = name
        self.password = password



