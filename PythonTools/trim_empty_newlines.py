x = """keep one new line




reduce double new lines to one




End"""

double_empty_newlines = "\n\n\n"
single_empty_newline = "\n\n"
while double_empty_newlines in x:
    x = x.replace(double_empty_newlines, single_empty_newline)
print(x)
