  template<typename Key,typename Value>
  bool get_map_value(const std::map<Key,Value> & map, const Key & key,Value & value) {
    typename std::map<Key,Value>::const_iterator map_it = map.find(key);
    if(map_it!=map.end()){
      value = map_it->second;
      return true;
    }

    return false;
  }
