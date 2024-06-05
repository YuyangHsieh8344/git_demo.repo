def make_dict(line):
    """
    Create a frequency dictionary from a line of text.
    
    Args:
        line (str): A line of text.
    
    Returns:
        dict: A dictionary where keys are words and values are their frequencies.
    """
    # Split the line into words
    words = line.split()
    
    # Create an empty dictionary to store word frequencies
    frequency_dict = {}
    
    # Iterate over each word in the list
    for word in words:
        # If the word is already in the dictionary, increment its count
        if word in frequency_dict:
            frequency_dict[word] += 1
        # Otherwise, add the word to the dictionary with a count of 1
        else:
            frequency_dict[word] = 1
    
    return frequency_dict

# Example usage
line = "city; then of the figure of a man walking swiftly; then of a child"
frequency_dict = make_dict(line)
length = len(frequency_dict)
print(frequency_dict)  # Output the frequency dictionary
print(length)  # Output the number of unique words
print(frequency_dict["one piece"]) #return keyerror 
