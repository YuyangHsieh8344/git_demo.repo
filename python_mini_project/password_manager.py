import os

master_pwd = input("What is the master password? ")

def view():
    # Specify the desired file location
    file_path = "C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/passwords.txt"
    
    # Create the directory if it doesn't exist
    directory = os.path.dirname(file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)
    with open(file_path, 'r') as f:
        for line in f.readlines():
            print(line)

def add():
    name = input('Account Name: ')
    pwd = input("Password: ")
    
    # Specify the desired file location
    file_path = "C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/passwords.txt"
    
    # Create the directory if it doesn't exist
    directory = os.path.dirname(file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    with open(file_path, 'a') as f:
        f.write(name + "|" + pwd + "\n")

while True:
    mode = input("Would you like to add a new password or view existing ones? (view or add), press q to quit: ").lower()
    if mode == "q":
        break
    if mode == "view":
        pass
    elif mode == "add":
        add()
    else:
        print("Invalid input. Please try again.")