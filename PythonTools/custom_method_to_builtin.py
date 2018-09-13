#https://stackoverflow.com/questions/4698493/can-i-add-custom-methods-attributes-to-built-in-python-types

# Built-in namespace
import builtins 

# Extended subclass
class mystr(str):
    def trim_empty_newlines(self):
        double_empty_newlines = "\n\n\n"
        single_empty_newline = "\n\n"
        while double_empty_newlines in self:
            self = self.replace(double_empty_newlines, single_empty_newline)
        return self

# Substitute the original str with the subclass on the built-in namespace    
builtins.str = mystr
        
x = """keep one new line




reduce double new lines to one


End"""

print(str(x).trim_empty_newlines())
