from flask import Flask, redirect, url_for, request
from firebase_updater import *

# credit: https://pythonbasics.org/flask-http-methods/
#         https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask

app = Flask(__name__)

@app.route('/requests',methods = ['POST', 'GET'])
def requests():
    num = 0
    # if key doesn't exist, returns None
    display = init_display()
    servo_man = init_servo_man()
    amount = request.args.get('amount')
    for i in range(int(amount)):
        num = process_press(display, servo_man, num)
    return "<p>Success!</p>"

if __name__ == '__main__':
   app.run(debug = True)