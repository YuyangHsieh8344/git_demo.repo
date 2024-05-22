import random

def roll():
    min_value = 1
    max_value = 6
    return random.randint(min_value, max_value)

while True:
    players = input("Enter the number of players (2-4) or 'q' to quit: ").lower()
    
    if players == 'q':
        print("Quitting the game. Goodbye!")
        exit()
    
    if players.isdigit():
        players = int(players)
        if 2 <= players <= 4:
            break
        else:
            print("Must be between 2 - 4 players.")
    else:
        print("Invalid input, try again.")

max_score = 50 
# Initialize the scores for each player to 0
player_scores = [0 for _ in range(players)]

while max(player_scores) < max_score:
    for player_index in range(players):
        print("\nPlayer number", player_index + 1, "turn has just started!")
        print("Your total score is:", player_scores[player_index], "\n")
        current_score = 0

        while True:
            should_roll = input("Would you like to roll (y) or 'q' to quit? ").lower()
            if should_roll == 'q':
                print("Quitting the game. Goodbye!")
                exit()
            if should_roll != 'y':
                break
            value = roll()
            if value == 1:
                print("You rolled a 1! Turn done.")
                current_score = 0
                print("Your current score for this turn is:", current_score)
                break
            else:
                current_score += value 
                print("You rolled a", value, "!")
                print("Your current score for this turn is:", current_score)

        # Add current score to the player's total score at the end of their turn    
        player_scores[player_index] += current_score
        print("Your total score after this turn is:", player_scores[player_index])

    # Print all players' scores after each round
    print("\nScores after all players have taken their turns this round:")
    for i in range(players):
        print("Player", i + 1, ":", player_scores[i])

# Determine the winner
max_score = max(player_scores)
winning_index = player_scores.index(max_score)
print("\nPlayer number", winning_index + 1, "is the winner with a score of", max_score)
