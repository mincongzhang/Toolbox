/*
But actually the proper use of singleton should be:

class Dictionary {
public:
  static bool getMapA(const std::string & in, int & out){
    return Singleton<MapA>::Instance().getMapA(in,out);
  }

  static bool getMapB(const std::string & in, int & out){
    return Singleton<MapB>::Instance().getMapB(in,out);
  }
};
*/





#include <iostream>
#include <unordered_map>
#include <string>
#include <memory>

struct Test {
    Test(){ std::cout << "Test()" << std::endl;  }
    ~Test(){ std::cout << "~Test()" << std::endl;  }
};

typedef std::unordered_map<int, std::string> DictMap;

class Dictionary {
public:
    static void check(int in){
        Init();

        DictMap::const_iterator it = p_dict->find(in);
        if(it!=p_dict->end()){
        std::cout << it->second << std::endl;
        }
    }
    
private:
    static std::unique_ptr<DictMap> p_dict;
    static std::unique_ptr<Test> p_test;
    Dictionary(){}
    //inherit from "private boost::noncopyable" if in C++03
    Dictionary(const Dictionary&) = delete; // non construction-copyable
    Dictionary& operator=(const Dictionary&) = delete; // non copyable
    
    static void Init(){
        if(!p_test){
            p_test = std::make_unique<Test>();
        }
        
        std::cout << "here" << std::endl; 
        if(p_dict){ return; }
        
        p_dict = std::make_unique<DictMap>();
        p_dict->insert(std::make_pair<int,std::string>(1,"1"));
        p_dict->insert(std::make_pair<int,std::string>(2,"2"));
        p_dict->insert(std::make_pair<int,std::string>(3,"3"));
    }

};

//NOTE: Must init here
std::unique_ptr<DictMap> Dictionary::p_dict = NULL;
std::unique_ptr<Test> Dictionary::p_test = NULL;

int main()
{
    Dictionary::check(1);
   std::cout << "Hello World" << std::endl; 
   
   return 0;
}
