# Specify the absolute path to the story.txt file
file_path = r"C:\Users\yuyan\OneDrive\Desktop\Git Demo\python_mini_project\story.txt"

try:
    # Open and read the file
    with open(file_path, 'r') as f:
        story = f.read()
except FileNotFoundError:
    print(f"Error: 'story.txt' not found at {file_path}.")
    exit()
except Exception as e:
    print(f"Error: {e}")
    exit()

# Initialize a set to capture unique placeholder words
words = set()

# Initialize variables to find placeholder words
start_of_word = -1
target_start = "("
target_end = ")"

# Iterate through the story to find all placeholders
for i, char in enumerate(story):
    if char == target_start:
        start_of_word = i
    if char == target_end and start_of_word != -1:
        word = story[start_of_word: i + 1]
        words.add(word)
        start_of_word = -1

# Initialize a dictionary to store user inputs for each placeholder
answers = {}

# Prompt the user for a replacement word for each placeholder
for word in words:
    user_input = input(f"Enter a word for {word}: ")
    answers[word] = user_input

# Replace all placeholders with user inputs
for word in words:
    story = story.replace(word, answers[word])

# Print the final story
print("\nHere is your story:")
print(story)
