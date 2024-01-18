#include "IdList.h"
#include <sstream>
#include <algorithm>
using namespace std;

void IdList::addVar(const char* type, const char* name) {
    IdInfo var = {string(type), string(name), string("")};
    vars.push_back(var);
}

void IdList::addArray(const char* type, const char* name, int size) {
    IdArray arrayInfo = {string(name), string(type), size, vector<string>(size, "")};
    arrays.push_back(arrayInfo);
}

void IdList::addFunction(const std::string& type, const std::string& name, const std::string& parameters) {
    IdFunction function = {type, name, parameters};
    functions.push_back(function);
}

void IdList::addConstant(const char* type, const char* name, const char* value) {
    IdConstant constant = {string(type), string(name), string(value)};
    constants.push_back(constant);
}

void IdList::addClass(const string& className) {
    IdClass newClass;
    newClass.name = className;
    classes.push_back(newClass);
}

void IdList::addElementtoClass(const char* className, string parameters)
{
    auto it = find_if(classes.begin(), classes.end(), [&className](const IdClass& cls) {
        return cls.name == className;
    });

    if (it != classes.end()) {
        // Desparte șirul de parametrii în funcție de virgulă
        stringstream ss(parameters);
        string param;
        while (std::getline(ss, param, ',')) {
            // Desparte fiecare parametru în type și id
            istringstream iss(param);
            string varType, varName;
            if (iss >> varType >> varName) {
                // Adaugă variabila la clasa curentă
                IdInfo newVar;
                newVar.name = varName;
                newVar.type = varType;
                it->vars.push_back(newVar);
            } else {
                // Eroare la parsare
                cout << "Error: Invalid parameter format: " << param << endl;
            }
        }
    } else {
        // Clasa nu a fost găsită
        cout << "Error: Class not found: " << className << endl;
    }
}


bool IdList::existsVar(string var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return true;
        }
    }

    return false;
}

bool IdList::existsArray(string ary) {
    string strvar = string(ary);
     for (const IdArray& arr : arrays) {
        if (strvar == arr.name) {
            return true;
        }
    }

    return false;
}

bool IdList::existsFunction(string func) {
    string strvar = string(func);
    for (const IdFunction& f : functions) {
        if (strvar == f.name) {
            return true;
        }
    }
    return false;
}

bool IdList::existsConstant(string con) {
    string strvar = string(con);
    for ( IdConstant& c : constants) {
        if (strvar == c.name) { 
            return true;
        }
    }

    return false;
}

bool IdList::existsClass(string cls)
{
    for(IdClass& cl: classes)
    {
        if(cls == cl.name)
        {
            return true;
        }
    }

    return false;
}

void IdList::printVars() {
    cout << "Variables: " << endl;
    for (const IdInfo& v : vars) {
        cout << "Name: " << v.name << endl; 
        cout << "Type: " << v.type << endl;
        cout << "Value: " << v.value << endl; 
        cout<<endl;
    }
    cout<< endl;
}

void IdList::printArrays()
{
    cout << "Arrays: " << endl;
    for (const IdArray& arr : arrays) {
        std::cout << "Name: " << arr.name << endl;
        cout << "Type: " << arr.type << endl;
        cout << "Size: " << arr.size << endl; 
        cout << "Values: [";
        for (int i = 0; i < arr.size; ++i) {
            if (!arr.values[i].empty()) {
                std::cout << arr.values[i];
                if (i != arr.size - 1) {
                    std::cout << ", ";
                }
            }
            else
            {
                std::cout << "NULL";
                if(i != arr.size - 1)
                {
                    cout << ", ";
                }
            }
        }
        std::cout << "]" << std::endl;
        cout << endl;
    }
}

void IdList::printFunctions() {
    cout << "Functions: " << endl;
    for (const IdFunction& func : functions) {
        std::cout << "Function Type: " << func.type << std::endl;
        std::cout << "Function Name: " << func.name << std::endl;
        std::cout << "Parameters: " << func.parameters << std::endl;
        std::cout << std::endl;  // Adaugă o linie goală între funcții pentru claritate
    }
    
}

