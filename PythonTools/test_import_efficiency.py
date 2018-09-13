lines = 100000
with open("test1.py", "w") as text_file:
    for i in range(lines+1000000):
        text_file.write("\n")
    text_file.write("""
def hello():
    print("hello test1")
    """)
    
with open("test2.py", "w") as text_file:
    for i in range(lines):
        text_file.write("\n")
    text_file.write("""
def hello():
    print("hello test2")
    """)
    
import time

start = time.time()
import test1
test1.hello()
end = time.time()
print(end - start)

start = time.time()
import test2
test2.hello()
end = time.time()
print(end - start)
