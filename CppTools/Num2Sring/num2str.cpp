#include <sstream>

template<typename T>
std::string toString ( T num ){
    std::stringstream ss;
    ss << num;
    return ss.str();
}

template<class T>
inline std::string to_string(const T &val)
{ std::ostringstream ostr; ostr << val; return ostr.str(); }
