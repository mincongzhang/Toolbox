import binascii

my_byte_array = None
with open("a.bin", "rb") as binaryfile :
    my_byte_array = bytearray(binaryfile.read())
    
print(binascii.hexlify(bytearray(my_byte_array)))

#########################

hex_str = "25504"
result = bytearray.fromhex(hex_str)
with open("b.bin", "wb") as newFile:
    newFile.write(result)
