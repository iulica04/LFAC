%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "limbaj.tab.h"
%}
%option noyywrap
%%
"int" {yylval.string = strdup(yytext); return INT;}
"float" {yylval.string = strdup(yytext); return FLOAT;}
"char" {yylval.string = strdup(yytext); return CHAR;}
"string" {yylval.string = strdup(yytext); return STRING;}
"bool" {yylval.string = strdup(yytext); return BOOL;}
"void" {yylval.string = strdup(yytext); return VOID;}
"const" {yylval.string = strdup(yytext); return CONST;}
"true" {yylval.string = strdup(yytext); return TRUE;}
"false" {yylval.string = strdup(yytext); return FALSE;}
"begin_progr" {return BGIN_PROG;}
"end_progr" {return END_PROG;}
"begin_main" {return BGIN_MAIN;}
"end_main" {return END_MAIN;}
"myClass" {return MYCLASS;}
"begin_clasa" {return BGIN_CLASS;}
"end_clasa" {return END_CLASS;}
"eval" {return EVAL;}
"TypeOf" {return TYPEOF;}

"++" {return ARITMETIC_INCREMENT;}
"--" {return ARITMETIC_DECREMENT;}
"<=" {return LEQ;}
">=" {return GEQ;}
"!=" {return NEQ;}
"==" {return EQ;}
"&&" {return AND;}
"||" {return OR;}
"if" {return IF;}
"else" {return ELSE;}
"end_if" {return EIF;}
"for" {return FOR;}
"begin_function" {return BFCT;}
"end_function" {return EFCT;}
"end_for" {return EFOR;}
"do" {return DO;}
"while" {return WHILE;}
"end_while" {return EWHILE;}

[a-zA-Z][a-zA-Z0-9]* {yylval.string = strdup(yytext); return ID;}             // declarari variabile
":=" {return ASSIGN;}                                                         // asignare 
-?[0-9]*|0 {yylval.string = strdup(yytext); return NUMAR;}                           //numar natural
[-+]?[0-9]+.[0-9]+ {yylval.string = strdup(yytext); return NUMAR_FLOAT;}                //numar float 
\'[a-zA-Z]\' {yylval.string=strdup(yytext); return CARACTER;}                       // caracter 
\"[a-zA-Z0-9]+\" {yylval.string=strdup(yytext); return SIR;}                     // string
[ \t] ;                                                          
\n {yylineno++;}                                                             // linie noua 
. {return yytext[0];}
%%
