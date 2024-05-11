import cv2
from PIL import Image
import numpy as np

# Open the image
img = Image.open('C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/qrcode3.jpg')

# Convert the PIL Image to a NumPy array
img_np = np.array(img)

# Convert the NumPy array to an OpenCV image
img_cv = cv2.cvtColor(img_np, cv2.COLOR_RGB2BGR)

# Create a QR code detector
qr_detector = cv2.QRCodeDetector()

# Detect and decode the QR code
data, bbox, straight_qrcode = qr_detector.detectAndDecode(img_cv)

# Print the decoded data
if data:
    print(f"Decoded QR Code: {data}")
else:
    print("No QR code found in the image.")