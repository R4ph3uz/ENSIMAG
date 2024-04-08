#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TP TL1: implémentation des automates
"""

import sys

###############
# Cadre général

V = set(('.', 'e', 'E', '+', '-')
        + tuple(str(i) for i in range(10)))

class Error(Exception):
    """error"""

INPUT_STREAM = sys.stdin
END = '\n' # WARNING: test_tp modifies the value of END.

# Initialisation: on vérifie que END n'est pas dans V
def init_char():
    """verifie si END est dans V"""
    if END in V:
        raise Error('character ' + repr(END) + ' in V')

# Accès au caractère suivant dans l'entrée
def next_char():
    """renvoie le prochain charactere s'il est dans V ou s'il est égal à END"""
    global INPUT_STREAM
    character = INPUT_STREAM.read(1)
    # print("@", repr(ch))  # decommenting this line may help debugging
    if character in V or character == END:
        return character
    raise Error('character ' + repr(character) + ' unsupported')


############
# Question 1 : fonctions nonzerodigit et digit

def nonzerodigit(char):
    """verifie si le caractere est entre 1 et 9 inclus """
    assert (len(char) <= 1)
    return '1' <= char <= '9'

# verifie si le caractère est entre '1' et '9'

def digit(char):
    """verifie si le caractere est entre 0 et 9 inclus """
    assert (len(char) <= 1)
    return '0' <= char <= '9'

# verifie si le caractère est entre '0' et '9'


# next_char() vérifie si le charactère est dans V ou = END


############
# Question 2 : integer et pointfloat sans valeur

def integer_Q2():
    """initialise l'automate integer à la Q2"""
    init_char()
    return integer_q2_state_0()


def integer_q2_state_0():
    """effectue les choix de l'état 0 de l'automate integer"""
    character = next_char()
    if character =='0':
        return integer_q2_state_1()
    if nonzerodigit(character):
        return integer_q2_state_2()
    return False #si le charactère n'est pas un chiffre


def integer_q2_state_1():
    """effectue les choix de l'état 1 de l'automate integer"""
    character = next_char()
    if character=="0":
        return integer_q2_state_1()
    if character==END:
        return True
    return False



def integer_q2_state_2():
    """effectue les choix de l'état 2 de l'automate integer"""
    character = next_char()
    if digit(character):
        return integer_q2_state_2()
    if character==END:
        return True
    return False


def pointfloat_Q2():
    """initialise l'automate pointfloat"""
    init_char()
    return pointfloat_q2_state_0()

# Définir ici les fonctions manquantes

def pointfloat_q2_state_0():
    """effectue les choix de l'état 0 de l'automate pointfloat"""
    character=next_char()
    if character =='.':
        return pointfloat_q2_state_1()
    if digit(character):
        return pointfloat_q2_state_2()
    return False

def pointfloat_q2_state_1():
    """effectue les choix de l'état 1 de l'automate pointfloat"""
    character=next_char()
    if digit(character):
        return pointfloat_q2_state_3()
    return False

def pointfloat_q2_state_2():
    """effectue les choix de l'état 2 de l'automate pointfloat"""
    character=next_char()
    if digit(character):
        return pointfloat_q2_state_2()
    if character=='.':
        return pointfloat_q2_state_3()
    return False


def pointfloat_q2_state_3():
    """effectue les choix de l'état 3 de l'automate pointfloat"""
    character=next_char()
    if digit(character):
        return pointfloat_q2_state_3()
    if character==END:
        return True
    return False

############
# Question 5 : integer avec calcul de la valeur
# si mot accepté, renvoyer (True, valeur)
# si mot refusé, renvoyer (False, None)

# Variables globales pour se transmettre les valeurs entre états
int_value = 0
exp_value = 0

def integer():
    """initialise l'automate integer amélioré (renvoyant la valeur)"""
    global int_value
    int_value=0
    init_char()
    return integer_state_0()


def integer_state_0():
    """effectue les choix de l'état 0 de l'automate integer en renvoyant la valeur"""
    global int_value
    character = next_char()
    if character =='0':
        return integer_state_1()
    if nonzerodigit(character):
        int_value=int_value*10+int(character)
        return integer_state_2()
    return (False,None)


