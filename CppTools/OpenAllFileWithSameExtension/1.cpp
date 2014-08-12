#include <windows.h>
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
 
using namespace std;
 
int main()
{
    string path = "c:\\test\\";
    string searchPattern = "*.txt";
    string fullSearchPath = path + searchPattern;
 
    WIN32_FIND_DATA FindData;
    HANDLE hFind;
 
    hFind = FindFirstFile( fullSearchPath.c_str(), &FindData );
 
    if( hFind == INVALID_HANDLE_VALUE )
    {
        cout << "Error searching directory\n";
        return -1;
    }
 
    do
    {
        string filePath = path + FindData.cFileName;
        ifstream in( filePath.c_str() );
        if( in )
        {
            // do stuff with the file here
        }
        else
        {
            cout << "Problem opening file " << FindData.cFileName << "\n";
        }
    }
    while( FindNextFile(hFind, &FindData) > 0 );
 
    if( GetLastError() != ERROR_NO_MORE_FILES )
    {
        cout << "Something went wrong during searching\n";
    }
 
    system("pause");
    return 0;
}
 
// Note that you can use GetLastError() to get better error information for the
// WinAPI calls but I did not want to complicate the example