#include <boost/tuple/tuple.hpp>
//#include <tuple>

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

#include <iostream>
#include <string>

//https://gist.github.com/endJunction/4030890
void parse_config_xml(){
  const std::string filename = "config.xml";
  std::cout<<"Parsing ["<<filename<<"]"<<std::endl;

  // Create an empty property tree object
  using boost::property_tree::ptree;
  ptree pt;

  read_xml(filename, pt);

  BOOST_FOREACH(const ptree::value_type &v , pt)
    {
      std::cout << v.first << std::endl;
    }
  std::cout << std::endl;

  BOOST_FOREACH(const ptree::value_type &v , pt.get_child("coupling.P.P.M.<xmlattr>"))
    {
      std::cout << v.first << std::endl;
    }
  std::cout << std::endl;

  /*
  BOOST_FOREACH(const auto& i , pt.get_child("coupling.P.P"))
    {
      std::string name;
      ptree sub_pt;
      std::tie(name, sub_pt) = i;

      if (name != "M")
        continue;
      std::cout << name << std::endl;
      std::cout << "\t" << sub_pt.get<std::string>("<xmlattr>.name") << std::endl;
      std::cout << "\t" << sub_pt.get<std::string>("<xmlattr>.type") << std::endl;
    }
  */
}

//https://stackoverflow.com/questions/27977851/parsing-xml-file-with-boost-c
void parse_test_xml(){
  const std::string filename = "test.xml";
  std::cout<<"Parsing ["<<filename<<"]"<<std::endl;
  using boost::property_tree::ptree;
  ptree pt;
  read_xml(filename,pt);
  BOOST_FOREACH(ptree::value_type &v, pt.get_child("a.modules")){
    std::cout<<v.second.data()<<std::endl;
  }
}

//https://akrzemi1.wordpress.com/2011/07/13/parsing-xml-with-boost/
void parse_fields_xml(){
  const std::string filename = "fields.xml";
  std::cout<<"Parsing ["<<filename<<"]"<<std::endl;
  using boost::property_tree::ptree;
  ptree pt;
  read_xml(filename,pt);
  BOOST_FOREACH(ptree::value_type &v, pt.get_child("fields")){
    if(v.first=="field"){
      std::string name = v.second.get<std::string>("name");
      std::cout<<"name:"<<name<<std::endl;

      BOOST_FOREACH( ptree::value_type const& val, v.second ) {
        if(val.first=="outid"){
          std::cout<<"outid:"<<val.second.data()<<std::endl;
        }
      }//BOOST_FOREACH
    }
  }//BOOST_FOREACH
}

int main(void)
{
  parse_config_xml();
  parse_test_xml();
  parse_fields_xml();

  return EXIT_SUCCESS;
}