void IdList::printConstants() {
    cout << "Constant elements: "<< endl;
    for (const IdConstant& constant : constants) {
        cout << "Constant Type: " << constant.type << endl;
        cout << "Constant Name: " << constant.name << endl;
        cout << "Constant Value: " << constant.value << endl;
        cout << endl;  // Adaugă o linie goală între constante pentru claritate
    }
}

void IdList::printClasses()  {
    for (const auto& currentClass : classes) {
        std::cout << "Class: " << currentClass.name << std::endl;

        // Afișează variabilele
        std::cout << "Variables:" << std::endl;
        for (const auto& variable : currentClass.vars) {
            cout << "  Type: " << variable.type << endl;
            cout << "  Name: " << variable.name << endl;
            cout << "  Value: " << variable.value << endl;
        }

        // Afișează array-urile
        std::cout << "Arrays:" << std::endl;
        for (const auto& array : currentClass.arrays) {
            cout << "  Type: " << array.type << endl;
            cout << "  Name: " << array.name << endl;
            cout << "  Size: " << array.size << endl;
            cout << "Values: [";
            for (int i = 0; i < array.size; ++i) {
                if (!array.values[i].empty()) {
                    std::cout << array.values[i];
                    if (i != array.size - 1) {
                        std::cout << ", ";
                    }
                }
                else
                {
                    std::cout << "NULL";
                    if(i != array.size - 1)
                    {
                        cout << ", ";
                    }
                }
            }
            std::cout << "]" << std::endl;
        }

        // Afișează funcțiile
        std::cout << "Functions:" << std::endl;
        for (const auto& function : currentClass.functions) {
            cout << "  Type: " << function.type << endl;
            cout << "  Name: " << function.name << endl;
            cout << "  Parameters:" << function.parameters << endl;
            }
    }

        std::cout << std::endl;
}



string IdList::getVarType(string var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) {
            return v.type;
        }
    }

    return "";
}

