///////////////////////////////////////////////////////////////////
// string delim
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
// char delim only with getline
///////////////////////////////////////////////////////////////////

string s = "Name:JAck; Spouse:Susan; ...";
string dummy, name, spouse;

istringstream iss(s);
getline(iss, dummy, ':');
getline(iss, name, ';');
getline(iss, dummy, ':');
getline(iss, spouse, ';')

///////////////////////////////////////////////////////////////////
// spaces ' ' only
///////////////////////////////////////////////////////////////////
#include <vector>
#include <string>
#include <sstream>

void split(const std::string & s, std::vector<std::string> & out){
  std::stringstream ss(s); // Insert the string into a stream
  std::string buf; // Have a buffer string

  while (ss >> buf){
    out.push_back(buf);
  }
}

int main() {
  std::string line("12 14 L");
  std::vector<std::string> out;
  split(line,out);

  std::cout<<out<<std::endl;

  return 0;
}

///////////////////////////////////////////////////////////////////
// boost
///////////////////////////////////////////////////////////////////
#include <boost/algorithm/string.hpp>
std::vector<std::string> strs;
boost::split(strs, "string to split", boost::is_any_of("\t "));
