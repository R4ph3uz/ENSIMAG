#!/usr/bin/env python3
"""
fichier principal pour la detection des inclusions.
ce fichier est utilise pour les tests automatiques.
attention donc lors des modifications.
"""
import sys
from tycat import read_instance
from geo import point,segment,polygon,tycat
import time

def trouve_point_plus_loin(polygone):
    """recupere le point le plus loin de l'origine pour un polygone donné"""
    max_pt=polygone.points[0]
    max_dist_carre=max_pt.coordinates[0]**2+max_pt.coordinates[1]**2
    for pt in polygone.points[1:]:
        if (pt.coordinates[0]**2+ pt.coordinates[1]**2)>max_dist_carre:
            max_pt=pt.copy()
            max_dist_carre=pt.coordinates[0]**2+ pt.coordinates[1]**2
    return max_pt

def intersect_segment(point1,point_loin,point_seg1, point_seg2):
    """
    Vérifie si deux segments se croisent.
    à partir de 4 points
    """
    def ccw(a, b, c):
        number = (c.coordinates[1] - a.coordinates[1]) * (b.coordinates[0] - a.coordinates[0])
        number=number - ((b.coordinates[1]-a.coordinates[1]) * (c.coordinates[0]-a.coordinates[0]))
        return number

    if ccw(point1,point_loin,point_seg1)*ccw(point1,point_loin,point_seg2)>0:
        return False
    if ccw(point_seg1,point_seg2,point1)*ccw(point_seg1,point_seg2,point_loin)>0:
        return False
    return True

def contiens(point1,point2, possible_point):
        """
        is given point inside us ?
        be careful, determining if a point is inside a segment is a difficult problem
        (it is in fact a meaningless question in most cases).
        you might get wrong results for points extremely near endpoints.
        """
        distance = sum(possible_point.distance_to(p) for p in (point1,point2))
        return abs(distance - point1.distance_to(point2)) < 0.0000001

def point_dans_polygone(pt, polygone):
    """renvoie le nombre de fois que croise le segment cree avec le polygone"""
    compteur=0
    x=pt.coordinates[0]
    y=pt.coordinates[1]
    # pour etre sur d'etre plus loin que le point
    for seg in polygone.segments():
        p0=seg.endpoints[0]
        p1=seg.endpoints[1]
        if p1.coordinates[1]!=p0.coordinates[1]:
            xinter=(y-p0.coordinates[1])*(p1.coordinates[0]-p0.coordinates[0])/(p1.coordinates[1]-p0.coordinates[1]) + p0.coordinates[0]
        else :
            continue
        if xinter<=x or (p0.coordinates[0]<x and p1.coordinates[0]<x):
            # si le segment n'est pas plus à droite on saute
            continue
        if p0.coordinates[1]<y and p1.coordinates[1]>=y:
            compteur+=1
        elif p0.coordinates[1]>=y and p1.coordinates[1]<y:
            compteur+=1
        # print(seg)
        # print(compteur)
    return compteur

def insertion_triee(tableau, element):
    """
    Ajoute un élément à un tableau trié à sa place appropriée
    tout en maintenant le tableau trié.
    """
    debut, fin = 0, len(tableau) - 1

    # Recherche dichotomique pour trouver la position d'insertion
    while debut <= fin:
        milieu = (debut + fin) // 2
        if tableau[milieu] == element:
            # Insère l'élément à la position actuelle s'il est déjà présent
            tableau.insert(milieu, element)
            return
        if tableau[milieu] < element:
            debut = milieu + 1
        else:
            fin = milieu - 1

    # Insère l'élément à la position appropriée
    tableau.insert(debut, element)
    return

def trouve_inclusions(polygones):
    """
    renvoie le vecteur des inclusions
    la ieme case contient l'indice du polygone
    contenant le ieme polygone (-1 si aucun).
    (voir le sujet pour plus d'info)
    """
    couple_largeur_index=[]
    couple_largeur_index_non_trie=[]
    vecteur_inclusions=[]
    point_xtreme_gd=[]
    point_xtreme_hb=[]
    for index,polygone in enumerate(polygones):
        vecteur_inclusions.append(-1)
        quad=polygone.bounding_quadrant() # cree une boite autour
        largeur=quad.max_coordinates[0]-quad.min_coordinates[0]
        couple_largeur_index_non_trie.append((largeur,index)) #mets (largeur,index) pour trier après
        insertion_triee(couple_largeur_index,(largeur,index))
        # ajouter le point le plus à gauche et le plus à droite
            # car si le point le plus à gauche est à droite d'un autre poly => pas inclu
        # print("min",quad.min_coordinates,"max",quad.max_coordinates)
        point_xtreme_gd.append(quad.limits(0))
        point_xtreme_hb.append(quad.limits(1))
    # print("liste des largeurs et index",couple_largeur_index)
    # print("pts plus loin",points_les_plus_loin)
    # etablir la liste des polygones à verifier pour chaque polygone
    for index,polygone in enumerate(polygones):
        couple=couple_largeur_index_non_trie[index] # on récupere dans la liste des largeurs
        index_couple_dans_liste=couple_largeur_index.index(couple)
        # on recupere l'index dans la trié
        # polygones sont tous ceux d'après dans la liste triée
        liste_polygone=couple_largeur_index[index_couple_dans_liste+1:]
#        liste_polygone=[]
#        for largeur,i in couple_largeur_index[index_couple_dans_liste+1:]:
#            if couple[0]>=largeur:
#                continue
#            if point_xtreme_gd[index][0]<point_xtreme_gd[i][0]:
#                # cela signifie que le point le plus à gauche du poly considere
#                # est plus à droite que le polygone à checker (donc pas d'incl)
#                continue
#            if point_xtreme_gd[index][1]>point_xtreme_gd[i][1]:
#                # le point le plus à droite est à gauche de l'autre poly
#                continue
#            if point_xtreme_hb[index][0]<point_xtreme_hb[i][0]:
#                # pareil mais haut bas
#                continue
#            if point_xtreme_hb[index][1]>point_xtreme_hb[i][1]:
#                continue
#            liste_polygone.append(i)
        # print('polygone',index,"est potentiellement inclu dans",liste_polygone)
        point_polygone=polygone.points[0]
        # print(point_polygone)
        for (largeur,i) in liste_polygone:
        # for i in liste_polygone:
            # print("poly",i, point_polygone)
            nombre=point_dans_polygone(point_polygone,polygones[i])
            if nombre%2==1:
                vecteur_inclusions[index]=i
                break
    return vecteur_inclusions

def main():
    """
    charge chaque fichier .poly donne
    trouve les inclusions
    affiche l'arbre en format texte
    """
    global L
    if not sys.argv[1:]:
        sys.argv[1:]=['tests/e2.poly']
    for fichier in sys.argv[1:]:
        polygones = read_instance(fichier)
        inclusions = trouve_inclusions(polygones)
        print(inclusions)
if __name__ == "__main__":
    main()
