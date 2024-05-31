# Creating a dictionary
my_dict = {'name': 'Alice', 'age': 25, 'city': 'New York'}

# Inserting a new key-value pair
my_dict['job'] = 'Engineer'

# Deleting a key-value pair
del my_dict['age']

# Lookup a value
name = my_dict['name']

# Iterating over keys and values
for key, value in my_dict.items():
    print(key, value)
