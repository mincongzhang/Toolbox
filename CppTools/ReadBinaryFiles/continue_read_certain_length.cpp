//https://stackoverflow.com/questions/5420317/reading-and-writing-binary-file
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

int main(){
  int length=10;
  char * buffer;

  ifstream is;
  is.open ("vd.dat", ios::binary );
  // allocate memory:
  buffer = new char [length];
  // read data as a block:
  while(is.read(buffer,length)){
    cout<<buffer<<endl;
  }

  is.close();
  delete [] buffer;
}

