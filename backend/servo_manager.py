from gpiozero import Servo
from threading import Thread
from time import sleep

class ServoManager(Thread):
    def __init__(self):
        Thread.__init__(self)
        self.button_presses = 0

    # Credit: https://www.raspberrypi.org/forums/viewtopic.php?t=179888
    def dip(self):
        servo = Servo(12)
        servo.min()
        sleep(0.5)
        servo.max()
        sleep(0.5)
        servo.min()

    def inc_press(self, x):
        self.button_presses += x

    # listen for button pushes
    def run(self):
        try:
            while True:
                if self.button_presses > 0:
                    self.dip()
                    self.button_presses -= 1
        except KeyboardInterrupt:
            pass