from PIL import Image
import requests
from io import BytesIO

url = "https://github.com/YuyangHsieh8344"
response = requests.get(url)

# Check if the response content is an image
try:
    image = Image.open(BytesIO(response.content))
    if isinstance(image, Image.Image):
        print("The response content is an image.")
    else:
        print("The response content is not an image.")
except Exception as e:
    print(f"An error occurred: {e}")