def integer_state_1():
    """effectue les choix de l'état 1 de l'automate integer en renvoyant la valeur"""
    global int_value
    character = next_char()
    if character=="0":
        return integer_state_1()
    if character==END:
        return (True,int_value)
    return (False,None)


def integer_state_2():
    """effectue les choix de l'état 2 de l'automate integer en renvoyant la valeur"""
    global int_value
    character = next_char()
    if digit(character):
        int_value=int_value*10+int(character)
        return integer_state_2()
    if character==END:
        return (True,int_value)
    return (False,None)


############
# Question 7 : pointfloat avec calcul de la valeur

def pointfloat():
    """initialise l'automate pointfloat en renvoyant la valeur"""
    global int_value
    global exp_value
    init_char()
    int_value = 0
    exp_value = 0
    return pointfloat_state_0()


# Définir ici les fonctions manquantes

def pointfloat_state_0():
    """effectue les choix de l'état 0 de l'automate pointfloat en renvoyant la valeur"""
    global int_value
    character=next_char()
    if character =='.':
        return pointfloat_state_1()
    if digit(character):
        int_value=10*int_value+int(character)
        return pointfloat_state_2()
    return False,None

def pointfloat_state_1():
    """effectue les choix de l'état 1 de l'automate pointfloat"""
    global exp_value
    global int_value
    character=next_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return pointfloat_state_3()
    return False,None

def pointfloat_state_2():
    """effectue les choix de l'état 2 de l'automate pointfloat"""
    global int_value
    character=next_char()
    if digit(character):
        int_value=10*int_value+int(character)
        return pointfloat_state_2()
    if character=='.':
        return pointfloat_state_3()
    return False,None

def pointfloat_state_3():
    """effectue les choix de l'état 3 de l'automate pointfloat"""
    global exp_value
    global int_value
    character=next_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return pointfloat_state_3()
    if character==END:
        return True,int_value*(10**exp_value)
    return False,None


############
# Question 8 : exponent, exponentfloat et number

# La valeur du signe de l'exposant : 1 si +, -1 si -
sign_value = 0

def exponent():
    """initialise l'automate exponent en renvoyant sa valeur"""
    global sign_value
    global exp_value
    exp_value=0
    sign_value=1
    init_char()
    return exponent_state_0()

def exponent_state_0():
    """effectue les choix de l'état 0 de l'automate exponent"""
    character=next_char()
    if character in ("E","e"):
        return exponent_state_1()
    return False,None

def exponent_state_1():
    """effectue les choix de l'état 1 de l'automate exponent"""
    global sign_value
    global exp_value
    character=next_char()
    if character=="+":
        sign_value=1
        return exponent_state_2()
    if  character=="-":
        sign_value=-1
        return exponent_state_2()
    if digit(character):
        exp_value=exp_value+int(character)
        return exponent_state_3()
    return False,None

def exponent_state_2():
    """effectue les choix de l'état 2 de l'automate exponent"""
    global exp_value
    character=next_char()
    if digit(character):
        exp_value=10*exp_value+int(character)
        return exponent_state_3()
    return False,None

def exponent_state_3():
    """effectue les choix de l'état 3 de l'automate exponent"""
    global exp_value
    character=next_char()
    if digit(character):
        exp_value=10*exp_value+int(character)
        return exponent_state_3()
    if character==END:
        return True,sign_value*exp_value
    return False,None

######## exponentfloat

post_exp_value=0 # correspond à l'exposant qui va etre rentrer par l'utilisateur
# indépendemment de l'exposant du fait que le nombre est sous forme AeB où A est le nombre sans "."
#ainsi l'exposant total est la somme de post_exp_value et de exp_value

def exponentfloat():
    """initialise l'automate exponentfloat en renvoyant sa valeur"""
    global int_value
    global exp_value
    global sign_value
    global post_exp_value
    post_exp_value=0
    int_value=0
    exp_value=0
    sign_value=1
    init_char()
    return exponentfloat_state_0()

def exponentfloat_state_0():
    """effectue les choix de l'état 0 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global sign_value
    character=next_char()
    if character==".":
        return exponentfloat_state_2()
    if digit(character):
        int_value=10*int_value+int(character)
        return exponentfloat_state_1()
    return False,None

def exponentfloat_state_1():
    """effectue les choix de l'état 1 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global sign_value
    character=next_char()
    if character==".":
        return exponentfloat_state_2()
    if digit(character):
        int_value=10*int_value+int(character)
        return exponentfloat_state_1()
    if character in ('E','e'):
        return exponentfloat_state_3()
    return False,None

