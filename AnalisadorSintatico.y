%{

#include <stdio.h>
#include <stdlib.h>

int yyerror( char *s );

typedef struct No {
	char * nome;
	int n;
	struct No** filhos;
	int f;
}No;

typedef struct Celula {
	No* C;
	struct Celula* proximo;
}Celula;				

typedef struct Pilha {
	Celula * Topo;
}Pilha;

Pilha *P;


Pilha * CriaPilha ( Pilha *Pi){
	Pi = (Pilha*)malloc(sizeof(Pilha));
	Pi->Topo = NULL;
	return Pi;
}

void InserePilha ( No* N, Pilha *Pi){
	Celula* C = (Celula*)malloc(sizeof(Celula));
	C->C = N;
	if(Pi->Topo == NULL){
		Pi->Topo = C;
		C->proximo = NULL;
	}else{
		C->proximo = Pi->Topo;
		Pi->Topo = C;
		
	}
}

void RemovePilha ( Pilha *Pi){
 	Celula*temp = Pi->Topo;
 	
 	if(temp == NULL)
 		return;
	 
	if( temp->proximo != NULL){
 		Pi->Topo = temp->proximo;
 	}else{
		Pi->Topo = NULL; 
	}
	free(temp);

}

No * new_No( char *N , int n, int f ){
	No* novo = (No*) malloc(sizeof(No));
	novo->n = n;
	novo->f = f;
	novo->nome = (char*)malloc(sizeof(char)*n);
	novo->nome = N;
	if(f > 0)
		novo->filhos = (No**)malloc(sizeof(No*)*f);
	else
		novo->filhos = NULL;
		
	return novo;
}

No * Reduz (Pilha *Pi, No* N, int h ){
	Celula* temp = Pi->Topo;
	int i;
	
	for ( i = h-1; i >= 0 ; i-- ) {
		N->filhos[i] = temp->C;
		temp = temp->proximo;
		RemovePilha(Pi);
	}
	return N;
}

void Imprime ( No*R ){
	int i;
	if( R != NULL){
		printf("-------------------------------------\n");
		printf("%s\n",R->nome);
		for ( i = 0; i < R->f ; i++){
			printf("Filho[%i] = %s\n",i+1,R->filhos[i]->nome);
		}
		for (i = 0; i < R->f ; i++){
			Imprime(R->filhos[i]);
		}
	}
}

%}

%token numero
%token ID
%token IF
%token ELSE
%token INT
%token VOID
%token RETURN
%token WHILE
%token add
%token sub
%token mlt
%token divv
%token men
%token mai
%token atr
%token menig
%token maiig
%token ig
%token dif
%token pv
%token vir
%token apar
%token fpar
%token acol
%token fcol
%token acha
%token fcha

%start Programa

%%

Programa				:Lista_Declar { No* novo = new_No("Programa",8,1);
									  novo = Reduz(P,novo,1);
									  InserePilha(novo,P);
									  Imprime(novo);
								    }
						;			

Lista_Declar			: Declar LD  { No* novo = new_No("Lista_Declar",12,2);
									  novo = Reduz(P,novo,2);
									  InserePilha(novo,P);
								    }
						;

