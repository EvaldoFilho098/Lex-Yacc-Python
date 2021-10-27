# Yacc example
 
import ply.yacc as yacc

# Get the token map from the lexer.  This is required.
from lex import tokens

def p_programa(p):
    'programa : lista_declaracao'
    p[0] = p[1]

def p_lista_declaracao(p):
    """
    lista_declaracoes: lista_declaracao declaracao
                     | declaracao 
    """

def p_declaracao(p):
    """
    declaracao: declaracao_variaveis
              | declaracao_funcoes
    """

def p_declaracao_variaveis(p):
    """
    declaracao_variaveis: tipo ID ;
                        | tipo ID[ NUM ];
    """

def p_tipo(p):
    """
    tipo: int
        | void
    """

def p_declaracao_funcoes(p):
    """
    declaracao_funcoes: tipo ID ( parametros ) declaracao_composta
    """

def p_parametros(p):
    """
    parametros: lista_parametros
              | void
    """

def p_lista_parametros(p):
    """
    lista_parametros: lista_parametros , param 
                    | param 
    """

def p_param(p):
    """
    param: tipo ID
         | tipo ID []
    """

def p_declaracao_composta(p):
    """
    declaracao_composta: { declaracoes_locais lista comandos }
    """

def p_declaracoes_locais(p):
    """
    declaracoes_locais: declaracoes_locais declaracao_variaveis
                      | 
    """

def p_lista_comandos(p):
    """
    lista_comandos: lista_comandos comando
                  | 
    """

def p_comando(p):
    """
    comando: declaracao_expressao
           | declaracao_composta
           | declaracao_selecao
           | declaracao_iteracao
           | declaracao_retorno
    """

def p_declaracao_expressao(p):
    """
    declaracao_expressao: expressao ;
             | ;
    """

def p_declaracao_selecao(p):
    """
    declaracao_selecao: if ( expressao ) comando
                      | if ( expressao ) comando else comando
    """

def p_declaracao_iteracao(p):
    """
    declaracao_iteracao: while ( expressao ) comando
    """

def p_declaracao_retorno(p):
    """
    declaracao_retorno: return ;
                      | return expressao ;
    """

def p_expressao(p):
    """
    expressao: variavel = expressao
             | expressao_simples
    """

def p_variavel(p):
    """
    variavel: ID
            | ID [ expressao ]
    """

def p_expressao_simples(p):
    """
    expressao_simples: soma_expressao op_relacional soma_expressao
                     | soma_expressao
    """

def p_op_relacional(p):
    """
    op_relacional: <=
                 | <
                 | >
                 | >=
                 | ==
                 | !=
    """

def p_soma_expressao(p):
    """
    soma_expressao: soma_expressao soma termo
                  | termo
    """

def p_soma(p):
    """
    soma: +
        | -
    """

def p_termo(p):
    """
    termo: termo mult fator
         | fator
    """

def p_mult(p):
    """
    mult: *
        | /
    """

def p_fator(p):
    """
    fator: ( expressao )
         | variavel
         | ativacao
         | NUM
    """

def p_ativacao(p):
    """
    ativacao: ID ( argumentos )
    """

def p_argumentos(p):
    """
    argumentos: lista_argumentos
              | 
    """

def p_lista_argumentos(p):
    """
    lista_argumentos: lista_argumentos , expressao
                    | expressao
    """
    
def p_expression_plus(p):
    'expression : expression PLUS term'
    p[0] = p[1] + p[3]

def p_expression_minus(p):
    'expression : expression MINUS term'
    p[0] = p[1] - p[3]

def p_expression_term(p):
    'expression : term'
    p[0] = p[1]

def p_term_times(p):
    'term : term TIMES factor'
    p[0] = p[1] * p[3]

def p_term_div(p):
    'term : term DIVIDE factor'
    p[0] = p[1] / p[3]

def p_term_factor(p):
    'term : factor'
    p[0] = p[1]

def p_factor_num(p):
    'factor : NUMBER'
    p[0] = p[1]

def p_factor_expr(p):
    'factor : LPAREN expression RPAREN'
    p[0] = p[2]

# Error rule for syntax errors
def p_error(p):
    print("Syntax error in input!")

# Build the parser
parser = yacc.yacc()

while True:
    try:
        s = input('calc > ')
    except EOFError:
        break
    if not s: continue
    result = parser.parse(s)
    print(result)