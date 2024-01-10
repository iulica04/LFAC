%{
#include <iostream>
#include <vector>
#include <string>
#include "IdList.h"
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
}
%token BGIN END ASSIGN 
%token<string> ID INT VOID UNSIGNED STRING CHAR FLOAT BOOL CALCULATE NUMAR NUMAR_FLOAT NUMAR_NATURAL CARACTER SIR TRUE FALSE CONST ARITMETIC_INCREMENT ARITMETIC_DECREMENT
%type<string> list_param 
%type<string> param type variabile 
%start progr
%%
progr: declarations block {printf("The program is correct!\n");}
     ;

declarations :  decl ';'          
	      |  declarations decl ';'   
	      ;

decl  : type ID 
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
      | type ID '(' list_param ')'
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
      | type ID '(' ')' 
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
      | type ID '['NUMAR_NATURAL']'
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
      | CONST INT ID ASSIGN NUMAR_NATURAL
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
      | CONST UNSIGNED ID ASSIGN NUMAR_NATURAL
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



list_param : param
           {
              $$ = $1;
           }
           | param ',' list_param
           {
               $$ = Function($1, $3, ",");
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
     | UNSIGNED
       {
          $$ = $1;
       }
       ;

variabile : NUMAR
       {
          $$ = $1;
       }
     | NUMAR_FLOAT
       {
          $$ = $1;
       }
     | NUMAR_NATURAL
       {
          $$ = $1;
       }
     | SIR
       {
          $$ = $1;
       }
     | CARACTER
       {
          $$ = $1;
       }
     | TRUE
       {
          $$ = $1;
       }
     | FALSE
       {
          $$ = $1;
       }

block : BGIN list END  
     ;
     

list :  statement ';' 
     | list statement ';'
     ;

statement :  ID ASSIGN ID 
            {
                if((ids.existsVar($1)) && ids.existsVar($3))
                {
                    string var1Type = ids.getVarType($1);
                    string var2Type = ids.getVarType($3);
                    string var2Value = ids.getVarValue($3);
                   
                    if(var1Type == var2Type) 
                    {
                        if (var1Type == "int") 
                        {
                            ids.updateVarValue($1, var2Value);
                        } else 
                        {
                            yyerror("Error: Unsupported type for calculation.");
                        }
                    } else 
                    {
                       yyerror("Error: Incompatible types in assignment.");
                    }
                } else if(ids.existsVar($1) && ids.existsConstant($3))
                {
                    string var1Type = ids.getVarType($1);
                    string var2Type = ids.getConstType($3);
                    string var2Value = ids.getConstValue($3);
                   
                    if(var1Type == var2Type) 
                    {
                        ids.updateVarValue($1, var2Value);
                        
                    } else 
                    {
                       yyerror("Error: Incompatible types in assignment.");
                    }
                }else
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID ASSIGN ID '['NUMAR_NATURAL']'
          {
            if((ids.existsVar($1)) && ids.existsArray($3))
                {
                    string var1Type = ids.getVarType($1);
                    string var2Type = ids.getArrayType($3);
                    string var2Value = ids.getArrayElementValue($3, atoi($5));
                   
                    if(var1Type == var2Type) 
                    {
                        ids.updateVarValue($1, var2Value); 
                    } else 
                    {
                       yyerror("Error: Incompatible types in assignment.");
                    }
                }
                else
                {
                    yyerror("Error: Variable not declared.");
                }
          }
          | ID '['NUMAR_NATURAL']' ASSIGN ID 
          {
            if(ids.existsArray($1) && ids.existsVar($6))
            {
                string var1Type = ids.getArrayType($1);
                string var2Type = ids.getVarType($6);
                string var2Value = ids.getVarValue($6);

                if(var1Type == var2Type) 
                {
                    ids.updateArrayValue($1, atoi($3), var2Value); 
                } else 
                {
                   yyerror("Error: Incompatible types in assignment.");
                }
            } else if(ids.existsArray($1) && ids.existsConstant($6))
            {
                string var1Type = ids.getArrayType($1);
                string var2Type = ids.getConstType($6);
                string var2Value = ids.getConstValue($6);

                if(var1Type == var2Type) 
                {
                    ids.updateArrayValue($1, atoi($3), var2Value); 
                } else 
                {
                   yyerror("Error: Incompatible types in assignment.");
                }
            }
            else
            {
                yyerror("Error: Variable not declared.");
            }
          }
          | ID ASSIGN NUMAR 
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1)) 
                {
                    string varType = ids.getVarType($1);
                    if (varType == "int") {
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
          | ID ASSIGN NUMAR_NATURAL
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1)) 
                {
                    string varType = ids.getVarType($1);
                    if (varType == "unsigned")
                    {
                         ids.updateVarValue($1, $3);
                    } else if (varType == "int")
                    {
                         ids.updateVarValue($1, $3);
                    } 
                    else 
                    {
                        yyerror("Error: Incompatible types in assignment.");
                    }
                } else 
                {
                    yyerror("Error: Variable not declared.");
                }
            }
          | ID ASSIGN NUMAR_FLOAT 
            {
                if(ids.existsConstant($1))
                {
                     yyerror("Error: Variabila constanta.");
                }
                else if(ids.existsVar($1)) 
                {
                    string varType = ids.getVarType($1);
                    if (varType == "float") 
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
          | ID ASSIGN CARACTER
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
          | ID '[' NUMAR_NATURAL ']' ASSIGN NUMAR
          {
            if(ids.existsArray($1))
                {
                    string varType = ids.getArrayType($1);
                    if(varType == "int")
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
          | ID '[' NUMAR_NATURAL ']' ASSIGN NUMAR_NATURAL
          {
            if(ids.existsArray($1))
                {
                    string varType = ids.getArrayType($1);
                    if(varType == "unsigned")
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
                    } else if(varType == "int")
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
          | ID '[' NUMAR_NATURAL ']' ASSIGN CARACTER
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
          | ID '[' NUMAR_NATURAL ']' ASSIGN STRING
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
          | ID '[' NUMAR_NATURAL ']' ASSIGN NUMAR_FLOAT
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
          | ID ARITMETIC_INCREMENT
          {
              ids.incrementVar($1);
          }
          | ID '[' NUMAR_NATURAL']' ARITMETIC_INCREMENT
          {
             ids.incrementArrayElement($1, atoi($3));
          }
          | ID '(' CALCULATE call_list ')'
         ;

call_list : NUMAR
           | call_list ',' NUMAR
           ;
%%
void yyerror(const char * s){
    printf("error: %s at line:%d\n",s,yylineno);
}

int main(int argc, char** argv){
     yyin=fopen(argv[1],"r");
     yyparse();
     cout << "Variables:" <<endl;
     ids.printVars();
     ids.printFunctions();
     ids.printConstants();
    
}
