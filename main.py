data = """int main( ){
    int x;
    x = 2;

    return 1;
}
"""

from yacc_2 import *
from lex import *

# Run a preprocessor
import sys

try:
    with open(sys.argv[1]) as f:
        entrada = f.read()
    
except:
    entrada = data


while True:
    try:
        tok = parser.parse(entrada,lexer=lexer,debug=True)
        if not tok:
            print(" - - - - - - - - - - CODIGO VALIDO! - - - - - - - - - - ")
            break
    except:
        print(" - - - - - - - - - - CODIGO INVALIDO! - - - - - - - - - - ")
        break


