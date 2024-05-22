import random 
import time 

OPERATOR = ["+", "-", "*"]
MIN_OPERAND = 0
MAX_OPERAND = 10
TOTAL_PROBLEMS = 10

def generate_problem():
    left = random.randint(MIN_OPERAND, MAX_OPERAND)
    right = random.randint(MIN_OPERAND, MAX_OPERAND)
    operator = random.choice(OPERATOR)

    expr = f"{left} {operator} {right}"
    answer = eval(expr)

    return expr, answer

wrong = 0

# Main game loop
while True:  
    start_game = input("Welcome to the math game! Press 'y' to start or 'q' to quit: ").lower()
    if start_game == 'q':
        print("Quitting the game. Goodbye!")
        break
    elif start_game == 'y':
        start_time = time.time()
        for i in range(TOTAL_PROBLEMS):
            expr, answer = generate_problem()
            while True:
                guess = input(f"Problem #{i+1}: {expr} = ")

                if guess.lower() == 'q':
                    print("Quitting the game. Goodbye!")
                    exit()
                elif guess == str(answer):
                    print("Correct!")
                    break
                else:
                    wrong += 1
                    print("Incorrect, try again.")
        
        end_time = time.time()
        total_time = round(end_time - start_time)
        print("Nice work! You finished in", total_time, "seconds")
        print("You got", wrong, "questions wrong")
        break  # End the game after all problems are asked
    else:
        print("Invalid input. Please press 'y' to start or 'q' to quit.")
