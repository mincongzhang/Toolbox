/*
Hex file is like:

00002c86
00000576
01000323
02000000
...
*/

#include <fstream>
#include <iostream>
#include <string>
#include <sstream>

#include <cstdint> //int32_t


#define log(msg) do{ std::cout<<msg<<std::endl;}while(0)

const int HEADER_LENGTH = 9;// 8 char + '\n'
int32_t loadHeader(std::ifstream & input_file){
	std::stringstream ss;

	char* header = new char[HEADER_LENGTH];
	input_file.read(header, HEADER_LENGTH);
	//log(header);

	ss << std::hex << header;
	delete [] header;

	int32_t num;
	ss>>num;

	return num;
}

int main(){
	log("start");
	std::string filename = "task1.bin";
	std::ifstream input_file(filename.c_str(),std::ios::binary);

	if(!input_file){
		log("fail to load ["<<filename<<"]");
	}

	int32_t data_size = loadHeader(input_file);
	log("DATA SIZE ["<<data_size<<"]");
	int32_t image_size = loadHeader(input_file);
	log("IMAGE SIZE ["<<image_size<<"]");


	system("pause");
	return 0;
}
