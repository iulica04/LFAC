#include "IdList.h"
#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>

enum nodeType 
{
    OPERATOR = 1,
    IDENTIFICATOR = 2,
    NR_NATURAL =3,
    ARRAY_ELEMENT = 4,
    FUNCTION = 5,
    NR_FLOAT = 6
};


struct AST 
{
    std::string nume;
    struct AST* st;
    struct AST* dr;
    enum nodeType node_type;
};

struct AST* buildAST(std::string nume, struct AST* st, struct AST* dr, enum nodeType type)
{
    struct AST* nod = new AST;
    nod->nume = std::string(nume);
    nod->st = st;
    nod->dr = dr;
    nod->node_type = type;
    return nod;
}

int evalAST(struct AST* tree, IdList& idList, int yylineno)
{
    if(tree->st == NULL && tree->dr == NULL)
    {
        if(tree->node_type == IDENTIFICATOR)
        {
            if(idList.existsVar(tree->nume))
            {
                std::string type = idList.getVarType(tree->nume);
                if(type == "char")
                {
                    cout << "error: It is not possible to assign an int element with a char element at line: " << yylineno << endl;
                }
                else
                if(type == "bool")
                {
                    cout << "error: It is not possible to assign an int element with a bool element at line: " << yylineno << endl;
                }
                else
                if(type == "string")
                {
                    cout << "error: Tt is not possible to assign an int element with a string element at line: " << yylineno << endl;
                }
                else if(type == "int")
                {
                    int value = stoi(idList.getVarValue(tree->nume));
                    return value;
                }
            }
            else if(idList.existsConstant(tree->nume))
            {
                std::string type = idList.getConstType(tree->nume);
                if(type == "char")
                {
                    cout << "error: It is not possible to assign an int element with a char element at line: " << yylineno << endl;
                }
                else
                if(type == "bool")
                {
                    cout << "error: It is not possible to assign an int element with a bool element at line: " << yylineno << endl;
                }
                else
                if(type == "string")
                {
                    cout << "error: Tt is not possible to assign an int element with a string element at line: " << yylineno << endl;
                }
                else if(type == "int")
                {
                    int value = stoi(idList.getConstValue(tree->nume));
                    return value;
                }
            }
            else
            {
                cout << "error : Variabile not exists at line: " << yylineno << endl;
            }
            
        }
        else if(tree->node_type == NR_NATURAL)
        {
            return stoi(tree->nume);
        }
        else if(tree->node_type == ARRAY_ELEMENT)
        {
            string element = tree->nume;
            size_t pos_open_bracket = element.find('[');
            size_t pos_close_bracket = element.find(']');

            std::string nume = element.substr(0, pos_open_bracket);
            std::string index_str = element.substr(pos_open_bracket + 1, pos_close_bracket - pos_open_bracket - 1);
            int index = std::atoi(index_str.c_str());
            

            std::string type = idList.getArrayType(nume);
            if(type == "char")
            {
               cout << "error: Tt is not possible to assign an int element with a char element at line: " << yylineno << endl;
            }
            else
            if(type == "bool")
            {
               cout << "error: Tt is not possible to assign an int element with a bool element at line: " << yylineno << endl;
            }
            else
            if(type == "string")
            {
               cout << "error: Tt is not possible to assign an int element with a string element at line: " << yylineno << endl;
            }
            else if(type == "int")
            {
                string value = idList.getArrayElementValue(nume, index);
                if(value.empty())
                {
                    return 0;
                }
                else
                {
                    return stoi(value);
                }
            }
        } else if(tree->node_type == FUNCTION)
        {
            return 0;
        }
    }
    else
    {
        int val_stanga, val_dreapta;
        val_stanga = evalAST(tree->st, idList, yylineno);
        val_dreapta = evalAST(tree->dr, idList, yylineno);
        if(tree->nume == "+") {return val_stanga + val_dreapta;}
        if(tree->nume == "-") {return val_stanga - val_dreapta;}
        if(tree->nume == "*") {return val_stanga * val_dreapta;}
        if(tree->nume == "/")
        {
            if(val_dreapta) {return val_stanga / val_dreapta;}
            else
            {
                cout << "error : Division by 0 is not possible at line: " << yylineno << endl;
                return 0;
            }
        }
    }
}