def exponentfloat_state_2():
    """effectue les choix de l'état 2 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global sign_value
    character=next_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return exponentfloat_state_2()
    if character in ('E','e'):
        return exponentfloat_state_3()
    return False,None

def exponentfloat_state_3():
    """effectue les choix de l'état 3 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global sign_value
    global post_exp_value
    character=next_char()
    if character=="+":
        sign_value=1
        return exponentfloat_state_4()
    if  character=="-":
        sign_value=-1
        return exponentfloat_state_4()
    if digit(character):
        post_exp_value=int(character)
        return exponentfloat_state_5()
    return False,None

def exponentfloat_state_4():
    """effectue les choix de l'état 4 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global sign_value
    global post_exp_value
    character=next_char()
    if digit(character):
        post_exp_value=int(character)
        return exponentfloat_state_5()
    return False,None

def exponentfloat_state_5():
    """effectue les choix de l'état final 5 de l'automate exponentfloat"""
    global int_value
    global exp_value
    global post_exp_value
    global sign_value
    character=next_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return exponentfloat_state_5()
    if character==END:
        return True, int_value*(10**(sign_value*post_exp_value+exp_value))
    return False,None

######## exponentfloat


def number():
    """initialise l'automate number"""
    global int_value
    global exp_value
    global post_exp_value
    global sign_value
    int_value=0
    exp_value=0
    post_exp_value=0
    sign_value=1
    init_char()
    return number_state_0()

def number_state_0():
    """correspond à l'état 0 de l'automate number"""
    global int_value
    character=next_char()
    if character=="0":
        return number_state_1()
    if nonzerodigit(character):
        int_value+=int(character)
        return number_state_2()
    if character==".":
        return number_state_3()
    return False,None

def number_state_1():
    """correspond à l'état 1 de l'automate number"""
    global int_value
    character=next_char()
    if character=="0":
        return number_state_1()
    if character==".":
        return number_state_4()
    if nonzerodigit(character):
        int_value=10*int_value+int(character)
        return number_state_5()
    if character in ('E','e'):
        return number_state_6()
    if character in (END, " "):
        return True,int_value
    return False,None

def number_state_2():
    """correspond à l'état 2 de l'automate number"""
    global int_value
    character=next_char()
    if digit(character):
        int_value=10*int_value+int(character)
        return number_state_2()
    if character==".":
        return number_state_4()
    if character in ('E', 'e'):
        return number_state_6()
    if character in (END, " "):
        return True,int_value
    return False,None

def number_state_3():
    """correspond à l'état 3 de l'automate number"""
    global exp_value
    global int_value
    character=next_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return number_state_4()
    return False,None

def number_state_4():
    """correspond à l'état 4 de l'automate number"""
    global exp_value
    global int_value
    character=next_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return number_state_4()
    if character in ('E','e'):
        return number_state_6()
    if character in (END, " "):
        return True,int_value*(10**exp_value)
    return False,None

def number_state_5():
    """correspond à l'état 5 de l'automate number"""
    global int_value
    character=next_char()
    if digit(character):
        int_value=10*int_value+int(character)
        return number_state_5()
    if character in ('E','e'):
        return number_state_6()
    if character ==".":
        return number_state_4()
    return False,None

def number_state_6():
    """correspond à l'état 6 de l'automate number"""
    global post_exp_value
    global sign_value
    character=next_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_state_8()
    if character in ("+","-"):
        if character=="-":
            sign_value=-1
        return number_state_7()
    return False,None

def number_state_7():
    """correspond à l'état 7 de l'automate number"""
    global post_exp_value
    character=next_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_state_8()
    return False,None

def number_state_8():
    """correspond à l'état 8 de l'automate number"""
    global int_value
    global exp_value
    global post_exp_value
    global sign_value
    character=next_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_state_8()
    if character in (END, " "):
        return True,int_value*(10**(sign_value*post_exp_value+exp_value))
    return False,None

########################
#####    Projet    #####
########################


V = set(('.', 'e', 'E', '+', '-', '*', '/', '(', ')', ' ')
        + tuple(str(i) for i in range(10)))


############
# Question 10 : eval_exp