string IdList::getArrayType(string var) {
    string strvar = string(var);
    for (const IdArray& arr : arrays) {
        if (strvar == arr.name) {
            return arr.type;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getConstType(string var) {
    string strvar = string(var);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.type;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getFunctionType(string var)
{
    string strvar = string(var);
    for(const IdFunction& func : functions)
    {
        if(strvar == func.name)
        {
            return func.type;
        }
    }
    return "";
}

string IdList::getVarValue(string var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) {
            return v.value;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getConstValue(string con) {
    string strvar = string(con);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.value;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getArrayElementValue(string var, int index)
{
    string strvar = string(var);
    for (IdArray& arr : arrays) {
            if (strvar == arr.name && index >= 0 && index < arr.size) {
                return arr.values[index];
            }
        }
    return ""; // În caz că variabila nu există
}

void IdList::updateVarValue(const char* var, string value) {
    string strvar = string(var);
    for (IdInfo& v : vars) {
        if (strvar == v.name) {
            if(v.type == "char")
            {
                v.value = string(value)[1];
            }
            else  if (v.type == "string")
            {
                v.value = string(value).substr(1, string(value).length() - 2);
            }
            else
            {
                v.value = string(value);
            }
            return;
        }
    }
}

void IdList::updateArrayValue(const char* name, int index, string value) {
        for (IdArray& arr : arrays) {
            if (arr.name == name && index >= 0 && index < arr.size) {
                arr.values[index] = string(value);
                return;
            }
        }
}



int IdList::getArraySize(const char* name) {
    for (const IdArray& arr : arrays) {
        if (arr.name == name) {
            return arr.size;
        }
    }
    return 0; // Dacă nu găsim array-ul, returnăm 0
}

void IdList::incrementVar(const char* name, int yylineno) {
    for (IdInfo& v : vars) {
        if (v.name == name) {
            if (v.type == "int") {
                int currentValue = stoi(v.value);
                currentValue++;
                v.value = to_string(currentValue);
            } else if (v.type == "float") {
                float currentValue = stof(v.value);
                currentValue++;
                v.value = to_string(currentValue);
            } else {
                // Tratează cazul în care variabila nu este de tip întreg
                cout<< "Error: Can only increment variables of type int or float at line: " << yylineno << endl;
            }
            return;
        }
    }


    cout << "Error: Variable not found at line: " << yylineno << endl;
}

void IdList::incrementArrayElement(const char* name, int index, int yylineno) {
    for (IdArray& arr : arrays) {
        if (arr.name == name && index >= 0 && index < arr.size) {
            if (arr.type == "int") {
                int currentValue = stoi(arr.values[index]);
                currentValue++;
                arr.values[index] = to_string(currentValue);
            } else if (arr.type == "float") {
                int currentValue = stof(arr.values[index]);
                currentValue++;
                arr.values[index] = to_string(currentValue);
            }else {
                cout << "Error: Can only increment elements of type int, unsigned or float in arrays at line: " << yylineno << endl;
            }
            return;
        }
    }

    cout << "Error: Array or index not found at line: "<< yylineno << endl;
}

void IdList::decrementVar(const char* name, int yylineno)
{
     for (IdInfo& v : vars) {
        if (v.name == name) {
            if (v.type == "int") {
                int currentValue = stoi(v.value);
                currentValue--;
                v.value = to_string(currentValue);
            } else if (v.type == "float") {
                float currentValue = stof(v.value);
                currentValue--;
                v.value = to_string(currentValue);
            } else {
                // Tratează cazul în care variabila nu este de tip întreg
                std::cout << "Error: Can only increment variables of type int or unsigned int at line: " << yylineno << std::endl;
            }
            return;
        }
    }

    // Dacă variabila nu există, afișează un mesaj de eroare
    std::cerr << "Error: Variable not found at line: " << yylineno << std::endl;
}

void IdList::decrementArrayElement(const char* name, int index, int yylineno)
{
    for (IdArray& arr : arrays) {
        if (arr.name == name && index >= 0 && index < arr.size) {
            if (arr.type == "int") {
                int currentValue = stoi(arr.values[index]);
                currentValue--;
                arr.values[index] = to_string(currentValue);
            } else if (arr.type == "float") {
                int currentValue = stof(arr.values[index]);
                if(currentValue != 0)
                {
                    currentValue--;
                    arr.values[index] = to_string(currentValue);
                }
                else
                {
                    cout << "Error : The value of variable is 0 at line: " << yylineno << endl;
                }
            }else {
                cout << "Error: Can only increment elements of type int, unsigned or float in arrays at line : " << yylineno << endl;
            }
            return;
        }
    }


    cout << "Error: Array or index not found at line: " << yylineno << endl;
}

bool IdList::matchFunctionArguments(const char* name, string argumente, int yylineno)
{
    if(argumente.empty())
    {
        string strvar = string(name);
        for (const IdFunction& f : functions) 
        {
            if (strvar == f.name && f.parameters.empty()) 
            {
                return true;
            }
            else return false;
       }
    }

    std::istringstream stream(argumente);
    std::string token;      
    std::vector<std::string> types_argumente;
    std::vector<std::string> types_function;
            
     while (stream >> token) 
    {
        if (token == "int" || token == "float" || token == "unsigned" || token == "char" || token == "string" || token == "bool") 
        {
            types_argumente.push_back(token);
        }
    }

    string strvar = string(name);
    for (const IdFunction& f : functions) {
        if (strvar == f.name) 
        {
            std::istringstream stream(f.parameters);
            std::string token;
            
            while (stream >> token) 
            {
                if (token.find("type") == 0 || (token == "int" || token == "float" || token == "unsigned" || token == "char" || token == "string" || token == "bool")) 
                {
                    types_function.push_back(token);
                }
            }
        }
    }

    if(types_argumente.size() != types_function.size())
    {
        if(types_argumente.size() < types_function.size())
        {
            cout << "error: Expected more arguments at line: " << yylineno << endl;
            return false;
        }
        else if(types_argumente.size() > types_function.size())
        {
            cout << "error: Too many arguments at line: " << yylineno << endl;
            return false;
        }
        
    }
    else
    {
        if(types_argumente != types_function)
        {
            cout << "error : The type of arguments differs from the type of arguments with which the function was defined at line : " << yylineno << endl;;
            return false;
        }
        else 
        {
            return true;
        }
    }
}

IdList::~IdList() {
    vars.clear();
}
