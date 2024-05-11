import qrcode
from PIL import Image

# Create a QR code instance
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
)

# Add the data to the QR code
qr.add_data('Kurasa is the best name!!')
qr.make(fit=True)

# Generate the QR code image
img = qr.make_image(fill_color="red", back_color="white")

# Save the QR code image
#change the link to front slash => /
img.save('C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/myqrcode1.png')

#img = qrcode.make(data)

#PIL stands for Python Imaging Library, 
#and it is one of the most popular libraries in Python for image processing. 
#The PIL library provides extensive file format support, 
#an efficient internal representation, and powerful image processing capabilities.
