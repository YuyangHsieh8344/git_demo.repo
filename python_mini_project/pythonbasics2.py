# -*- coding: utf-8 -*-
"""PythonBasics2.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/14eU4YVfTNLgiDRZnAJTysgs3FpS_-m-6
"""

print("shift enter to run")

type("Hello WOrld 1")

type(23)

type(1.6e308)

type(-37)

50//3

50%3

5 ** 3

print

y = 5

y

y * 4

x = -1
if (x > 2):
  print(True)
else:
  print(False)

Grocery_List = ["strawberries", "eggs", "honey"]

Grocery_List

Grocery_List.append("toast")

Grocery_List

type(Grocery_List)

for item in Grocery_List:
  print(item)

for i in range(len(Grocery_List)):
  print(Grocery_List[i])

list(range(len(Grocery_List)))

for i , item in enumerate(Grocery_List):
  print(i, item)

j = len(Grocery_List) - 1

while j >= 0:
  print(Grocery_List[j])
  j -= 1
print('end')

len(Grocery_List)

age = 13

if age <= 1:
  print("newborn")
elif age <= 10:
  print('kids')
elif age <= 20:
  print("teenagers")
else:
  print("adults")

print('end')

z = 17
def our_print(s):
  print(s)
  print(s + " is the best")
  print(z)

our_print("leo")

def times_2(x):
  return x*2

r = 10
times_2(r)

def append_4_to_lst(lst):
  lst.append(4)
  print(lst is a)
  lst = [1,2]
  print(lst is a)

a = [1,2,3]
append_4_to_lst(a)

a

a

b = a

b == a

a is [1,2,3,4]

from copy import deepcopy
b = deepcopy(a)
a

a[0] = 17
a

b

!ls

#How to open file in python
p = 'a_test.txt'

with open(p, 'r') as f:
  #print(f.readlines())
  #print()
  print(f.read())

p = 'a_test.txt'

with open(p, 'r') as f:
  for line in f:
    print(line.rstrip())
    #this is good when dealing with a massive file
    #so we can read one line at a time without crashing

#how to create a new file in python
with open('new_file.txt', 'w') as f:
  f.write("Obiwan Kenobi")

class human:
  '''
  Ｔhis is a class that represents a simplified human

  It takes their age as an int, and their name as a str
  '''

  def __init__(self, age, name):
    self._age = age
    self._name = name

  def __str__(self):
    return "A human with a name " + self._name + ", and her age is " + str(self._age) + "."

  def older_younger_than(self, age):
    if self._age > age:
      print("Our age is bigger than their age.")
    elif self._age < age:
      print("Our age is smaller than their age.")
    else:
      print("Our age is equal to their age.")

h = human(age = 30, name = "Kafka")
print(h)

h.older_younger_than(30)

help(human)

l = [1,2,3]

l.append(4)
l

l.insert(0, 'leo')
l

l.reverse()
l

l = []

for i in range(5):
  for j in range(3):
    if (i+j) % 2 == 0:     #if i + j is even number
      l.append(i+j)

l

"""d = {'Apple": "It's a fruit that is high in Vitamin C."}"""

d = {'Apple' : "It's a fruit that is high in Vitamin C.",
     'Banana' : "It's a fruit that is high is Potassium"}
d

d['Apple']
d['Banana']

for k in d.keys():
  v = d[k]
  print(k,v)

d2 = {0: "Jordan", 1: "Tina", 2: "Jane"}
d2

d2[2]

name = "Leo"
fav_num = 17

f"Hi I am {name}, and my fav number is {fav_num}."

f"Hi I am {name}, and my fav person is {h}."

"leo".isnumeric()

"hello there".upper()
#you are not allowed to change str
#s = "Hekko"
#s[2] = "l"

t = (1,2,3)

try:
  t[0]= 1
  #Type error
except:
  print("Caught it")

s = [x**2 for x in range(5)]

s

[1,2] + [4, 5, 6]

for a,b in zip(range(4), range (4,8)):
  print(a,b)

{(k, chr(k+64)) for k in range(1, 27)}
  #print(k, v)

import numpy as np

!pip list

!ls

!python test.py





