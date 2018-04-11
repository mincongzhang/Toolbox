#define BOLDWHITE(msg) "\033[1;37m"<<msg<<"\033[0m"
#define BOLDRED(msg) "\033[1;31m"<<msg<<"\033[0m"
#define BOLDGREEN(msg) "\033[1;32m"<<msg<<"\033[0m"
#define logInfo(msg) do{std::cout<<msg<<std::endl;}while(0)
#define logHighlight(msg) do{logInfo(BOLDGREEN(msg));}while(0)
#define logError(msg) do{std::cerr<<BOLDRED("ERROR:")<<msg<<std::endl;}while(0)
