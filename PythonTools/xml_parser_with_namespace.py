# https://stackoverflow.com/questions/18338807/cannot-write-xml-file-with-default-namespace/18340978

import xml.etree.ElementTree as ET
#register namespace before parsing the file, so that to write to file with the namespace
msbuild_ns_name = "http://schemas.microsoft.com/developer/msbuild/2003"
ET.register_namespace('',msbuild_ns_name)

msbuild_ns = "msbuild"
ns_dict = {msbuild_ns : msbuild_ns_name}

xmltree = ET.parse(props_file)
xmlroot = xmltree.getroot()

property_group_tagname = msbuild_ns +":"+"PropertyGroup"
version_tagname = msbuild_ns +":"+"Version"
minor_version_tagname = msbuild_ns +":"+"MinorVersion"
for property_group in xmlroot.findall(property_group_tagname, ns_dict):
    version_tag = property_group.find(version_tagname, ns_dict)
    if version_tag is not None:
        print(version_tag.text)
        version_tag.text = "hahaha"

xmltree.write(props_file,
              xml_declaration = True,
              encoding = 'utf-8',
              method = 'xml')
