import datetime as dt
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
from firebase_admin import db
from gpiozero import Button
from servo_manager import *

# Get last document in a collection as a dict
def get_last_document(ref):
  max_doc = list(ref.get())[0]
  for i in list(ref.get()):
    cur_id = i.id
    if int(cur_id) > int(max_doc.id):
      max_doc = i
  return max_doc

# Credit: https://raspberrypi.stackexchange.com/questions/2086/how-do-i-get-the-serial-number
def get_serial():
  # Extract serial from cpuinfo file
  cpuserial = "0000000000000000"
  try:
    f = open('/proc/cpuinfo','r')
    for line in f:
      if line[0:6]=='Serial':
        cpuserial = line[10:26]
    f.close()
  except:
    cpuserial = "ERROR000000000"

  return cpuserial

def create_document(id):
  id = str(id)
  doc_ref = devices_ref.document(id)
  new_user = {
	  "time": dt.datetime.now()
  }
  doc_ref.set(new_user)

# set globals
cred = credentials.Certificate("womenshealth-1186b-firebase-adminsdk-lojf4-1123978aa1.json")
firebase_admin.initialize_app(cred, {'databaseURL': 'https://womenshealth-1186b.firebaseio.com/'})
db = firestore.client()
devices_ref = db.collection('devices/' + get_serial() + '/button_log')
last_id = str(get_last_document(devices_ref).id)
button = Button(10)

# start listening for button presses
servo_man = ServoManager()
servo_man.daemon = True
servo_man.start()

# Listen for button
try:
    while True:
        button.wait_for_press()
        button.wait_for_release()
        last_id = str(int(last_id) + 1)
        servo_man.inc_press(1)
        create_document(last_id)
except KeyboardInterrupt:
    print("End")