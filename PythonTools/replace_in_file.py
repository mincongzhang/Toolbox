#!/usr/bin/env python3
import fileinput

replace_file = open("replace.csv","r")
replace_map = {}
for line in replace_file:
    str_line = line.strip();
    line_elems = str_line.split(",")
    print(line_elems[0]+":"+line_elems[1].lower())
    replace_map[line_elems[0]] = line_elems[1].lower()

print("replace_map:")
print(replace_map)
replace_file.close();

print("replacing")
for key, value in replace_map.items():
    print("replacing:"+key+"->"+value)

    with fileinput.FileInput("sample.xml", inplace=True, backup='.bak') as file:
        for line in file:
            print(line.replace(key, value), end='')
