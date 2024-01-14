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
    NR_FLOAT = 4,
    NR = 5,
    STRING_OR_CHAR = 6,
    ARRAY_ELEMENT = 7
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

int evalAST(struct AST* tree, IdList& idList)
{
    if(tree->st == NULL && tree->dr == NULL)
    {
        if(tree->node_type == IDENTIFICATOR)
        {
            std::string type = idList.getVarType(tree->nume);
            if(type == "char")
            {
               
            }
            else
            if(type == "bool")
            {
               
            }
            else
            if(type == "string")
            {
               
            }
            else if(type == "int")
            {
                int value = stoi(idList.getVarValue(tree->nume));
                return value;
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
               
            }
            else
            if(type == "bool")
            {
               
            }
            else
            if(type == "string")
            {
               
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

        }
    }
    else
    {
        int val_stanga, val_dreapta;
        val_stanga = evalAST(tree->st, idList);
        val_dreapta = evalAST(tree->dr, idList);
        if(tree->nume == "+") {return val_stanga + val_dreapta;}
        if(tree->nume == "-") {return val_stanga - val_dreapta;}
        if(tree->nume == "*") {return val_stanga * val_dreapta;}
        if(tree->nume == "/")
        {
            if(val_dreapta) {return val_stanga / val_dreapta;}
            else
            {
                //sprintf(errMsg, "Linia %d, impartirea la 0 nu se poate efectua!", yylineno);
                //print_error();
                exit(0);
            }
        }
    }
}