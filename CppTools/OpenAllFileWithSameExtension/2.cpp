#include <windows.h>
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
using namespace std;
int main()
{
WIN32_FIND_DATA FindData;
HANDLE hFind;
hFind = FindFirstFile("C:\\*.txt", &FindData);
cout << FindData.cFileName << endl;

while (FindNextFile(hFind, &FindData))
{
	cout << FindData.cFileName << endl;
}

return 0;
} 