#ifndef IDLIST_H
#define IDLIST_H

#include <iostream>
#include <vector>
#include <string>
#include <cstring>
#include <sstream>


using namespace std;


struct IdInfo {
    string type;
    string name;
    string value; 
};

struct IdConstant {
    std::string type;
    std::string name;
    std::string value;
};

struct IdArray {
    string name; 
    string type; 
    int size;         
    vector<std::string> values; 
};


struct IdFunction {
    std::string type;
    std::string name;
    std::string parameters;
};

struct ClassMember {
    std::string type;
    std::string id;
};

struct ClassVariable {
    std::string name;
    std::vector<ClassMember> members;
};

struct IdClass {
    string name;
    vector<IdInfo> vars;
    vector<IdArray> arrays;
    vector<IdConstant> constants;
    vector<IdFunction> functions;
    vector<ClassVariable> classVariables;
};

class IdList {
public:
    vector<IdInfo> vars;
    vector<IdArray> arrays;
    vector<IdFunction> functions;
    vector<IdConstant> constants;
    vector<IdClass> classes;


    bool existsVar(string s);
    bool existsFunction(string s);
    bool existsArray(string s);
    bool existsConstant(string s);
    bool existsClass(string s);
    void addVar(const char* type, const char* name);
    void addArray(const char* type, const char* name, int size);
    void addFunction(const std::string& type, const std::string& name, const std::string& parameters);
    void addConstant(const char* type, const char* name, const char* value);
    void addClass(const string& name);
    void printVars();
    void printFunctions(); 
    void printConstants();
    void printArrays();
    void printClasses();
    string getVarType(string var);
    string getConstType(string var);
    string getArrayType(string var);
    string getFunctionType(string var);
    string getVarValue(string var);
    string getConstValue(string con);
    string getArrayElementValue(string var, int index);
    void updateVarValue(const char* var, string value);
    void updateArrayValue(const char* name, int index, string value);
    int getArraySize(const char* name);
    void incrementVar(const char* name, int yylineno);
    void incrementArrayElement(const char* name, int index, int yylineno);
    void decrementVar(const char* name, int yylineno);
    void decrementArrayElement(const char* name, int index, int yylineno); 

    bool matchFunctionArguments(const char* name, string argumente, int yylineno);

    void addElementtoClass(const char* name, string argumente);

    ~IdList();
};

#endif 

