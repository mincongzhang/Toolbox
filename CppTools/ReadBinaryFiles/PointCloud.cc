#include "PointCloud.h"

#ifdef _DEBUG
#include <iostream>
#endif

#include <cstring>
#include <fstream>

int PointCloud::load_hashTable(char* ht_filespec)()
{
	ifstream input_file(ht_filespec,ios::binary);
	char* header;
	double dists,angles;
	int number_of_features;
	
	if (input_file)
	{
		input_file.read(header, 4);
		input_file.read((char*)&dists, sizeof(double));
		input_file.read((char*)&angles, sizeof(double));
		input_file.read((char*)&number_of_features, sizeof(double));
		for(int f_it=0;f_it<number_of_features;f_it++)
		{
			int number_of_pairs;
			feature_vec features;
			input_file.read((char*)&number_of_pairs, sizeof(int));
			input_file.read((char*)&features.coord[0], sizeof(double));
			input_file.read((char*)&features.coord[1], sizeof(double));
			input_file.read((char*)&features.coord[2], sizeof(double));
			input_file.read((char*)&features.coord[3], sizeof(double));
			
			//add features to hashtable
			hashtable.emplace(features, vector<point_pair>);
			
			for(int p_it=0;p_it<number_of_pairs;p_it++)
			{
				point_pair pairdata;
				input_file.read((char*)&pairdata.pt[0].coord[0], sizeof(double));
				input_file.read((char*)&pairdata.pt[0].coord[1], sizeof(double));
				input_file.read((char*)&pairdata.pt[0].coord[2], sizeof(double));
				input_file.read((char*)&pairdata.normal[0].coord[0], sizeof(double));
				input_file.read((char*)&pairdata.normal[0].coord[1], sizeof(double));
				input_file.read((char*)&pairdata.normal[0].coord[2], sizeof(double));
				input_file.read((char*)&pairdata.pt[1].coord[0], sizeof(double));
				input_file.read((char*)&pairdata.pt[1].coord[1] sizeof(double));
				input_file.read((char*)&pairdata.pt[1].coord[2], sizeof(double));
				input_file.read((char*)&pairdata.normal[1].coord[0], sizeof(double));
				input_file.read((char*)&pairdata.normal[1].coord[1], sizeof(double));
				input_file.read((char*)&pairdata.normal[1].coord[2], sizeof(double));
				
				//add pair points to hashtable
				hashtable[features].insert(pairdata);
			}
		}
		
		return 1;
	}
#ifdef _DEBUG
	else
	{
		cout << "E: Unable to read file " << string(ht_filespec) << "." << endl;
		return 0;
	}
#endif
	
}