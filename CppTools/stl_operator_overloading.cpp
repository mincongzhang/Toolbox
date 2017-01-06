#include <iostream>
#include <vector>
#include <set>

#include <utility>//make pair
#include <map>


#define log(msg) do{ std::cout<<msg<<"\n"; }while(0)

template <typename T>
inline std::ostream& operator<< (std::ostream &os, const std::vector<T> & value ) {
  for(typename std::vector<T>::const_iterator it=value.begin(); it!=value.end(); ++it){
    os<<"["<<*it<<"]";
  }
  return os;
}

template <typename T>
inline std::ostream& operator<< (std::ostream &os, const std::set<T> & value ) {
  for(typename std::set<T>::const_iterator it=value.begin(); it!=value.end(); ++it){
    os<<"["<<*it<<"]";
  }
  return os;
}

template <typename Key,typename Value>
inline std::ostream& operator<< (std::ostream &os, const std::map<Key,Value> & value ) {
  os<<"[";
  for(typename std::map<Key,Value>::const_iterator it=value.begin(); it!=value.end(); ++it){
    os<<"("<<it->first<<"|"<<it->second<<")";
  }
  os<<"]";
  return os;
}


int main(){
  std::cout<<"hello"<<std::endl;

  log("hello log");

  std::vector<int> vec(10,1);
  log("hello vec int:"<<vec);

  std::vector<double> vec_d(10,1.1);
  log("hello vec double:"<<vec_d);

  std::set<int> s;
  s.insert(1);
  s.insert(-1);
  s.insert(6);
  log("hello set:"<<s);

  std::map<int,char> m;
  m.insert(std::make_pair(3, 'c'));
  m.insert(std::make_pair(2, 'b'));
  m.insert(std::make_pair(1, 'a'));
  log("h
