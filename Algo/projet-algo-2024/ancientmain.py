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


def point_dans_polygone(pt,deuxieme_point_segment, polygone):
    """renvoie le nombre de fois que croise le segment cree avec le polygone"""
    compteur=0
    # pour etre sur d'etre plus loin que le point
    deuxieme_point=deuxieme_point_segment+point.Point([1,1.5])
    for seg in polygone.segments():
        # print(seg)
        ret =intersect_segment(pt,deuxieme_point,seg.endpoints[0],seg.endpoints[1])
        if ret:
            compteur+=1
        # if segment.Segment([pt,deuxieme_point]).contains(seg.endpoints[0]):
        #     compteur+=1
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
    points_les_plus_loin=[]
#    point_xtreme_gd=[]
#    point_xtreme_hb=[]
    for index,polygone in enumerate(polygones):
        vecteur_inclusions.append(-1)
        quad=polygone.bounding_quadrant() # cree une boite autour
        largeur=quad.max_coordinates[0]-quad.min_coordinates[0]
        couple_largeur_index_non_trie.append((largeur,index)) #mets (largeur,index) pour trier après
        insertion_triee(couple_largeur_index,(largeur,index))

	# ajouter le point le plus à gauche et le plus à droite
	# car si le point le plus à gauche est à droite d'un autre poly => pas inclu
        # print("min",quad.min_coordinates,"max",quad.max_coordinates)
#        point_xtreme_gd.append(quad.limits(0))
#        point_xtreme_hb.append(quad.limits(1))

        pt=trouve_point_plus_loin(polygone) # renvoie le point le plus loin du polygone
        points_les_plus_loin.append((pt,index)) # point,index
    # print("liste des largeurs et index",couple_largeur_index)
    # print("pts plus loin",points_les_plus_loin)
    point_le_plus_loin=max(points_les_plus_loin)[0]
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
#
#        # print('polygone',index,"est potentiellement inclu dans",liste_polygone)
        point_polygone= points_les_plus_loin[index][0]# pour recuperer le point
        for (large,i) in liste_polygone:
            nombre=point_dans_polygone(point_polygone,point_le_plus_loin,polygones[i])
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
    if not sys.argv[1:]:
        sys.argv[1:]=['tests/e2.poly']
    for fichier in sys.argv[1:]:
        polygones = read_instance(fichier)
        debut=time.time()
        inclusions = trouve_inclusions(polygones)
        fin=time.time()
        print(inclusions,fin-debut)

if __name__ == "__main__":
    main()
