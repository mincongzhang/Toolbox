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