float evalASTfloat(struct AST* tree, IdList& idList, int yylineno)
{
    if(tree->st == NULL && tree->dr == NULL)
    {
        if(tree->node_type == IDENTIFICATOR)
        {
            if(idList.existsVar(tree->nume))
            {
                std::string type = idList.getVarType(tree->nume);
                if(type == "char")
                {
                    cout << "error: It is not possible to assign an int element with a char element at line: " << yylineno << endl;
                }
                else
                if(type == "bool")
                {
                    cout << "error: It is not possible to assign an int element with a bool element at line: " << yylineno << endl;
                }
                else
                if(type == "string")
                {
                    cout << "error: Tt is not possible to assign an int element with a string element at line: " << yylineno << endl;
                }
                else if(type == "int")
                {
                    cout << "error: Tt is not possible to assign an int element with a int element at line: " << yylineno << endl;
                }
                else if(type == "float")
                {
                    float value = stof(idList.getVarValue(tree->nume));
                    return value;
                }
            }
            else if(idList.existsConstant(tree->nume))
            {
                std::string type = idList.getConstType(tree->nume);
                if(type == "char")
                {
                    cout << "error: It is not possible to assign an int element with a char element at line: " << yylineno << endl;
                }
                else
                if(type == "bool")
                {
                    cout << "error: It is not possible to assign an int element with a bool element at line: " << yylineno << endl;
                }
                else
                if(type == "string")
                {
                    cout << "error: It is not possible to assign an int element with a string element at line: " << yylineno << endl;
                }
                else if(type == "int")
                {
                    cout << "error: Tt is not possible to assign an int element with a int element at line: " << yylineno << endl;
                }
                else if(type == "float")
                {
                    int value = stof(idList.getConstValue(tree->nume));
                    return value;
                }
            }
            else
            {
                cout << "error : Variabile not exists at line: " << yylineno << endl;
            }
            
        }
        else if(tree->node_type == NR_FLOAT)
        {
            return stof(tree->nume);
        }
        else if(tree->node_type == ARRAY_ELEMENT)
        {
            string element = tree->nume;
            size_t pos_open_bracket = element.find('[');
            size_t pos_close_bracket = element.find(']');

            std::string nume = element.substr(0, pos_open_bracket);
            std::string index_str = element.substr(pos_open_bracket + 1, pos_close_bracket - pos_open_bracket - 1);
            int index = std::atoi(index_str.c_str());
            

            std::string type = idList.getArrayType(nume);
            if(type == "char")
            {
               cout << "error: It is not possible to assign an int element with a char element at line: " << yylineno << endl;
            }
            else
            if(type == "bool")
            {
               cout << "error: It is not possible to assign an int element with a bool element at line: " << yylineno << endl;
            }
            else
            if(type == "string")
            {
               cout << "error: It is not possible to assign an int element with a string element at line: " << yylineno << endl;
            } 
            else
            if(type == "int")
            {
                cout << "error: It is not possible to assign an int element with a int element at line: " << yylineno << endl;
            }
            else if(type == "float")
            {
                string value = idList.getArrayElementValue(nume, index);
                if(value.empty())
                {
                    return 0;
                }
                else
                {
                    return stof(value);
                }
            }
        } else if(tree->node_type == FUNCTION)
        {
            return 0;
        }
    }
    else
    {
        float val_stanga, val_dreapta;
        val_stanga = evalASTfloat(tree->st, idList, yylineno);
        val_dreapta = evalASTfloat(tree->dr, idList, yylineno);
        if(tree->nume == "+") {return val_stanga + val_dreapta;}
        if(tree->nume == "-") {return val_stanga - val_dreapta;}
        if(tree->nume == "*") {return val_stanga * val_dreapta;}
        if(tree->nume == "/")
        {
            if(val_dreapta) {return val_stanga / val_dreapta;}
            else
            {
                cout << "error : Division by 0 is not possible at line: " << yylineno << endl;
                return 0;
            }
        }
    }
}


std::string TypeOf(struct AST* tree, IdList& idList, int yylineno)
{
    if (tree->st == NULL && tree->dr == NULL)
    {
        if (tree->node_type == IDENTIFICATOR)
        {
            if (idList.existsVar(tree->nume))
            {
                std::string type = idList.getVarType(tree->nume);
                return type;
            }
            else if (idList.existsConstant(tree->nume))
            {
                std::string type = idList.getConstType(tree->nume);
                return type;
            }
            else
            {
                cout << "error: Identifier '" << tree->nume << "' not found." << endl;
                return 0;
            }
        }
        else if (tree->node_type == NR_NATURAL)
        {
            return "int";
        }
        else if(tree->node_type == NR_FLOAT)
        {
            return "float";
        }
        else if (tree->node_type == ARRAY_ELEMENT)
        {
            std::string nume = tree->nume.substr(0, tree->nume.find('['));
            if (idList.existsArray(nume))
            {
                string type = idList.getArrayType(nume);
                return type;
            }
            else
            {
                cout << "error: Array '" << nume << "' not found at line: " << yylineno << endl;
                return 0;
            }
        } 
        else if(tree->node_type == FUNCTION)
        {
            if(idList.existsFunction(tree->nume))
            {
                string type = idList.getFunctionType(tree->nume);
                return type;
            }
            else
            {
                cout << "error : Function '" << tree->nume << "' not found at line: " << yylineno << endl;
                return 0;
            }
        }
    }
    else
    {
        std::string typeLeft = TypeOf(tree->st, idList, yylineno);
        std::string typeRight = TypeOf(tree->dr, idList, yylineno);

        // Verificare tipuri pentru operatori aritmetici
        if (typeLeft == typeRight)
        {
            if (tree->nume == "+" || tree->nume == "-" || tree->nume == "*" || tree->nume == "/")
            {
                return typeLeft;
            }
            else
            {
                // Adaugare mesaj de eroare pentru operatori necunoscuti
                std::cerr << "Error: Unknown operator '" << tree->nume << "'." << std::endl;
                return 0;
            }
        }
        else
        {
            // Adaugare mesaj de eroare pentru tipuri incompatibile
            std::cerr << "Error: Incompatible types '" << typeLeft << "' and '" << typeRight << "' for operator '" << tree->nume << "'." << std::endl;
            return 0;
        }
    }

    return "";
}


string getNameASTelement(struct AST *tree)
{
    if(tree->st == NULL && tree->dr == NULL)
    {
        return tree->nume;
    }
    return "";
}
