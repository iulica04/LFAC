#include <iostream>
#include <vector>
#include <string>
#include <cstring>


using namespace std;


struct IdInfo {
    string type;
    string name;
    string value; // Adăugăm valoarea variabilei
};

struct IdConstant {
    std::string type;
    std::string name;
    std::string value;
};

struct IdArray {
    string name; // Numele array-ului
    string type; // Tipul array-ului
    int size;         // Dimensiunea array-ului
    vector<std::string> values; // Valorile array-ului
};


struct IdFunction {
    std::string type;
    std::string name;
    std::string parameters;
};



class IdList {
    vector<IdInfo> vars;
    vector<IdArray> arrays;
    std::vector<IdFunction> functions;
    std::vector<IdConstant> constants;

public:
    bool existsVar(const char* s);
    bool existsFunction(const char* s);
    bool existsArray(const char* s);
    bool existsConstant(const char* s);
    void addVar(const char* type, const char* name);
    void addArray(const char* type, const char* name, int size);
    void addFunction(const std::string& type, const std::string& name, const std::string& parameters);
    void addConstant(const char* type, const char* name, const char* value);
    void printVars();
    void printFunctions(); 
    void printConstants();
    void printArrays();
    string getVarType(const char* var);
    string getConstType(const char* var);
    string getArrayType(const char* var);
    string getVarValue(const char* var);
    string getConstValue(const char* con);
    string getArrayElementValue(const char* var, int index);
    void updateVarValue(const char* var, string value);
    void updateArrayValue(const char* name, int index, string value);
    int getArraySize(const char* name);
    void incrementVar(const char* name);
    void incrementArrayElement(const char* name, int index);
    void decrementVar(const char* name);
    void decrementArrayElement(const char* name, int index);

    ~IdList();
};
