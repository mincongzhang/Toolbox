#include <sstream>

template std::string NumberToString ( T Number )
{
  stringstream ss;
  ss << Number;
  return ss.str();
}
