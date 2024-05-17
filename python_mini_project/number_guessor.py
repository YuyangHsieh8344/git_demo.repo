import random

random_number = random.randint(0, 11)
guess = 0

while True:
    guess += 1
    user_guess = input("Type a number: ")
    #"25" is digit convert to interger 25
    if user_guess.isdigit():
        user_guess = int(user_guess)
    else: 
        print('please type another number.')
        continue
    if user_guess == random_number:
        print("correct number! ")
        break
    elif user_guess > random_number:
        print("you were above the number!")
    else: 
        print("you were below the number! ")

print("you got it in" ,guess, "guesses!" )

