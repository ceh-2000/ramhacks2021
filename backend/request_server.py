from flask import Flask, redirect, url_for, request
from firebase_updater import *

# credit: https://pythonbasics.org/flask-http-methods/
#         https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask

num = 0
display = init_display()
servo_man = init_servo_man()

app = Flask(__name__)

@app.route('/requests',methods = ['POST', 'GET'])
def requests():
    global num
    # if key doesn't exist, returns None
    if "amount" in request.args:
        amount = request.args.get("amount")
        for i in range(int(amount)):
            num = process_press(display, servo_man, num)
        return "<p>Success!</p>"
    elif "set" in request.args:
        display.ShowInt(request.args.get("set"))
        num = request.args.get("set")
        return "<p>Success!</p>"
    return "<p>No action</p>"

if __name__ == '__main__':
    app.run(debug = True)