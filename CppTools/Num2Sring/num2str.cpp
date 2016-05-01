#include <sstream>

template<typename T>
std::string NumberToString ( T Number )
{
  stringstream ss;
  ss << Number;
  return ss.str();
}

template<class T>
inline std::string to_string(const T &val)
{ std::ostringstream ostr; ostr << val; return ostr.str(); }
