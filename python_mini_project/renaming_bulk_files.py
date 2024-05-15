import os

def main():
    i = 0
    path = "C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/rename_pictures/"
    picture_names = ['Raiden', 'Hutao', 'Ayaka']  # List of picture names

    for filename in os.listdir(path):
        # Get the file extension
        file_ext = os.path.splitext(filename)[1]

        # Check if the file is an image file
        if file_ext.lower() in ['.jpg', '.jpeg', '.png', '.gif']:
            if i >= len(picture_names):
                # If we run out of names, start from the beginning
                i = 0

            # Construct the new filename
            #picture_names[1] is 'raiden', and file_ext is .jpg. 
            #The f-string combines them into a single string: "raiden.jpg"
            new_filename = f"{picture_names[i]}{file_ext}"
            my_source = os.path.join(path, filename)
            my_dest = os.path.join(path, new_filename)

            # Rename the file
            os.rename(my_source, my_dest)
            i += 1

if __name__ == '__main__':
    main()



'''
import os 

def main():
    i = 0
    path = "C:/Users/yuyan/OneDrive/Desktop/Git Demo/python_mini_project/rename_pictures/"
    for filename in os.listdir(path):
        my_dest = "Genshin" + str(i) + ".jpg"
        my_source = path + filename
        my_dest = path + my_dest
        os.rename(my_source, my_dest)
        i += 1
if __name__ == '__main__':
    main()
'''