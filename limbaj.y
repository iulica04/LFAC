%{
#include <iostream>
#include <vector>
#include <string>
#include "IdList.h"
#include "AST.h"
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
extern int yylex();
void yyerror(const char * s);
class IdList ids;

char *Function(char sir1[], char sir2[], char intre[3])
{
    char *p;
    p = (char*)(malloc(strlen(sir1) + strlen(sir2) + 1));
    strcpy(p, sir1);
    strcat(p, intre);
    strcat(p, sir2);
    return p;
}


%}
%union {
    char* string;
    struct AST* tree;
}
%token BGIN_MAIN END_MAIN BGIN_PROG END_PROG ASSIGN 
%token<string> ID INT VOID UNSIGNED STRING CHAR FLOAT BOOL CALCULATE NUMAR NUMAR_FLOAT CARACTER SIR TRUE FALSE CONST ARITMETIC_INCREMENT ARITMETIC_DECREMENT
%type<string> list_param apel_functie
%type<string> param type call_list parametru 
%type <tree> e;
%left '-' '+'
%left '/' '*'
%start progr
%%

progr: BGIN_PROG global block END_PROG {printf("The program is correct!\n");}
     ;

global :  decl_variabile ';'     
          | functii ';'     
	      | global decl_variabile ';'  
          | global functii ';'
	      ;

decl_variabile : INT ID 
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | FLOAT ID 
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | CHAR ID 
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | STRING ID 
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | BOOL ID 
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | INT ID ASSIGN NUMAR
      {
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, $4);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      
      | FLOAT ID ASSIGN NUMAR_FLOAT
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, $4);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | CHAR ID ASSIGN CARACTER
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, $4);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | STRING ID ASSIGN SIR
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, $4);
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | BOOL ID ASSIGN TRUE
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, "true");
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | BOOL ID ASSIGN FALSE
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addVar($1,$2);
                ids.updateVarValue($2, "false");
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | INT ID '['NUMAR']'
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addArray($1,$2, atoi($4));
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | CHAR ID '['NUMAR']'
        { 
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2)) 
            {
                ids.addArray($1,$2, atoi($4));
            }
            else
           {
                yyerror("Error: Variable exists.");
           }
        }
      | CONST INT ID ASSIGN NUMAR
        {
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
            {
                ids.addConstant($2, $3, $5);
            }
            else
            {
                yyerror("Error: Variable exists.");
            }
        }
      | CONST FLOAT ID ASSIGN NUMAR_FLOAT
        {
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
            {
                ids.addConstant($2, $3, $5);
            }
            else
            {
                yyerror("Error: Variable exists.");
            }
        }
      | CONST CHAR ID ASSIGN CARACTER
        {
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
            {
                ids.addConstant($2, $3, $5);
            }
            else
            {
                yyerror("Error: Variable exists.");
            }
        }
      | CONST STRING ID ASSIGN SIR
        {
            if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
            {
                ids.addConstant($2, $3, $5);
            }
            else
            {
                yyerror("Error: Variable exists.");
            }
        }
      ;

functii : | INT ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | FLOAT ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | BOOL ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | STRING ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | CHAR ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | VOID ID '(' list_param ')'
      {
           if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, $4);
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | INT ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | FLOAT ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | BOOL ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | CHAR ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | STRING ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }
      | VOID ID '(' ')' 
      {
        if(!ids.existsVar($2) && !ids.existsArray($2) && !ids.existsFunction($2) && !ids.existsConstant($2))
           {
                ids.addFunction($1, $2, "");
           }
           else
           {
                yyerror("Error: Variable exists.");
           }
      }

list_param : param
           {
              $$ = $1;
           }
           | param ',' list_param
           {
               $$ = Function($1, $3, ", ");
           }
           ;

param : type ID
      {
          $$ = Function($1, $2, " ");
      }

type : INT
       {
          $$ = $1;
       }
     | FLOAT
       {
          $$ = $1;
       }
     | STRING
       {
          $$ = $1;
       }
     | CHAR
       {
          $$ = $1;
       }
     | BOOL
       {
          $$ = $1;
       }
     | VOID
       {
          $$ = $1;
       }
       ;


block : BGIN_MAIN list END_MAIN
     ;
     

list :  asignare ';' 
     | incrementare ';'
     | decrementare ';'
     | apel_functie ';'
     | list asignare ';'
     | list incrementare ';'
     | list decrementare ';'
     | list apel_functie ';'
     ;

