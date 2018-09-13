x = """keep one new line




reduce double new lines to one




End"""

double_newlines = "\n\n\n"
while double_newlines in x:
    x = x.replace("\n\n\n", "\n\n")
print(x)
