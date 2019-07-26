from struct import *
from datetime import datetime
import time
from os import path
import json 
from sys import platform
from Zone import *
import sqlite3


if platform.startswith('linux'):
    print ("#### PLATFROM ",platform)
    import smbus

VERSION = "2019.7.22.20.03"

def log(msg):
    now = datetime.now()        
    print("[{}] {}".format(now.strftime("%w, %-H:%-M"), msg))

class Controller:
    # Here will be the instance stored.
    __instance = None
    DEVICE = 0x20
    IODIRA = 0x00
    IODIRB = 0x01

    GPIOA = 0x12
    GPIOB = 0x13
    

    @staticmethod
    def getInstance():
        """ Static access method. """
        if Controller.__instance == None:
            Controller()
        return Controller.__instance 

    def __init__(self):
        """ Virtually private constructor. """
        if Controller.__instance != None:
            raise Exception("This class is a singleton!")
        else:
            Controller.__instance = self
            self.num_zones = 16
            self.zones = []
    
    def init_hardware(self):
        if platform.startswith('linux'):        
            self.__bus=smbus.SMBus(1)
            self.__bus.write_byte_data(Controller.DEVICE, Controller.IODIRA, 0x00)
            self.__bus.write_byte_data(Controller.DEVICE, Controller.IODIRB, 0x00)
            self.__bus.write_byte_data(Controller.DEVICE, Controller.GPIOA, 0xff)
            self.__bus.write_byte_data(Controller.DEVICE, Controller.GPIOB, 0xff)
        #self.conf = Controller._load_settings()
        #self.parse_zones()
        log("loading from DB")
        self.zones = Zone.fromDB()
        length = len(self.zones)
        log("Number of Zone from DB : {}".format(length))

        '''
    def parse_zones(self):
        log("# parse_zones")
        log("\tConf \n\t {}".format(self.conf))

        # print("parseSchedule: {} ".format(self.scheduleStr[0]))
        length = len(self.conf['zones'])
        log("\t >> num of zones(s) {}".format(length))

        # print("## length :{}".format(len))
        for i in range(0, length):
            log("\t\t loading zone {}".format(i))
            self.zones.append(Zone.fromJson(self.conf['zones'][i]))
        '''

    def cycleZones(self, seconds):
        log("cycle through zones")
        for zone in self.zones:
            #log("zone: {}".format(zone.name))
            log("{} cycle {} secs ".format(zone.name, seconds))
            self.startChannel(zone.channel, seconds)
            time.sleep(seconds)

    def stopZone(self):
        for gpio in [Controller.GPIOB, Controller.GPIOA]:
            self.__bus.write_byte_data(Controller.DEVICE, gpio, 0xff)

    def run(self):
        log("# in run")

        while True: 
            log("\nv:{} running through {} zones".format(VERSION, len(self.zones)))
            for zone in self.zones:
                #log("zone: {}".format(zone.name))
                
                for sched in zone.getActiveSchedule():
                    log("{} found active {}".format(zone.name, sched.toStr()))
                    # run the zone 
                    runforSeconds = sched.runSeconds
                    self.startChannel(zone.channel, runforSeconds)
            time.sleep(15)


    def startChannel(self, ch=0, seconds=500):
        a = [0xfe , 0xfd , 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f]
        channel = ch
        gpio = (Controller.GPIOB, Controller.GPIOA) [ch < 8]
        ch  -= (8, 0) [ch < 8]
        
        log("\trunning channel:{} for {} seconds".format(ch, seconds))
        
        if platform.startswith('linux'):
            startTime = datetime.now()
            
            self.__bus.write_byte_data(Controller.DEVICE, gpio, a[ch])
            time.sleep(seconds)
            self.__bus.write_byte_data(Controller.DEVICE, gpio, 0xff)
            endTime = datetime.now()
            self.addWaterLog(startTime.strftime("%H:%M:%S"),
                             endTime.strftime("%H:%M:%S"),
                             channel,
                             (endTime-startTime).total_seconds())
        else:           
            time.sleep(seconds)

            
    def addWaterLog(self, startTime, endTime, channel, seconds):
        query = "insert into waterlog (startTime, channel, endTime, secondsOn) values(?, ?, ?, ?)"     

        conn = sqlite3.connect('sprinkler.db')

        with conn:
            curs = conn.cursor()
            curs.execute(query, (startTime, channel, endTime, seconds))


    '''
    @staticmethod
    def _load_settings(file_name='zone-settings.json'):
        print("load_default {}".format(file_name))
        if path.exists(file_name): 
            with open('zone-settings.json', 'r') as file:
                return json.loads(file.read())
        else: 
            raise Exception("Configuration Not Found")

    '''

if __name__ == "__main__":
    controller = Controller()
    controller.init_hardware()
    #controller.cycleZones(.1)
    controller.run()



# s1 = Singleton() # Ok
# #Singleton() # will raise exception
# print(s1)

# s2 = Singleton.getInstance()
# print(s2)

# s3 = Singleton.getInstance()
# print (s3) # will print the same instance as before

# if s3 == s2 : 
#     print("s1 == s2")
# else:
#     print("s1 != s2")

# if s2 == s3: 
#     print("s2 == s3")
# else:
#     print("s2 != s3")
