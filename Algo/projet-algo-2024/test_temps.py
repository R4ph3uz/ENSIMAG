#!/usr/bin/env python3
import matplotlib.pyplot as plt
from tycat import read_instance,tycat
import geo.polygon as polyg
import main
import time


def tests():
    # test de carres imbriques
    for i in range(0,5):
        taille = 1*10**i
        polygones = [polyg.Polygon.square(i,i,taille*2-(2*i)) for i in range(taille)]
        debut = time.time()
        inclusions = main.trouve_inclusions(polygones) #changer pour nom de la fonction a tester
        fin = time.time()
        temps_ecoule = fin - debut
        print('carre_imbrique',taille, inclusions==[i-1 for i in range(taille)],temps_ecoule)


    # test de carres imbriques sur ligne
    polygones =[]
    repet = 3
    for i in range(repet):
        taille = 1*10**i
        polygones +=  [polyg.Polygon.square(j+(taille+1)*i*taille,j,taille*2-(2*j)) for j in range(taille)]
    debut = time.time()
    inclusions = main.trouve_inclusions(polygones) #changer pour nom de la fonction a tester
    fin = time.time()
    temps_ecoule = fin - debut
    print('carre sur ligne',taille, inclusions==[i-1 if i%100!=0 else -1 for i in range(taille) ],temps_ecoule)

#    l_temps =[]
    for repet in range(10,200,50):
        polygones =[]
        for i in range(repet):
            taille = 1*10**2
            polygones +=  [polyg.Polygon.square(j+(taille+1)*i*taille,j,taille*2-(2*j)) for j in range(taille)]
        debut = time.time()
        inclusions = main.trouve_inclusions(polygones) #changer pour nom de la fonction a tester
        fin = time.time()
        temps_ecoule = fin - debut
        print('carre sur ligne',repet, inclusions==[i-1 if i%100!=0 else -1 for i in range(taille*repet) ],temps_ecoule)
#        l_temps.append(temps_ecoule)

    # test carré disjoints
    for increment in range(3):
        taille=1*10**increment
        polygones=[]
        for nb_ligne in range(taille):
            for nb_col in range(taille):
                polygones.append(polyg.Polygon.square(11*nb_col,11*nb_ligne, 10))
#        print("polycree")
#        tycat(polygones)
        debut = time.time()
        inclusions = main.trouve_inclusions(polygones) #changer pour nom de la fonction a tester
        fin = time.time()
        temps_ecoule = fin - debut
        # print(inclusions)
        print('carre cote a cote',taille, inclusions==[-1 for i in range(taille*taille) ],temps_ecoule)

#    plt.plot(list(range(10,200,50)), l_temps)
#    plt.show()

if __name__ == "__main__":
    tests()
