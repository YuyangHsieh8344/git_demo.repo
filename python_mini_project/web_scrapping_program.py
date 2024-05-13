import requests

github_user = input('Input GitHub User: ')
url = f'https://api.github.com/users/{github_user}'

try:
    #The requests.get(url) function sends an HTTP GET request to the GitHub API endpoint.
    response = requests.get(url)
    #The response.raise_for_status() line checks if the response status code is in the 2xx range (successful). 
    #If not, it raises an exception with the error message from the server.
    response.raise_for_status()
    #The response.json() function parses the JSON response from the API and stores it in the user_data variable.  
    user_data = response.json()

    #The code checks if the 'avatar_url' key exists in the user_data dictionary. 
    #If it does, it means the user's profile image URL is available, and it prints the URL.
    if 'avatar_url' in user_data:
        print(f"Profile Image URL: {user_data['avatar_url']}")
    else:
        print('Profile image not found.')

#If any RequestException occurs (e.g., network error, invalid URL), 
#the code catches the exception and prints the error message.
except requests.exceptions.RequestException as e:
    print(f'Error: {e}')
#If any ValueError occurs (e.g., invalid JSON response), 
#the code catches the exception and prints the error message.
except ValueError as e:
    print(f'Error: {e}')