asignare :  ID ASSIGN CARACTER
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1))
                {
                    string varType = ids.getVarType($1);
                    if(varType == "char")
                    {
                        ids.updateVarValue($1, $3);
                    } else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                } else
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID ASSIGN SIR
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1))
                {
                    string varType = ids.getVarType($1);
                    if(varType == "string")
                    {
                        ids.updateVarValue($1, $3);
                    } else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                } else
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID ASSIGN TRUE
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1))
                {
                    string varType = ids.getVarType($1);
                    if(varType == "bool")
                    {
                        ids.updateVarValue($1, "true");
                    } else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                } else
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID ASSIGN FALSE 
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1))
                {
                    string varType = ids.getVarType($1);
                    if(varType == "bool")
                    {
                        ids.updateVarValue($1, "false");
                    } else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                } else
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID '[' NUMAR ']' ASSIGN CARACTER
          {
            if(ids.existsArray($1))
                {
                    string varType = ids.getArrayType($1);
                    if(varType == "char")
                    {
                        int index = atoi($3);
                        if (index >= 0 && index < ids.getArraySize($1))
                        {
                            ids.updateArrayValue($1, index, $6);
                        }
                        else
                        {
                            yyerror("Error: Invalid array index.");
                        }
                    }
                    else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                }
                else
                {
                    yyerror("Error: Variable not declared.");
                }
          }
          | ID '['NUMAR ']' ASSIGN STRING
          {
            if(ids.existsArray($1))
                {
                    string varType = ids.getArrayType($1);
                    if(varType == "string")
                    {
                        int index = atoi($3);
                        if (index >= 0 && index < ids.getArraySize($1))
                        {
                            ids.updateArrayValue($1, index, $6);
                        }
                        else
                        {
                            yyerror("Error: Invalid array index.");
                        }
                    }
                    else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                }
                else
                {
                    yyerror("Error: Variable not declared.");
                }
          }
          | ID '[' NUMAR ']' ASSIGN NUMAR_FLOAT
          {
            if(ids.existsArray($1))
                {
                    string varType = ids.getArrayType($1);
                    if(varType == "float")
                    {
                        int index = atoi($3);
                        if (index >= 0 && index < ids.getArraySize($1))
                        {
                            ids.updateArrayValue($1, index, $6);
                        }
                        else
                        {
                            yyerror("Error: Invalid array index.");
                        }
                    }
                    else
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                }
                else
                {
                    yyerror("Error: Variable not declared.");
                }
          }
          | ID ASSIGN apel_functie
          {
            if(ids.existsVar($1))
            {
                if(ids.existsFunction($3))
                {
                    string VarType = ids.getVarType($1);
                    string FunctionType = ids.getFunctionType($3);
                    if(VarType != FunctionType)
                    {
                        yyerror("Error: Tipuri diferite.");
                    }
                }
                else
                {
                    yyerror("Error: Function not declared...or ...");
                }
            }
            else 
            {
                yyerror("Error: Variable not declared.");
            }
          }
          | ID '[' NUMAR ']' ASSIGN apel_functie
          {
             if(ids.existsArray($1))
             {
                if(ids.existsFunction($6))
                {
                    string ArrayType = ids.getArrayType($1);
                    string FunctionType =ids.getFunctionType($6);
                    if(ArrayType != FunctionType)
                    {
                        yyerror("Error: Tipuri diferite.");
                    }
                } else
                {
                    yyerror("Error: Function not declared...or ...");
                }
            }
            else 
            {
                yyerror("Error: Array not declared.");
            }
             
          }
          | ID ASSIGN e
          {
            if(ids.existsVar($1))
            {
                int val = evalAST($3, ids);
                string Val = to_string(val);
                ids.updateVarValue($1, Val);
            }
            else
            {
                yyerror("Error: Variable not exists.");
            }
          }
          | ID '['NUMAR']' ASSIGN e
          {
            if(ids.existsArray($1))
            {
                int index = atoi($3);
                if (index >= 0 && index < ids.getArraySize($1))
                {
                    int val = evalAST($6, ids);
                    string Val = to_string(val);
                    ids.updateArrayValue($1, index, Val);
                }
                else
                {
                    yyerror("Error: Invalid array index.");
                }

                
            }
            else
            {
                yyerror("Error: Array not exists.");
            }
          }
          ;

