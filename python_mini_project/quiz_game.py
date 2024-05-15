print('Welcome to my computer quiz!')

playing = input("Do you want to play? ").lower()

# Check if the player wants to play or not
if playing != "yes":
    print("Goodbye for now!")
    quit()

print("Okay! Starting now!")
score = 0

answer = input("1. What does CPU stansd for? ").lower()
if answer == "central processing unit": 
    print('Correct!')
    score += 25
else: 
    print("Incorrect! answer is central processing unit") 

answer = input("2. What does GPU stansd for? ").lower()
if answer == "graphics processing unit": 
    print('Correct!')
    score += 25
else: 
    print("Incorrect! answer is graphics processing unit") 

answer = input("3. What does RAM stansd for? ").lower()
if answer == "random access memory": 
    print('Correct!')
    score += 25
else: 
    print("Incorrect! answer is random access memory") 

answer = input("4. What does PSU stansd for? ").lower()
if answer == "power supply unit": 
    print('Correct!')
    score += 25
else: 
    print("Incorrect! answer is power supply unit") 

print("You got " + str(score) + " in this quiz!")
