#passward generator

import random

print('WLECOME TO PASSWARD GENERATOR!')


chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!:;-_/|&*$#%+-=<>()<>0123456789©®™°€$¢¥£●✓✗'

number = input('Amount of passwards user intend to generate: ')

number = int(number)
length = input('the length of the passward: ')
length = int(length)

print('\nhere are the list of the passwards that generate: ')

for pwd in range (number):
    passwards = ''
    for c in range(length):
        passwards += random.choice(chars)
    print(passwards)