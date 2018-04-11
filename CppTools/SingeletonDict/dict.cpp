#include <iostream>
#include <unordered_map>
#include <string>
#include <memory>

struct Test {
    Test(){ std::cout << "Test()" << std::endl;  }
    ~Test(){ std::cout << "~Test()" << std::endl;  }
};

class Dictionary {
public:
    typedef std::unordered_map<int, std::string> DictMap;

    static void check(int in){
        Init();
        return;
        
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


int main()
{
    Dictionary::check(1);
   std::cout << "Hello World" << std::endl; 
   
   return 0;
}
