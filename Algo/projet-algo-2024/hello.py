#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
exemple d'utilisation du module geo
"""
from math import cos, sin, pi
from itertools import islice, cycle

from geo.point import Point
from geo.tycat import tycat
from geo.segment import Segment
from geo.polygon import Polygon


def main():
    """
    petit exemple sur l'utilisation de tycat
    """
    print("lancez moi dans terminology")
    print("tycat permet d'afficher des points, des segments, des polygones")
    print("chaque argument doit etre un iterable sur des points \
et/ou segments et/ou polygones (ou juste un point/segment/polygone)")
    print("chaque argument est affiche d'une couleur differente")

    # un point
    origine = Point([0.0, 0.0])
    # un vecteur de points
    o2 = Point([1,1])
    # un iterateur sur des segments (crees a la volee)
    segments = (
        Segment([origine, o2])
       )
    # un carre
    carre = Polygon.square(-1, -1, 2)
    tycat(origine, o2, segments, carre)


main()
