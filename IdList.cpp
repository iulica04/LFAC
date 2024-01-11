#include "IdList.h"
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

bool IdList::existsVar(const char* var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return true;
        }
    }

    return false;
}

bool IdList::existsArray(const char* ary) {
    string strvar = string(ary);
     for (const IdArray& arr : arrays) {
        if (strvar == arr.name) {
            return true;
        }
    }

    return false;
}

bool IdList::existsFunction(const char* func) {
    string strvar = string(func);
    for (const IdFunction& f : functions) {
        if (strvar == f.name) {
            return true;
        }
    }
    return false;
}

bool IdList::existsConstant(const char* con) {
    string strvar = string(con);
    for ( IdConstant& c : constants) {
        if (strvar == c.name) { 
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


string IdList::getVarType(const char* var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) {
            return v.type;
        }
    }

    return "";
}

string IdList::getArrayType(const char* var) {
    string strvar = string(var);
    for (const IdArray& arr : arrays) {
        if (strvar == arr.name) {
            return arr.type;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getConstType(const char* var) {
    string strvar = string(var);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.type;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getVarValue(const char* var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name) {
            return v.value;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getConstValue(const char* con) {
    string strvar = string(con);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.value;
        }
    }
    return ""; // În caz că variabila nu există
}

string IdList::getArrayElementValue(const char* var, int index)
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

void IdList::incrementVar(const char* name) {
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
            }  else if (v.type == "unsigned") {
                unsigned int currentValue = stoul(v.value);
                currentValue++;
                v.value = to_string(currentValue);
            } else {
                // Tratează cazul în care variabila nu este de tip întreg
                std::cerr << "Error: Can only increment variables of type int or unsigned int." << std::endl;
            }
            return;
        }
    }

    // Dacă variabila nu există, afișează un mesaj de eroare
    std::cerr << "Error: Variable not found." << std::endl;
}

void IdList::incrementArrayElement(const char* name, int index) {
    for (IdArray& arr : arrays) {
        if (arr.name == name && index >= 0 && index < arr.size) {
            if (arr.type == "int") {
                int currentValue = stoi(arr.values[index]);
                currentValue++;
                arr.values[index] = to_string(currentValue);
            } else if (arr.type == "unsigned") {
                unsigned int currentValue = stoul(arr.values[index]);
                currentValue++;
                arr.values[index] = to_string(currentValue);
            } else if (arr.type == "float") {
                int currentValue = stof(arr.values[index]);
                currentValue++;
                arr.values[index] = to_string(currentValue);
            }else {
                // Tratează cazul în care elementul nu este de tip întreg
                std::cerr << "Error: Can only increment elements of type int, unsigned or float in arrays." << std::endl;
            }
            return;
        }
    }

    // Dacă array-ul nu există sau indexul este invalid, afișează un mesaj de eroare
    std::cerr << "Error: Array or index not found." << std::endl;
}

void IdList::decrementVar(const char* name)
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
            }  else if (v.type == "unsigned") {
                unsigned int currentValue = stoul(v.value);
                if(currentValue != 0)
                {
                    currentValue--;
                    v.value = to_string(currentValue);
                } else 
                {
                    cout << "Error : The value of variable is 0." << endl;
                }
            } else {
                // Tratează cazul în care variabila nu este de tip întreg
                std::cout << "Error: Can only increment variables of type int or unsigned int." << std::endl;
            }
            return;
        }
    }

    // Dacă variabila nu există, afișează un mesaj de eroare
    std::cerr << "Error: Variable not found." << std::endl;
}

void IdList::decrementArrayElement(const char* name, int index)
{
    for (IdArray& arr : arrays) {
        if (arr.name == name && index >= 0 && index < arr.size) {
            if (arr.type == "int") {
                int currentValue = stoi(arr.values[index]);
                currentValue--;
                arr.values[index] = to_string(currentValue);
            } else if (arr.type == "unsigned") {
                unsigned int currentValue = stoul(arr.values[index]);
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
                    std::cout << "Error : The value of variable is 0." << endl;
                }
            }else {
                // Tratează cazul în care elementul nu este de tip întreg
                std::cerr << "Error: Can only increment elements of type int, unsigned or float in arrays." << std::endl;
            }
            return;
        }
    }

    // Dacă array-ul nu există sau indexul este invalid, afișează un mesaj de eroare
    std::cerr << "Error: Array or index not found." << std::endl;
}

IdList::~IdList() {
    vars.clear();
}
