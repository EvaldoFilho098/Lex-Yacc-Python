# Yacc example
 
import ply.yacc as yacc

# Get the token map from the lexer.  This is required.
from lex import tokens

def p_programa(p):
    'programa : lista_declaracao'

def p_lista_declaracao(p):
    """
    lista_declaracao : declaracao LD
                      
    """

def p_LD(p):
    """
    LD : declaracao LD
       | empty
                      
    """

def p_declaracao(p):
    """
    declaracao : declaracao_variaveis
              | declaracao_funcoes
    """

def p_declaracao_funcoes(p):
    """
    declaracao_funcoes : tipo ID apar parametros fpar declaracao_composta
    """

def p_declaracao_variaveis(p):
    """
    declaracao_variaveis : tipo ID DV
                        
    """

def p_tipo(p):
    """
    tipo : INT
        | VOID
    """

def p_DV(p):
    """
    DV : pv
      | acol numero fcol pv
    """

def p_parametros(p):
    """
    parametros : apar PR
                | empty
    """

def p_declaracao_composta(p):
    """
    declaracao_composta : acha declaracoes_locais lista_comandos fcha
    """

def p_PR(p):
    """
    PR : lista_parametros fpar
        | VOID fpar
    """

def p_lista_comandos(p):
    """
    lista_comandos : LC
    """

def p_lista_parametros(p):
    """
    lista_parametros : param LP
    """

def p_LC(p):
    """
    LC : comandos LC
        | empty
    """

def p_LP(p):
    """
    LP : vir param LP
       | empty 
    """

def p_param(p):
    """
    param : tipo ID P
    """

def p_comandos(p):
    """
    comandos : declaracao_expressao
           | declaracao_composta
           | declaracao_selecao
           | declaracao_iteracao
           | declaracao_retorno
    """

def p_P(p):
    """
    P : acol fcol
      | empty
    """

def p_declaracao_expressao(p):
    """
    declaracao_expressao : expressao pv
             | pv
    """

def p_declaracao_selecao(p):
    """
    declaracao_selecao : IF apar expressao fpar comandos DS
    """

def p_declaracao_iteracao(p):
    """
    declaracao_iteracao : WHILE apar expressao fpar comandos
    """

def p_declaracao_retorno(p):
    """
    declaracao_retorno : RETURN DR
    """

def p_expressao(p):
    """
    expressao : variavel atr expressao
             | expressao_simples
    """

def p_declaracoes_locais(p):
    """
    declaracoes_locais : DL
    """

def p_DS(p):
    """
    DS : ELSE comandos
      | empty
    """

def p_DR(p):
    """
    DR : pv
      | expressao pv
    """

def p_variavel(p):
    """
    variavel : ID V
    """

def p_expressao_simples(p):
    """
    expressao_simples : soma_expressao ES
    """

def p_DL(p):
    """
    DL : declaracao_variaveis DL
      | empty
    """

def p_V(p):
    """
    V : acol expressao fcol
      | empty
    """

def p_soma_expressao(p):
    """
    soma_expressao : termo SE
    """
    
def p_ES(p):
    """
    ES : op_relacional soma_expressao ES
       | empty
    """
    
def p_termo(p):
    """
    termo : fator T
    """

def p_SE(p):
    """
    SE : soma termo SE
       |  empty
    """

def p_op_relacional(p):
    """
    op_relacional : menig
                 | men
                 | mai
                 | maiig
                 | ig
                 | dif
    """

def p_soma(p):
    """
    soma : add
        | sub
    """

def p_mult(p):
    """
    mult : mlt
        | divv
    """

def p_fator(p):
    """
    fator : apar expressao fpar
         | variavel
         | ativacao
         | numero
    """

def p_T(p):
    """
    T :  mult fator T
      | empty
    """

def p_ativacao(p):
    """
    ativacao : ID apar argumentos fpar
    """

def p_argumentos(p):
    """
    argumentos : lista_argumentos
              | empty
    """

def p_lista_argumentos(p):
    """
    lista_argumentos : expressao LA
    """

def p_LA(p):
    """
    LA : vir expressao LA
        | empty
    """

def p_empty(p):
     """
     empty :
     """
     pass 

def p_empty(p):
     """
     empty :
     """
     pass 

# Error rule for syntax errors
def p_error(p):
    print("Syntax error in input!")

#def t_comment1(t):
#    r'(/\*(.|\n)*?\*/)'
#    pass

# Line comment
#def t_comment2(t):
#    r'(//.*?(\n|$))'
#    pass

# Build the parser
parser = yacc.yacc()