LD						:Declar LD  { No* novo = new_No("LD",2,2);
									  novo = Reduz(P,novo,2);
									  InserePilha(novo,P);
								    }
						|/*Empty*/ {
						   No* novo = new_No("LD",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Declar					:Declar_Var {
									 No* novo = new_No("Declar",6,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						|Declar_Func {
									 No* novo = new_No("Declar",6,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						;
						
Declar_Func 			:tipo ID Parametros Declar_Comp {
									 No* novo = new_No("Declar_Func",11,4);
									 novo = Reduz(P,novo,4);
									 InserePilha(novo,P);
								    }
						;
						
Declar_Var				:tipo ID DV { No* novo = new_No("Declar_Var",10,3);
									  novo = Reduz(P,novo,3);
									  InserePilha(novo,P);
								    }
						;
						
tipo					:INT { 
						  	   No* novo = new_No("tipo",4,1);
							   novo = Reduz(P,novo,1);
							   InserePilha(novo,P);	
							}
						|VOID {
								 No* novo = new_No("void",4,1);
								 novo = Reduz(P,novo,1);
								 InserePilha(novo,P);
							    }
						;

DV						:pv { 
							No* novo = new_No("DV",2,1);
							novo = Reduz(P,novo,1);
							InserePilha(novo,P);
 							}
						|acol numero fcol pv {
									 No* novo = new_No("DV",2,4);
									 novo = Reduz(P,novo,4);
									 InserePilha(novo,P);
								    }
						;

Parametros				:apar PR {
									 No* novo = new_No("Parametros",10,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;
						
Declar_Comp				:acha Declar_Loc Lista_Cmd fcha {
									 No* novo = new_No("Declar_Comp",11,4);
									 novo = Reduz(P,novo,4);
									 InserePilha(novo,P);
								    }
						;

PR						:Lista_Param fpar {
									 No* novo = new_No("PR",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						|VOID fpar {
									 No* novo = new_No("PR",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;
						
Lista_Cmd				: LC {
							 No* novo = new_No("Lista_Cmd",10,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;
						
Lista_Param				: Param LP {
								 No* novo = new_No("Lista_Param",11,2);
								 novo = Reduz(P,novo,2);
								 InserePilha(novo,P);
							    }
						;

LC						: Comandos LC {
									 No* novo = new_No("LC",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("LC",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;

LP						: vir Param LP{
									 No* novo = new_No("LP",2,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("LP",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Param					: tipo ID P {
									 No* novo = new_No("Param",5,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						;

Comandos				: Declar_Exp  {
									 No* novo = new_No("Comandos",8,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						| Declar_Comp {
									 No* novo = new_No("Comandos",8,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						| Declar_Sel {
									 No* novo = new_No("Comandos",8,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						| Declar_Iter {
									 No* novo = new_No("Comandos",8,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						| Declar_Ret {
									 No* novo = new_No("Comandos",8,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						;

P						: acol fcol {
									 No* novo = new_No("P",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("P",1,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Declar_Exp				: Expr pv {
									 No* novo = new_No("Declar_Exp",10,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						| pv {
							 No* novo = new_No("Declar_Exp",10,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;
				
Declar_Sel				: IF apar Expr fpar Comandos DS {
									 No* novo = new_No("Declar_Sel",10,6);
									 novo = Reduz(P,novo,6);
									 InserePilha(novo,P);
								    }
						;
						
Declar_Iter				: WHILE apar Expr fpar Comandos {
									 No* novo = new_No("Declar_Iter",11,5);
									 novo = Reduz(P,novo,5);
									 InserePilha(novo,P);
								    }
						;

Declar_Ret				: RETURN DR {
									 No* novo = new_No("Declar_Ret",10,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;

Expr					: Variavel atr Expr{
									 No* novo = new_No("Expr",4,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						| Expr_Simpl {
									 No* novo = new_No("Expr",4,1);
									 novo = Reduz(P,novo,1);
									 InserePilha(novo,P);
								    }
						;

Declar_Loc				: DL {
							 No* novo = new_No("Declar_Loc",10,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;
						
DS						: ELSE Comandos {
									 No* novo = new_No("DS",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("DS",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;


DR						: pv {
							 No* novo = new_No("DR",2,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| Expr pv {
							 No* novo = new_No("DR",2,2);
							 novo = Reduz(P,novo,2);
							 InserePilha(novo,P);
						    }
						;

Variavel				: ID V {
							 No* novo = new_No("Variavel",8,2);
							 novo = Reduz(P,novo,2);
							 InserePilha(novo,P);
						    }
						;
						
Expr_Simpl				: Soma_Expr ES {
									 No* novo = new_No("Expr_Simpl",10,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;

DL						: Declar_Var DL {
									 No* novo = new_No("DL",2,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("DL",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;

V						: acol Expr fcol {
									 No* novo = new_No("V",1,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("V",1,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Soma_Expr				: Termo SE {
									 No* novo = new_No("Declar_Sel",9,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;

ES						: Op_Relac Soma_Expr ES {
									 No* novo = new_No("ES",2,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("ES",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Termo					: Fator T {
									 No* novo = new_No("Termo",5,2);
									 novo = Reduz(P,novo,2);
									 InserePilha(novo,P);
								    }
						;

SE						: Soma Termo SE {
									 No* novo = new_No("SE",2,3);
									 novo = Reduz(P,novo,3);
									 InserePilha(novo,P);
								    }
						| /*Empty*/ {
						   No* novo = new_No("SE",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Op_Relac				: mai {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| men {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| maiig {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| menig {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| ig {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| dif {
							 No* novo = new_No("Op_Relac",8,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;
						
Soma					: add {
							 No* novo = new_No("Soma",4,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| sub {
							 No* novo = new_No("Soma",4,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;

Mult					: mlt {
							 No* novo = new_No("Mult",4,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| divv {
							 No* novo = new_No("Mult",4,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;
						
Fator					: apar Expr fpar {
							 No* novo = new_No("Fator",5,3);
							 novo = Reduz(P,novo,3);
							 InserePilha(novo,P);
						    }
						| Variavel {
							 No* novo = new_No("Fator",5,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| Ativacao {
							 No* novo = new_No("Fator",5,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| numero {
							 No* novo = new_No("Fator",5,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						;		

T						: Mult Fator T {
							 No* novo = new_No("T",1,3);
							 novo = Reduz(P,novo,3);
							 InserePilha(novo,P);
						    }
						| /*Empty*/ {
						   No* novo = new_No("T",1,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Ativacao				: ID apar Argumentos fpar {
							 No* novo = new_No("Ativacao",8,4);
							 novo = Reduz(P,novo,4);
							 InserePilha(novo,P);
						    }
						;

Argumentos				: Lista_Argumentos {
							 No* novo = new_No("Argumentos",10,1);
							 novo = Reduz(P,novo,1);
							 InserePilha(novo,P);
						    }
						| /*Empty*/ {
						   No* novo = new_No("Argumentos",10,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
						;
						
Lista_Argumentos		: Expr LA {
							 No* novo = new_No("Lista_Argumentos",16,2);
							 novo = Reduz(P,novo,2);
							 InserePilha(novo,P);
						    }
						; 

LA						: vir Expr LA {
							 No* novo = new_No("LA",2,3);
							 novo = Reduz(P,novo,3);
							 InserePilha(novo,P);
						    }
 						|/*Empty*/ {
						   No* novo = new_No("LA",2,1);
						   No* vazio = new_No("#",1,0);
						   InserePilha(vazio,P);
						   novo = Reduz(P,novo,1);
						   InserePilha(novo,P);
					   	 }
					   	;
										

%%
#include "lex.yy.c"

int aux = 0;

int main() { 
	
	/*char arquivo[30];
	printf("Insira o nome do arquivo:\n");
	scanf("%s",&arquivo);
	FILE *R = fopen(arquivo,"r");*/
	
	FILE *R = fopen("emailsC.txt","r");	
	
	No* fim = new_No("$",1,0);
	P = CriaPilha(P);
	InserePilha (fim,P);
	
	yyin = R;

    yyparse();
	
} 

int yyerror( char *s ) { 
						
						if( aux != linha){
							fprintf(stderr, " ----------------------- %s Na linha: %i ------------------------\n", s,linha);
						 	aux = linha; 
						}
							yyparse();
						 }


