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

void IdList::addFunction(const string type, const string name, const string parameters) {
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

void IdList::addElementtoClass(const char* className, const char* type, const char* name)
{
    IdClass* foundClass = nullptr;
    for (auto& currentClass : classes) {
        if (currentClass.name == className) {
            foundClass = &currentClass;
            break;
        }
    }


    if (foundClass) {
        IdInfo newElement;
        newElement.type = type;
        newElement.name = name;
        foundClass->vars.push_back(newElement);
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
    };
}

void IdList::addFunctiontoClass(const char* className, const char* type, const char* name, const char* parametrii)
{
    IdClass* foundClass = nullptr;
    for (auto& currentClass : classes) {
        if (currentClass.name == className) {
            foundClass = &currentClass;
            break;
        }
    }

    if (foundClass) {
        
        IdFunction newFunction;
        newFunction.type = type;
        newFunction.name = name;
        newFunction.parameters = parametrii;
        foundClass->functions.push_back(newFunction);
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
    };
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

bool IdList::existElementInClass(string className, string varName)
{
    auto it = classes.begin();
    for (; it != classes.end(); ++it) {
        if (it->name == className) {
            break;
        }
    }

    if (it != classes.end()) {
       
        const auto& currentClass = *it;
        for (const auto& element : currentClass.vars) {
            if (element.name == varName) {
                return true;
            }
        }
        return false;
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
        return false;
    }
}

bool IdList::existFunctionInClass(string className, string fctName)
{
    auto it = classes.begin();
    for (; it != classes.end(); ++it) {
        if (it->name == className) {
            break;
        }
    }

    if (it != classes.end()) {
       
        const auto& currentClass = *it;
        for (const auto& fct : currentClass.functions) {
            if (fct.name == fctName) {
                return true;
            }
        }
        return false;
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
        return false;
    }
}

string IdList::getClassElementType(string className, string varName)
{
    auto it = classes.begin();
    for (; it != classes.end(); ++it) {
        if (it->name == className) {
            break;
        }
    }

    if (it != classes.end()) {
       
        const auto& currentClass = *it;
        for (const auto& element : currentClass.vars) {
            if (element.name == varName) {
                return element.type;
            }
        }
    return "";
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
        return "";
    }
}

string IdList::getClassElementValue(string className, string varName)
{
    auto it = classes.begin();
    for (; it != classes.end(); ++it) {
        if (it->name == className) {
            break;
        }
    }

    if (it != classes.end()) {
       
        const auto& currentClass = *it;
        for (const auto& element : currentClass.vars) {
            if (element.name == varName) {
                return element.value;
            }
        }
    return "";
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
        return "";
    }
}

string IdList::getClassFunctionType(string className, string fctName)
{
    auto it = classes.begin();
    for (; it != classes.end(); ++it) {
        if (it->name == className) {
            break;
        }
    }

    if (it != classes.end()) {
       
        const auto& currentClass = *it;
        for (const auto& fct : currentClass.functions) {
            if (fct.name == fctName) {
                return fct.type;
            }
        }
    return "";
    } else {
        
        cout << "Error: Class '" << className << "' not found." << endl;
        return "";
    }
}

void IdList::updateClassElementValue(const char* className, const char* varName, string value)
{
    auto it = std::find_if(classes.begin(), classes.end(), [className](const IdClass& cls) {
        return cls.name == className;
    });

    if (it != classes.end()) {
        IdClass& currentClass = *it;
        auto varIt = std::find_if(currentClass.vars.begin(), currentClass.vars.end(), [varName](const IdInfo& var) {
            return var.name == varName;
        });

        if (varIt != currentClass.vars.end()) {
            IdInfo& variable = *varIt;
            string varType = getClassElementType(className, varName);
            if(varType == "char")
            {
                variable.value = string(value)[1];
            }
            else  if (varType == "string")
            {
                variable.value = string(value).substr(1, string(value).length() - 2);
            }
            else
            {
                variable.value = string(value);
            }
        } 
    }
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
        cout << "Name: " << arr.name << endl;
        cout << "Type: " << arr.type << endl;
        cout << "Size: " << arr.size << endl; 
        cout << "Values: [";
        for (int i = 0; i < arr.size; ++i) {
            if (!arr.values[i].empty()) {
                cout << arr.values[i];
                if (i != arr.size - 1) {
                    cout << ", ";
                }
            }
            else
            {
                cout << "NULL";
                if(i != arr.size - 1)
                {
                    cout << ", ";
                }
            }
        }
        cout << "]" << endl;
        cout << endl;
    }
}

void IdList::printFunctions() {
    cout << "Functions: " << endl;
    for (const IdFunction& func : functions) {
        cout << "Function Type: " << func.type << endl;
        cout << "Function Name: " << func.name << endl;
        cout << "Parameters: " << func.parameters << endl;
        cout << endl;  
    }
    
}

void IdList::printConstants() {
    cout << "Constant elements: "<< endl;
    for (const IdConstant& constant : constants) {
        cout << "Constant Type: " << constant.type << endl;
        cout << "Constant Name: " << constant.name << endl;
        cout << "Constant Value: " << constant.value << endl;
        cout << endl;  
    }
}

void IdList::printClasses()  {
    for (const auto& currentClass : classes) {
        cout << "Class: " << currentClass.name << endl;

        cout << "Variables:" << endl;
        for (const auto& variable : currentClass.vars) {
            cout << "  Type: " << variable.type << endl;
            cout << "  Name: " << variable.name << endl;
            cout << "  Value: " << variable.value << endl;
        }

        cout << "Arrays:" << endl;
        for (const auto& array : currentClass.arrays) {
            cout << "  Type: " << array.type << endl;
            cout << "  Name: " << array.name << endl;
            cout << "  Size: " << array.size << endl;
            cout << "Values: [";
            for (int i = 0; i < array.size; ++i) {
                if (!array.values[i].empty()) {
                    cout << array.values[i];
                    if (i != array.size - 1) {
                        cout << ", ";
                    }
                }
                else
                {
                    cout << "NULL";
                    if(i != array.size - 1)
                    {
                        cout << ", ";
                    }
                }
            }
            std::cout << "]" << std::endl;
        }

        cout << "Functions:" << endl;
        for (const auto& function : currentClass.functions) {
            cout << "  Type: " << function.type << endl;
            cout << "  Name: " << function.name << endl;
            cout << "  Parameters:" << function.parameters << endl;
            }
    }

        cout << endl;
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
    return ""; 
}

string IdList::getConstType(string var) {
    string strvar = string(var);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.type;
        }
    }
    return "";
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
    return "";
}

string IdList::getConstValue(string con) {
    string strvar = string(con);
    for (const IdConstant& cons : constants) {
        if (strvar == cons.name) {
            return cons.value;
        }
    }
    return ""; 
}

string IdList::getArrayElementValue(string var, int index)
{
    string strvar = string(var);
    for (IdArray& arr : arrays) {
            if (strvar == arr.name && index >= 0 && index < arr.size) {
                return arr.values[index];
            }
        }
    return ""; 
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
    return 0; 
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
                cout << "Error: Can only increment variables of type int or unsigned int at line: " << yylineno << std::endl;
            }
            return;
        }
    }

    cout << "Error: Variable not found at line: " << yylineno << endl;
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

    istringstream stream(argumente);
    string token;      
    vector<string> types_argumente;
    vector<string> types_function;
            
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
