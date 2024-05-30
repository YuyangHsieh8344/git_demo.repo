# Open the file
with open('C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/story.txt', 'r') as reader:
    count = 0

    # Iterate through each line in the file
    for line in reader:
        word_list = line.split()  # Split the line into words
        count += len(word_list)   # Add the number of words to the total count
        print(word_list)          # Print the list of words in the line
        print(len(word_list))     # Print the number of words in the line

# Print the total word count
print(f"Total number of words: {count}")
