# from file to bytes string
import binascii

my_byte_array = None
with open("source.pdf", "rb") as binaryfile :
    my_byte_array = bytearray(binaryfile.read())
    
hex_bytes = binascii.hexlify(bytearray(my_byte_array))
hex_str = hex_bytes.decode() 
with open("result.txt", "w+") as newFile:
    newFile.write(hex_str)
    
#########################
# from bytes string to file

import binascii

with open("result.txt","r") as f:
    line = f.readline()
    # might need to get rid of "\n"
    # byte_str_line = line[:-1]
    byte_str_line = line

result = bytearray.fromhex(byte_str_line)
with open("result.pdf", "wb") as newFile:
    newFile.write(result)