e : e '+' e {$$ = buildAST("+", $1, $3, OPERATOR);}
  | e '-' e {$$ = buildAST("-", $1, $3, OPERATOR);}
  | e '/' e {$$ = buildAST("/", $1, $3, OPERATOR);}
  | e '*' e {$$ = buildAST("*", $1, $3, OPERATOR);}
  | ID 
  { 
    if(ids.existsVar($1))
    {
     $$ = buildAST($1, NULL, NULL, IDENTIFICATOR);
    }
    else if(ids.existsConstant($1))
    {
        $$ = buildAST($1, NULL, NULL, IDENTIFICATOR);
    }
  }
  | NUMAR
  {
    $$ = buildAST($1, NULL, NULL, NR_NATURAL);
  }
  | ID '['NUMAR']'
  {
    string element = $1 + string("[") + $3 + string("]");
    $$ = buildAST(element, NULL, NULL, ARRAY_ELEMENT);
  }
  
  ;
          

incrementare : ID ARITMETIC_INCREMENT
                {
                    ids.incrementVar($1);
                }
              | ID '['NUMAR']' ARITMETIC_INCREMENT
                {
                    ids.incrementArrayElement($1, atoi($3));
                }
                ;

decrementare : ID ARITMETIC_DECREMENT
               {
                    ids.decrementVar($1);
               }
             | ID '['NUMAR']' ARITMETIC_DECREMENT
               {
                    ids.decrementArrayElement($1, atoi($3)); 
               }

apel_functie : ID'('call_list')'
              {
                if(ids.existsFunction($1))
                {
                    if(!ids.matchFunctionArguments($1, $3))
                    {
                        yyerror("Error: Numele functii este incorect sau numarul de parametrii nu este egal cu numarul de parmetrii cu care este declaarata functia sau tipurile parametrilor difera de tipurile parametrilor declarati.");
                    }
                    else
                    {
                        $$ = $1;
                    }
                }
                else
              {
                yyerror("Error: Function not declared.");
              }
              } 
              | ID '('')'
              {
                if(!ids.existsFunction($1))
                {
                    yyerror("Error: Function not declred.");
                }
                else
                {
                    $$ = $1;
                }
              }
              ;

call_list : parametru
           {
               $$ = $1;
           }
           | call_list ',' parametru
           {
               $$ = Function($1, $3, ", ");
           }
           ;

parametru : ID
      {
           if(ids.existsVar($1))
           {
           string varType = ids.getVarType($1);
           char type[10];

           if(varType == "int")
           {
                strcpy(type, "int");
           }
           else if(varType == "float")
           {
               strcpy(type, "float");
           }
           else if(varType == "unsigned")
           {
               strcpy(type, "unsigned");
           } 
           else if(varType == "char")
           {
               strcpy(type, "char");
           } 
           else if(type == "bool")
           {
               strcpy(type, "bool");
           } 
           else if(varType == "string")
           {
               strcpy(type, "string");
           } 

           $$ = Function(type, $1, " ");
           }
           else if(ids.existsConstant($1))
           {
            string varType = ids.getConstType($1);
           char type[10];

           if(varType == "int")
           {
                strcpy(type, "int");
           }
           else if(varType == "float")
           {
               strcpy(type, "float");
           }
           else if(varType == "unsigned")
           {
               strcpy(type, "unsigned");
           } 
           else if(varType == "char")
           {
               strcpy(type, "char");
           } 
           else if(type == "bool")
           {
               strcpy(type, "bool");
           } 
           else if(varType == "string")
           {
               strcpy(type, "string");
           } 

           $$ = Function(type, $1, " ");
           }
           else
           {
             yyerror("Error: Variable not exists.");
           }
      }
      | NUMAR
      {
          $$ = Function("int", $1, " ");
      }
      | NUMAR_FLOAT
      {
          $$ = Function("float", $1, " ");
      }
      | CARACTER 
      {
          $$ = Function("char", $1, " ");
      }
      | SIR
      {
          $$ = Function("string", $1, " ");
      }
      | TRUE
      {
          $$ = Function("bool", "true", " ");
      }
      | FALSE
      {
          $$ = Function("bool", "false", " ");
      }
      ;
%%

void yyerror(const char * s){
    printf("error: %s at line:%d\n",s,yylineno);
}

int main(int argc, char** argv){
     yyin=fopen(argv[1],"r");
     yyparse();
     ids.printVars();
     ids.printArrays();
     ids.printFunctions();
     ids.printConstants();
}
