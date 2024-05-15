import time

def countdown(t):
    while t:
        mins, secs = divmod(t, 60)
        timer = '{:02d}:{:02d}'.format(mins, secs)
        print(timer, end="\r")
        time.sleep(1)
        t -= 1

    print('Time is up!')

if __name__ == '__main__':
    try:
        mins = int(input('Enter the minutes: '))
        secs = int(input('Enter the seconds: '))
        t = mins * 60 + secs
        countdown(t)
    except ValueError:
        print('Invalid input. Please enter a number for both minutes and seconds.')
