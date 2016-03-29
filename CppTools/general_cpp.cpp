#ifdef WIN32
#include <windows>
#endif

void windowspause(){
  #ifdef WIN32
    system("PAUSE");
  #endif
}



#define logInfo(msg) do{ std::cout<<msg<<std::endl;}while(0)
