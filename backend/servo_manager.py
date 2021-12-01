from gpiozero import AngularServo
from threading import Thread
from time import sleep
import RPi.GPIO as GPIO

class ServoManager(Thread):
    def __init__(self):
        Thread.__init__(self)
        self.button_presses = 0

    # Credit: https://www.raspberrypi.org/forums/viewtopic.php?t=179888
    def dip(self):
        servo = AngularServo(12, min_angle=0, max_angle=360, min_pulse_width=.0001, max_pulse_width=.005, frame_width=0.05)
        # for i in range(0, 370, 10):
        servo.angle = 60
        sleep(1)
        print(servo.angle)
        servo.angle = 170
        sleep(1)
        print(servo.angle)
        servo.angle = 60
        sleep(1)
        print(servo.angle)


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