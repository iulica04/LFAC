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

char  *Identificator(string varType)
{

    if(varType == "int")
    {
        return "int";
    }
    else if(varType == "float")
    {
        return "float";
    } 
    else if(varType == "char")
    {
         return "char";
    } 
    else if(varType == "bool")
    {
        return "bool";
    } 
    else if(varType == "string")
    {
       return "string";
    }
}


%}
%union {
    int intval;
    char* string;
    struct AST* tree;
}
%token BGIN_MAIN END_MAIN BGIN_PROG END_PROG ASSIGN BGIN_CLASS END_CLASS MYCLASS EVAL TYPEOF
%token<string> ID INT VOID UNSIGNED STRING CHAR FLOAT BOOL CALCULATE NUMAR NUMAR_FLOAT CARACTER SIR TRUE FALSE CONST ARITMETIC_INCREMENT ARITMETIC_DECREMENT 
%type<string> list_param parametru 
%type<string> param type call_list 
%token<string> LEQ GEQ NEQ EQ RETURN BFCT EFCT
%token<string> AND OR
%token<string> TIP CLASS ECLASS IF EIF ELSE
%token<string> FOR EFOR CONSTANT WHILE EWHILE DO
%type <tree> e;
%type <string> opr
%type <intval> cond 
%left '-' '+' 
%left '/' '*'
%left OR 
%left AND
%left NEQ EQ
%left LEQ GEQ '<' '>'
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
      | FLOAT ID '['NUMAR']'
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
      | asignare
        
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
     | if 
     | for 
     | do
     | while
     | list asignare ';'
     | list incrementare ';'
     | list decrementare ';'
     | list apel_functie ';'
     | list if 
     | list for
     | list do
     | list while
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
          | ID ASSIGN e
          {
            if(ids.existsVar($1))
            {
                string varType = ids.getVarType($1);
                string exprType = TypeOf($3, ids, yylineno);
                
                if(varType == exprType)
                {
                    if(varType == "int")
                    {
                        int val = evalAST($3, ids, yylineno);
                        string Val = to_string(val);
                        ids.updateVarValue($1, Val);
                    }
                    else if(varType == "float")
                    {
                        float val = evalASTfloat($3, ids, yylineno);
                        string Val = to_string(val);
                        ids.updateVarValue($1, Val);
                    }
                    else
                    {
                        string name = getNameASTelement($3);
                        if(ids.existsVar(name))
                        {
                            string value = ids.getVarValue(name);
                            ids.updateVarValue($1, value);
                        } else if(ids.existsConstant(name))
                        {
                            string value = ids.getConstValue(name);
                            ids.updateVarValue($1, value);
                        }
                    }
                }
                else
                {
                    yyerror("Error: Incompatible types in assignment.");
                }   
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
                string arrayType = ids.getArrayType($1);
                string exprType = TypeOf($6, ids, yylineno);
                
                if(arrayType == exprType)
                {
                    int index = atoi($3);
                    if (index >= 0 && index < ids.getArraySize($1))
                    {
                        if(arrayType == "int")
                        {
                            int val = evalAST($6, ids, yylineno);
                            string Val = to_string(val);
                            ids.updateArrayValue($1, index, Val);
                        }
                        else if(arrayType == "float")
                        {
                            float val = evalASTfloat($6, ids, yylineno);
                            string Val = to_string(val);
                            ids.updateArrayValue($1, index, Val);
                        }
                        else 
                        {
                            string name = getNameASTelement($6);
                            string value = ids.getVarValue(name);
                            ids.updateArrayValue($1, index, value);
                        }
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
                yyerror("Error: Array not exists.");
            }
          }
          | ID ASSIGN cond
          {
            if(ids.existsVar($1))
            {
                string varType = ids.getVarType($1);
                if(varType == "bool")
                {
                    if($3 == 1)
                    {
                        ids.updateVarValue($1, "true");
                    }
                    else
                    {
                        ids.updateVarValue($1, "false");
                    }
                }
                else
                {
                    yyerror("Error: Invalid assignment.");
                }
            }
            else
            {
                yyerror("Error: Variable not exists.");
            }
          }
          ;

apel_functie : ID '('call_list')'
             {
                if(ids.existsFunction($1))
                {
                   ids.matchFunctionArguments($1, $3, yylineno);
                }
                else 
                {
                    yyerror("Error: Function not exists.");
                }
             }
             | ID '('')'
             {
                if(ids.existsFunction($1))
                {
                    ids.matchFunctionArguments($1, "", yylineno);
                }
                else
                {
                    yyerror("Error: Function not exists.");
                }
             }
             | EVAL '('e')'
             {
                cout << "The value of EVAL at line " << yylineno << " is: " << evalAST($3, ids, yylineno)<< endl;
             }
             | EVAL '('cond')'
             {
                string val;

                if($3 == 0)
                {
                    cout << "The value of EVAL at line " << yylineno << " is: false." << endl;
                }
                else
                {
                    cout << "The value of EVAL at line " << yylineno << " is: true." << endl;
                }
                
             }
             | TYPEOF '('e')'
             {
                cout << "The value of TYPEOF at line " << yylineno << " is: " << TypeOf($3, ids, yylineno) << endl;
             }
             ;

cond : '(' cond ')' {$$ = $2;}
     | cond AND cond { int rez1=$1; int rez2=$3; 
                       $$=(rez1 && rez2);
                
                     }
     | cond OR cond { int rez1=$1; int rez2=$3;
                      $$=(rez1 || rez2);
                    }
     | e opr e { 
                 int rez1=evalAST($1, ids, yylineno); int rez2=evalAST($3, ids, yylineno);
                 if ($2 == "<=") $$=(rez1 <= rez2);
                 if ($2 == ">=") $$=(rez1 >= rez2);
                 if ($2 == "!=") $$=(rez1 != rez2);
                 if ($2 == "==") $$=(rez1 == rez2);
                 if ($2 == ">") $$=(rez1 > rez2);
                 if ($2 == "<") $$=(rez1 < rez2);
            
    }
    ;

opr : LEQ {$$ = $1;}
    | GEQ {$$ = $1;}
    | NEQ {$$ = $1;}
    | EQ  {$$ = $1;}
    | '>' {$$ = ">";}
    | '<' {$$ = "<";}
    ;

if : IF '(' cond ')' list EIF
   | IF '(' cond ')' list ELSE list EIF
   ;

for : FOR '(' type ID ASSIGN e ';' cond ';' incrementare ')' list EFOR
    | FOR '(' type ID ASSIGN e ';' cond ';' decrementare ')' list EFOR
    | FOR '(' ID ASSIGN e ';' cond ';' incrementare')' list EFOR
    | FOR '(' ID ASSIGN e ';' cond ';' decrementare')' list EFOR
    ;

do : DO list WHILE '(' cond ')' ';'
   ;

while : WHILE '(' cond ')' list EWHILE
      ;



e : e '+' e {$$ = buildAST("+", $1, $3, OPERATOR);}
  | e '-' e {$$ = buildAST("-", $1, $3, OPERATOR);}
  | e '/' e {$$ = buildAST("/", $1, $3, OPERATOR);}
  | e '*' e {$$ = buildAST("*", $1, $3, OPERATOR);}
  | '(' e ')' { $$ = $2; }
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
  | NUMAR_FLOAT
  {
    $$ = buildAST($1, NULL, NULL, NR_FLOAT);
  }
  | ID '['NUMAR']'
  {
    string element = $1 + string("[") + $3 + string("]");
    $$ = buildAST(element, NULL, NULL, ARRAY_ELEMENT);
  }
  | ID '('call_list')'
  {
    if(ids.existsFunction($1))
    {
        if(ids.matchFunctionArguments($1, $3, yylineno))
        {
            $$ = buildAST($1, NULL, NULL, FUNCTION);
        }
    }
    else
    {
        yyerror("Error: Function not exists.");
    }
  }
  | ID '('')'
  {
    if(ids.existsFunction($1))
    {
        if(ids.matchFunctionArguments($1, "" , yylineno))
        {
            $$ = buildAST($1, NULL, NULL, FUNCTION);
        }
    }
    else
    {
        yyerror("Error: Function not exists.");
    }
  }
  
  ;

          

incrementare : ID ARITMETIC_INCREMENT
                {
                    ids.incrementVar($1, yylineno);
                }
              | ID '['NUMAR']' ARITMETIC_INCREMENT
                {
                    ids.incrementArrayElement($1, atoi($3), yylineno);
                }
                ;

decrementare : ID ARITMETIC_DECREMENT
               {
                    ids.decrementVar($1, yylineno);
               }
             | ID '['NUMAR']' ARITMETIC_DECREMENT
               {
                    ids.decrementArrayElement($1, atoi($3), yylineno); 
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

parametru : e  
            {
                string exprType = TypeOf($1, ids, yylineno);
                char type[10];
                strcpy(type, Identificator(exprType));
                
                $$ = Function(type, "expresie", " ");
            }
            | CARACTER
            {
                $$ = Function("char", $1, " ");
            }
            | SIR
            {
                $$ = Function("string", $1, " ");
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
     ids.printClasses();
}