def eval_exp():
    """fonction qui évalue l'expression arithmétique sous notation préfixe"""
    character = next_char()
    # probleme d'espace, ce qui fait que le nombre n'est pas reconnu
    # si un nombre n'est pas accetpé '3ee' alors erreur
    if character == '+':
        number1 = eval_exp()
        number2 = eval_exp()
        return number1 + number2
    if character == '-':
        number1 = eval_exp()
        number2 = eval_exp()
        return number1 - number2
    if character == '*':
        number1 = eval_exp()
        number2 = eval_exp()
        return number1 * number2
    if character == '/':
        number1 = eval_exp()
        number2 = eval_exp()
        return number1 / number2
    return number()[1]

############
# Question 12 : eval_exp corrigé

current_char = ''

# Accès au caractère suivant de l'entrée sans avancer
def peek_char():
    """recupere le charactere mais ne le consomme pas"""
    global current_char
    if current_char == '':
        current_char = INPUT_STREAM.read(1)
    character = current_char
    # print("@", repr(ch))  # decommenting this line may help debugging
    if character in V or character in END:
        return character
    raise Error('character ' + repr(character) + ' unsupported')

def consume_char():
    """consomme le charactere"""
    global current_char
    current_char = ''


def number_v2():
    """initialise l'automate number"""
    global int_value
    global exp_value
    global post_exp_value
    global sign_value
    int_value=0
    exp_value=0
    post_exp_value=0
    sign_value=1
    init_char()
    return number_v2_state_0()

def number_v2_state_0():
    """correspond à l'état 0 de l'automate number"""
    global int_value
    character=peek_char()
    consume_char()
    if character=="0":
        return number_v2_state_1()
    if nonzerodigit(character):
        int_value+=int(character)
        return number_v2_state_2()
    if character==".":
        return number_v2_state_3()
    return False,None

def number_v2_state_1():
    """correspond à l'état 1 de l'automate number"""
    global int_value
    character=peek_char()
    if character in (END, " "):
        return True,int_value
    consume_char()
    if character=="0":
        return number_v2_state_1()
    if character==".":
        return number_v2_state_4()
    if nonzerodigit(character):
        int_value=10*int_value+int(character)
        return number_v2_state_5()
    if character in ('E','e'):
        return number_v2_state_6()
    return False,None

def number_v2_state_2():
    """correspond à l'état 2 de l'automate number"""
    global int_value
    character=peek_char()
    if character in (END, " "):
        return True,int_value
    consume_char()
    if digit(character):
        int_value=10*int_value+int(character)
        return number_v2_state_2()
    if character==".":
        return number_v2_state_4()
    if character in ('E', 'e'):
        return number_v2_state_6()
    return False,None

def number_v2_state_3():
    """correspond à l'état 3 de l'automate number"""
    global exp_value
    global int_value
    character=peek_char()
    consume_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return number_v2_state_4()
    return False,None

def number_v2_state_4():
    """correspond à l'état 4 de l'automate number"""
    global exp_value
    global int_value
    character=peek_char()
    if character in (END, " "):
        return True,int_value*(10**exp_value)
    consume_char()
    if digit(character):
        exp_value-=1
        int_value=10*int_value+int(character)
        return number_v2_state_4()
    if character in ('E','e'):
        return number_v2_state_6()
    return False,None

def number_v2_state_5():
    """correspond à l'état 5 de l'automate number"""
    global int_value
    character=peek_char()
    consume_char()
    if digit(character):
        int_value=10*int_value+int(character)
        return number_v2_state_5()
    if character in ('E','e'):
        return number_v2_state_6()
    if character ==".":
        return number_v2_state_4()
    return False,None

def number_v2_state_6():
    """correspond à l'état 6 de l'automate number"""
    global post_exp_value
    global sign_value
    character=peek_char()
    consume_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_v2_state_8()
    if character in ("+","-"):
        if character=="-":
            sign_value=-1
        return number_v2_state_7()
    return False,None

def number_v2_state_7():
    """correspond à l'état 7 de l'automate number"""
    global post_exp_value
    character=peek_char()
    consume_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_v2_state_8()
    return False,None

