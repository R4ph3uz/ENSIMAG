#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
lexer for the various calculators of TL2
"""

import sys
assert sys.version_info >= (3, 10), "Use Python 3.10 or newer !"

from tokenDEF import Token
import tokenDEF

# A map from token prefixes to tokens except NAT
TOKEN_MAP = { tokenDEF.PREFIX[tok.value]: tok  for tok in Token }
TOKEN_MAP['']=Token.END  # force association with END (and not NAT)

#################################
# private functions and variables of the lexer

in_stream = sys.stdin
current_char = ''

def init_current():
    global current_char
    if current_char == '':
        update_current()

def update_current():
    global current_char
    current_char = in_stream.read(1)
    # print("current @", repr(current_char))  # decomment this line may help debugging


# Parsing functions returning an attributed token given which token we want
# They also take care of updating current_char (except for parse_END as there
# is no further character to read).
def parse_digit():
    if current_char not in tokenDEF.DIGITS:
        raise expected_digit_error(current_char)
    value = eval(current_char)
    update_current()
    return value

def parse_NAT():
    if current_char not in tokenDEF.DIGITS:
        raise expected_digit_error(current_char)
    value=0
    while current_char in tokenDEF.DIGITS:
        value = 10*value + parse_digit()
    return (Token.NAT, value)


# Parse a token (after separators) from the input and returns its token,
# consumming all symbols from the input corresponding to that token
def parse_token_after_separators():
    if current_char in tokenDEF.DIGITS:
        return parse_NAT()
    tok = TOKEN_MAP[current_char]
    match tok:
        case Token.END:
            return (Token.END, None)
        case Token.QUEST:
            update_current()
            return (Token.QUEST, None)
        case Token.PLUS:
            update_current()
            return (Token.PLUS,None)
        case Token.MINUS:
            update_current()
            return (Token.MINUS,None)
        case Token.MULT:
            update_current()
            return (Token.MULT,None)
        case Token.DIV:
            update_current()
            return (Token.DIV,None)
        case Token.CALC:
            update_current()
            return (Token.CALC, parse_NAT()[1])
        case Token.OPAR:
            update_current()
            return (Token.OPAR,None)
        case Token.CPAR:
            update_current()
            return (Token.CPAR,None)
        case _: # default case without attribute
            update_current()
            return (tok, None)



#################################
# public functions of the lexer

# Error handling
class Error(Exception):
    pass

def expected_digit_error(char):
    return Error('Expected a digit, but found ' + repr(char))

def unknown_token_error(char):
    return Error('Unknown start of token ' + repr(char))


# Reinitializes the input stream
def reinit(stream=sys.stdin):
    global in_stream, current_char
    assert stream.readable()
    in_stream = stream
    current_char = ''


# Computes the next token in the input (and move current_char accordingly)
def next_token():
    init_current()
    # init current_char if 'reinit' has been called
    # (or a previous Error has closed in_stream)
    while current_char in tokenDEF.SEP: # skip separators
        update_current()
    try:
        return parse_token_after_separators()
    except KeyError:
        raise unknown_token_error(current_char)



if __name__ == "__main__":
    print("@ Testing the lexer. Just type tokens and separators")
    print("@ Each token should appear once by line")
    print("@ Type Ctrl-D to quit")
    while True:
        token, value = next_token()
        print("t",token,"v",value)
        print("@", tokenDEF.str_attr_token(token, value))
        if token == Token.END:
            break
