from struct import *
from datetime import datetime
import time
from os import path
import json 
from sys import platform
import sqlite3

# from mylib import Zone


'''
Generic class that hold the info for Sprinklers
- Zone
- Description
- contains a Schedule
'''

class Zone:
    '''
    def __init__(self, name, channel, scheduleDataRaw, isActive=False):
        self.name = name
        self.channel = channel
        self.isActive = isActive
        self.scheduleStr = scheduleDataRaw
        self.schedules = []
        self.parseSchedule()
    '''

    def __init__(self, name, channel, desc):
        self.name = name
        self.channel = channel
        self.desc = desc
        self.schedules = []
        

    '''
    def parseSchedule(self):
        #print("Length of schedule {}".format(self.scheduleStr))

        # print("parseSchedule: {} ".format(self.scheduleStr[0]))
        length = len(self.scheduleStr)
        print("\t num of schedule(s) {}".format(length))

        for i in range(0, length):
            data = self.scheduleStr[i]
            self.schedules.append(Schedule(data['day'], 
                                    data['startHour'], 
                                    data['startMinute'], 
                                    data['runFor']))
    '''
    
    def addSchedule(self, schedule): 
        self.schedules.append(schedule)

    def getActiveSchedule(self):
        active = []
        for i in self.schedules: 
            if i.isCurrent():
                active.append(i)
        return active

    @staticmethod
    def fromJson(data):
        print("fromJSON: {}".format(data['schedule']))
        # data = json.loads(json_data)
        return Zone(data['name'], data['channel'], 
                    data['schedule'], data['isActive'])


    ''' returns a list of zones and it's schedules '''    
    @staticmethod
    def fromDB():
        zones = []
        query = "select day, startHour, startMinute, runForSeconds from schedule where zoneid=:zoneid"        

        conn = sqlite3.connect('sprinkler.db')

        with conn:
        
            curs = conn.cursor()

            for row in curs.execute("select id, name, channel, desc from zone"):
                #print("{}, {}, {}, {}".format(row[0], row[1], row[2], row[3]))
                
                _zone = Zone(row[1], row[2], row[3])
                cursor2 = conn.cursor()
                for sch in cursor2.execute(query, {"zoneid": row[0]}):
                    _schd = Schedule(sch[0], sch[1], sch[2], sch[3])
                    _zone.addSchedule(_schd)
                zones.append(_zone)
        return zones 
                
    
class Schedule:
    def __init__(self, dayOfWeek, startHour, startMin, runSecs):
        self.dayOfWeek = dayOfWeek
        self.startHour = startHour
        self.startMinute = startMin
        self.runSeconds = runSecs
        self.scheduleStr = "{} {}:{}"
        self.scheduleStr = self.scheduleStr.format(self.dayOfWeek, self.startHour, self.startMinute)
        print("Schedule {}".format(self.scheduleStr))

    def isCurrent(self):
        cTimeStr = "{} {}:{}"
        now = datetime.now()
        currentDay = now.strftime("%w")
        currentHour = now.strftime("%-H")
        currentMin = now.strftime("%-M")
        cTimeStr = cTimeStr.format(currentDay, currentHour, currentMin)
        
        # print("Compare {} == {} ".format(cTimeStr,self.scheduleStr))
        return cTimeStr == self.scheduleStr

    def toStr(self):
        return "Day:{}, Hour:{}, Min:{}, RunFor:{}".format(self.dayOfWeek, self.startHour, 
            self.startMinute, self.runSeconds)

