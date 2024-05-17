name = input("Type your name: ")
print("Welcome", name, "tp this adventure!")

answer = input("You are on a dirt road, it has come to an end and you can go left or right. WHich way do you want to go? (left or right)").lower()

if answer == "left":
    answer = input("you come to a rive, you can walk around it or swim across? (type walk or swim)")

    if answer == "swim":
        print("you swim across and were eaten by an alligator!")

    elif answer == "walk":
        print("You walked for many miles, ran out of water. You lose!")
    else:
        print("Not a valid option. you lose!")


elif answer == "right":
    answer = input("you come to a bridge, it looks wobbly. Do you want to continue or head back? (type continue or back)")
    
    if answer == "continue":
        answer = input("you crossed a bridge and found a stranger. Do you talk to the stranger? (yes or no)")
        if answer == "yes":
            print("you win! you got a gold coins")

        elif answer == "no":
            print("you ignored the stranger and ocntinue. You lose!")
        else:
            print("Not a valid option. you lose!")

    elif answer == "back":
        answer = input("You found two paths while head back. path 1 or 2? (type 1 or 2)")
        if answer == "1":
            print("you get attack by wolf. you lose!")

        elif answer == "2":
            print("you get rob by bandits. you lose!!")
        else:
            print("Not a valid option. you lose!")


    else:
        print("Not a valid option. you lose!")

else: 
    print("Not a vlaid option. you lose. ")
