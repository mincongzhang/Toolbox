///////////////////////////////////////////////////////////////////
// string delim
///////////////////////////////////////////////////////////////////
void split(const std::string & s, const std::string & delim, std::vector<std::string> & out){
  std::size_t start = 0, end = s.find_first_of(delim, start);

  while(end != std::string::npos){
    out.push_back(s.substr(start, end - start));
    start = end+1;
    end = s.find_first_of(delim, start);
}

  if(start != std::string::npos){
    out.push_back(s.substr(start));
  }
}


int main() {
  std::string line("12\t14\tL");
  std::vector<std::string> out;
  split(line,"\t",out);

  std::cout<<out<<std::endl;

  return 0;
}


///////////////////////////////////////////////////////////////////
// char delim only with getline
///////////////////////////////////////////////////////////////////

void split(const std::string & s, char delim, std::vector<std::string> & out){
  std::stringstream ss(s); // Insert the string into a stream
  std::string item;
  while (std::getline(ss, item, delim)) {
    out.push_back(item);
  }
}

int main() {
  std::string line("12 14 L");
  std::vector<std::string> out;
  split(line,' ',out);

  std::cout<<out<<std::endl;

  return 0;
}

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
