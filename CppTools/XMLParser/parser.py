from xml.dom import minidom
from xml.dom.minidom import parse

xmldoc = minidom.parse('sample.xml')

# find the name element, if found return a list, get the first element
name_element = xmldoc.getElementsByTagName("name")[0]

# this will be a text node that contains the actual text
text_node = name_element.childNodes[0]

# get text
print text_node.data

# Go through the whole xml
print "for loop:"
for name_element in xmldoc.getElementsByTagName("name"):
    text_node = name_element.childNodes[0]
    print text_node.data
