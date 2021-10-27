%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

#define yywrap() 1

int linha = 1;

int Potencia10 ( int e ){
	int i,d = 1;
	
	for ( i = 0; i < e; i++ ){
		d = 10*d;
	}
	return d;
}

int Int(char* c, int t){
	int i,x,s = 0;
	for ( i = 0 ; i<t ; i++){
		
		if( *(c+i) == '0'){
			x = 0;
		}else if (*(c+i) == '1'){
			x = 1;
		}else if (*(c+i) == '2'){
			x = 2;
		}else if (*(c+i) == '3'){
			x = 3;
		}else if (*(c+i) == '4'){
			x = 4;
		}else if (*(c+i) == '5'){
			x = 5;
		}else if (*(c+i) == '6'){
			x = 6;
		}else if (*(c+i) == '7'){
			x = 7;
		}else if (*(c+i) == '8'){
			x = 8;
		}else if (*(c+i) == '9'){
			x = 9;
		}
		
		s = x*(Potencia10((t-i)-1)) + s;
	}
		return s;
}

%}

digito	[0-9]
letra   [a-zA-Z]
numero	{digito}+
ID      {letra}+
IF      if
ELSE    else
INT     int
VOID    void
RETURN  return
WHILE   while
add     [+]
sub     [-]
mlt     [*]
divv     [/]
men     [<]
mai     [>]
atr     [=]
menig   {men}{atr}
maiig   {mai}{atr}
ig      {atr}{atr}
dif     !{atr}
pv      [;]
vir     [,]
apar    [(]
fpar    [)]
acol    [[]
fcol    []]
acha    [{]
fcha    [}]
pcom    {divv}{mlt}
fcom    {mlt}{divv}
pas		[\0]
esp     [ ]
tab     {esp}+
ttab	{tab}+
lin     [\n]

alf     {numero}|{ID}|{IF}|{ELSE}|{INT}|{VOID}|{RETURN}|{WHILE}|{add}|{sub}|{mlt}|{divv}|{men}|{mai}|{atr}|{menig}|{maiig}|{if}|{dif}|{pv}|{vir}|{apar}|{fpar}|{acol}|{fcol}|{acha}|{fcha}|{esp}|{lin}|{tab}|{pas}
exc    [^{alf}]

car     {add}|{sub}|{mlt}|{divv}|{men}|{mai}|{atr}|{menig}|{maiig}|{ig}|{dif}|{vir}

bug    {car}{car}+
erro    {ID}{numero}

%%

{pcom}   { char c;
		  int done = FALSE;
		  do {
		     while((c=input()) != '*');
		     while((c=input()) == '*');
		     if(c == '/')
		        done = TRUE;
		  }while(!done);
		}

{IF}    {
			No* novo = new_No("IF",2,0); 
			InserePilha(novo,P);
			return IF;
		   }		
{ELSE}  {
			No* novo = new_No("ELSE",4,0); 
			InserePilha(novo,P);
			return ELSE;
		   }
{INT}    {	No* novo = new_No("INT",3,0); 
			InserePilha(novo,P);
			return INT;
		 }
{VOID}    {
			No* novo = new_No("VOID",4,0); 
			InserePilha(novo,P);
			return VOID;
		   }
{RETURN}    {
			No* novo = new_No("RETURN",6,0); 
			InserePilha(novo,P);
			return RETURN;
		   }
{WHILE}    {
			No* novo = new_No("WHILE",5,0); 
			InserePilha(novo,P);
			return WHILE;
		   }

