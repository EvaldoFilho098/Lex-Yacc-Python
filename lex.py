# ------------------------------------------------------------
 # calclex.py
 #
 # tokenizer for a simple expression evaluator for
 # numbers and +,-,*,/
 # ------------------------------------------------------------
import ply.lex as lex
 
 # List of token names.   This is always required
tokens = (
    'digito',
    'letra',
    'numero',
    'ID',
    'IF',
    'ELSE',
    'INT',
    'VOID',
    'RETURN',
    'WHILE',
    'add',
    'sub',
    'mlt',
    'divv',
    'men',
    'mai',
    'atr',
    'menig',
    'maiig',
    'ig',
    'dif',
    'pv',
    'vir',
    'apar',
    'fpar',
    'acol',
    'fcol',
    'acha',
    'fcha',
    'pcom',
    'fcon',
    'pas',
    'esp',
    'tab',
    'ttab',
    'lin',
    'alf',
    'exc',
    'car',
    'bug',
    'erro'
 )
 
t_digito = r'[0-9]'
t_letra = r'[a-zA-Z]'
t_numero = r'{t_digito}+'
t_ID = r'{t_letra}+'

t_IF = r'if'
t_ELSE = r'else'
t_INT = r'int'
t_VOID = r'void'
t_RETURN = r'return'
t_WHILE = r'while'

t_add = r'\+'
t_sub = r'-'
t_mlt = r'\*'
t_divv = r'/'
t_men = r'<'
t_mai = r'>'
t_atr = r'='
t_menig = r'<='
t_maiig = r'>='
t_ig = r'=='
t_dif = r'!='
t_pv = r';'
t_vir = r','
t_apar = r'\('
t_fpar = r'\)'
t_acol = r'\['
t_fcol = r'\]'
t_acha = r'\{'
t_fcha = r'\}'
t_pcom = r'/\*'
t_fcon = r'\*/'
t_pas = r'\\0'
#t_esp = r' '
#t_tab = None
#t_ttab = None
#t_lin = r'\\n'
#t_alf = None
#t_exc = None
#t_car = None
#t_bug = None
#t_erro = None
#reserved = {
#    'if' : 'IF',
#    'else' : 'ELSE',
#    'int' : 'INT',
#    'void' : 'VOID',
#    'return' : 'RETURN',
#    'while' : 'WHILE',
# }
# Regular expression rules for simple tokens
#t_PLUS    = r'\+'
#t_MINUS   = r'-'
#t_TIMES   = r'\*'
#t_DIVIDE  = r'/'
#t_LPAREN  = r'\('
#t_RPAREN  = r'\)'
 
 # A regular expression rule with some action code
#def t_NUMBER(t):
    #r'\d+'
    #t.value = int(t.value)    
    #return t

# Define a rule so we can track line numbers
def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

# A string containing ignored characters (spaces and tabs)
t_ignore  = ' \t'

# Error handling rule
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# Build the lexer
lexer = lex.lex()