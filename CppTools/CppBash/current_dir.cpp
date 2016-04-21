#include <stdio.h>  /* defines FILENAME_MAX */
#ifdef WINDOWS
#include <direct.h>
#define GetCurrentDir _getcwd
#else
#include <unistd.h>
#define GetCurrentDir getcwd
#endif


char cCurrentPath[FILENAME_MAX];
if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath))){return 0;}
cCurrentPath[sizeof(cCurrentPath) - 1] = '\0'; /* not really required */
printf ("The current working directory is %s", cCurrentPath);
