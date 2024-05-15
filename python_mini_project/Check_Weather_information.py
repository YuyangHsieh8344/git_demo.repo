import requests
from pprint import pprint

API_KEY = '74ddd74228804fbfb6425036241505'  # Replace 'your_weatherapi_key' with your actual WeatherAPI key
city = input("Enter a city: ")
base_url = "http://api.weatherapi.com/v1/current.json?"

# Construct the complete URL with parameters
complete_url = f"{base_url}key={API_KEY}&q={city}"

# Send the request and get the response
response = requests.get(complete_url)

# Check if the request was successful
if response.status_code == 200:
    weather_data = response.json()
    pprint(weather_data)
else:
    print(f"Error: {response.status_code} - {response.reason}")

#Create an account and get API key!!
#https://www.weatherapi.com/my/