def number_v2_state_8():
    """correspond à l'état 8 de l'automate number"""
    global int_value
    global exp_value
    global post_exp_value
    global sign_value
    character=peek_char()
    if character in (END, " "):
        return True,int_value*(10**(sign_value*post_exp_value+exp_value))
    consume_char()
    if digit(character):
        post_exp_value=10*post_exp_value+int(character)
        return number_v2_state_8()
    return False,None

def eval_exp_v2():
    """fonction qui évalue l'expression arithmétique sous notation préfixe"""
    character = peek_char()
    if character==" ":# normalement après un espace il y a soit un nombre
        consume_char()# soit un opérateur
        character=peek_char()
    if character == '+':
        consume_char()
        number1 = eval_exp_v2()[1]
        number2 = eval_exp_v2()[1]
        if number1 is None or number2 is None:
            return False,None
        return True,number1 + number2
    if character == '-':
        consume_char()
        number1 = eval_exp_v2()[1]
        number2 = eval_exp_v2()[1]
        if number1 is None or number2 is None:
            return False,None
        return True,number1 - number2
    if character == '*':
        consume_char()
        number1 = eval_exp_v2()[1]
        number2 = eval_exp_v2()[1]
        if number1 is None or number2 is None:
            return False,None
        return True,number1 * number2
    if character == '/':
        consume_char()
        number1 = eval_exp_v2()[1]
        number2 = eval_exp_v2()[1]
        if number1 is None or number2 is None:
            return False,None
        return True,number1 / number2
    # si c'est un opérateur le caractère est consommé,
    # si c'est un nombre il est gardé pour number_v2()
    # on retourne number_v2
    return number_v2()




############
# Question 14 : automate pour Lex

operator = set(['+', '-', '*', '/'])

def FA_Lex(): # ne reconnait par espilon
    """inititalisation de l'algorithme qui reconnait les lexemes"""
    init_char()
    return fa_lex_state_0()

def fa_lex_state_0():
    """etat qui reconnait le premier caractere d'un lexeme ou un nombre"""
    character = peek_char()
    consume_char()
    if character in ("(",")"): #ca sera un lexeme
        return fa_lex_state_1()
    if character in operator: # idem
        return fa_lex_state_2()
    return number_v2_state_0()[0]

def fa_lex_state_1():
    """dernier etat qui permet de reconnaitre un lexeme"""
    character=peek_char()
    if character in (END, " "):
        return True
    return False # si il y a un charactere après ce n'est pas un lexeme

def fa_lex_state_2():
    """dernier etat qui permet de reconnaitre un lexeme"""
    character=peek_char()
    if character in (END, " "):
        return True
    return False # si il y a un charactere après ce n'est pas un lexeme

############
# Question 15 : automate pour Lex avec token

# Token
NUM, ADD, SOUS, MUL, DIV, OPAR, FPAR = range(7)
token_value = ""#0



def FA_Lex_w_token():
    """initialisation de l'automate LEX ameliore"""
    global token_value
    token_value=0
    init_char()
    return fa_lex_w_state_0()

def fa_lex_w_state_0():
    """premier etat et dernier etat qui permet de reconnaitre un lexeme"""
    global token_value
    character = peek_char()
    if character =="+":
        consume_char()
        return True,"ADD" # renvoie le token
    if character =="-":
        consume_char()
        return True,"SOUS"
    if character =="*":
        consume_char()
        return True,"MUL"
    if character =="/":
        consume_char()
        return True,"DIV"
    if character =="(":
        consume_char()
        return True,"OPAR"
    if character ==")":
        consume_char()
        return True,"FPAR"
    nombre= number_v2_state_0()
    if nombre[0]:
        token_value=nombre[1] # change le token_value
        return True,"NUM"
    return False,None

# Fonction de test
if __name__ == "__main__":
    print("@ Test interactif de l'automate")
    print("@ Tapez une entrée:")
    try:
        # ok = integer_Q2() # changer ici pour tester un autre automate sans valeur
        # ok, val = number() # changer ici pour tester un autre automate avec valeur
        # ok, val = eval_exp_v2() # changer ici pour tester eval_exp et eval_exp_v2
        ok,val  = FA_Lex_w_token() # changer ici pour tester un autre automate sans valeur
        if ok:
            print("Accepted!")
            print("value:", val) # décommenter ici pour afficher la valeur (question 4 et +)
        else:
            print("Rejected!")
            print("value so far:", int_value)
    except Error as e:
        print("Error:", e)