{add}  {
		No* novo = new_No("+",1,0); 
		InserePilha(novo,P);
		 return add;
	  }
{sub}  {
		No* novo = new_No("-",1,0); 
		InserePilha(novo,P);
		 return sub;
	  }
{mlt}  {
		No* novo = new_No("*",1,0); 
		InserePilha(novo,P);
		 return mlt;
	  }
{divv}  {
		No* novo = new_No("/",1,0); 
		InserePilha(novo,P);
		 return divv;
	  }
{atr}  {
		No* novo = new_No("=",1,0); 
		InserePilha(novo,P);
		 return atr;
	  }
{men}  {
		No* novo = new_No("<",1,0); 
		InserePilha(novo,P);
		 return men;
	  }
{mai}  {
		No* novo = new_No(">",1,0); 
		InserePilha(novo,P);
		 return mai;
	  }
{menig}  {
		No* novo = new_No("<=",2,0); 
		InserePilha(novo,P);
		 return menig;
	  }
{maiig}  {
		No* novo = new_No(">=",2,0); 
		InserePilha(novo,P);
		 return maiig;
	  }
{ig}  {
		No* novo = new_No("==",2,0); 
		InserePilha(novo,P);
		 return ig;
	  }
{dif}  {
		No* novo = new_No("!=",2,0); 
		InserePilha(novo,P);
		 return dif;
	  }
{pv}  {
		No* novo = new_No(";",1,0); 
		InserePilha(novo,P);
		 return pv;
	  }
{vir} {
		No* novo = new_No(",",1,0); 
		InserePilha(novo,P);
		 return vir;
	  }
{apar} {
		No* novo = new_No("(",1,0); 
		InserePilha(novo,P);
		 return apar;
	  }
{fpar} {
		No* novo = new_No(")",1,0); 
		InserePilha(novo,P);
		 return fpar;
	  }
{acol} {
		No* novo = new_No("[",1,0); 
		InserePilha(novo,P);
		 return acol;
	  }
{fcol} {
		No* novo = new_No("]",1,0); 
		InserePilha(novo,P);
		 return fcol;
	  }
{acha} {
		No* novo = new_No("{",1,0); 
		InserePilha(novo,P);
		 return acha;
	  }
{fcha} {
		No* novo = new_No("}",1,0); 
		InserePilha(novo,P);
		 return fcha;
	  }


{esp}|{tab}|{pas}|{ttab} ;

{lin} 	{  linha++; }



{numero} {	
			No* novo = new_No("numero",6,1); 
			int j = 0,i = yyleng; 
			
			novo->filhos[0] = (No*)malloc(sizeof(No));
			novo->filhos[0]->filhos = NULL;
			novo->filhos[0]->f = 0;
			novo->filhos[0]->n = i;
			novo->filhos[0]->nome = (char*)malloc(sizeof(char)*i);
			
			while(yytext[j] != ' '  && yytext[j] != '(' && yytext[j] != '{' && yytext[j] != '[' && yytext[j] != ';' && yytext[j] != '*' && yytext[j] != '/' && yytext[j] != '+' && yytext[j] != '-' ){
				novo->filhos[0]->nome[j] = yytext[j];
				j++;
			}
			
			i = Int (novo->filhos[0]->nome,i);
			
			
			InserePilha(novo,P); 
		    return numero;
		}
{ID}     {
			No* novo = new_No("ID",2,1);
			
			int j = 0,i = yyleng; 
			
			novo->filhos[0] = (No*)malloc(sizeof(No));
			novo->filhos[0]->filhos = NULL;
			novo->filhos[0]->f = 0;
			novo->filhos[0]->n = i;
			novo->filhos[0]->nome = (char*)malloc(sizeof(char)*i);
			
			while(yytext[j] != ' '  && yytext[j] != '(' && yytext[j] != '{' && yytext[j] != '[' && yytext[j] != ';' && yytext[j] != '*' && yytext[j] != '/' && yytext[j] != '+' && yytext[j] != '-' ){
				novo->filhos[0]->nome[j] = yytext[j];
				j++;
			}
			
			
			InserePilha(novo,P);
			
		    return ID;
		}

{erro}|{bug}|{exc}  { printf("-------------------Erro Lexico Na Linha %i-------------------\n",linha);  return 1;}



%%



