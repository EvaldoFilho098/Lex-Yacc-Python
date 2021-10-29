data = """int main( ){
    int x;
    x = 2;
    }
"""
'''
while True:
    
    try:
        result = parser.parse(data)
        print("DEU BOM!")
    except:
        print("DEU RUIM!")
'''

from yacc_2 import *
from lex import *

#x = parser.parse(input=data,lexer=lexer)
#print(x)

#import ply.lex as lex
#lexer = lex.lex()

# Run a preprocessor
#import sys
#with open(sys.argv[1]) as f:
#    input = f.read()

while True:
    tok = parser.parse(data,lexer=lexer,debug=True)
    if not tok:
        break
    
    print(tok)

