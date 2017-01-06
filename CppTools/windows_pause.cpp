#ifdef WIN32
#include <windows>
#endif

void windowspause(){
  #ifdef WIN32
    system("PAUSE");
  #endif
}
