from struct import *
from datetime import datetime
import time
from os import path
import json 
from sys import platform
import sqlite3
import functools
import calendar
from datetime import timedelta

# from mylib import Zone
# something wierd that calendar takes monday as day 0 but datetime treats sunday as day 0 
DAYS = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
'''
Generic class that hold the info for Sprinklers
- Zone
- Description
- contains a Schedule
'''

class Zone:
    """ Represents a zone and it's schedule """
    
    def __init__(self, zoneId, name, relay_channel, desc):
        self.name = name
        self.zoneId = zoneId
        self.relay_channel = relay_channel
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

    def getNextSchedule(self):
        # //print("CALLED")
        self.schedules.sort()
        #     # cm = datetime.now().strftime("%w %-H:%-M")
        #     # d = datetime.strptime(cm, '%w %H:%M')
        #     sch_d = datetime.strptime("{} {}:{}".format(s.dayOfWeek, s.startHour, s.startMinute), '%w %H:%M') 
        #     sch.append(sch_d)
        # sch.sort()

        for a in self.schedules:
            if a.getNextRunDatetime() >= datetime.now():
                # print("Zone {} to run at {}".format(self.zoneId, a.toStr()))
                return a
        return None

    def getSchedules(self):
        print("\nZone:{} on relay:{}, desc:{}".format(self.zoneId, self.relay_channel, self.desc))
        for s in self.schedules:
            print("\t On {}, start at {:02d}:{:02d} for {} secs".format(DAYS[s.dayOfWeek], s.startHour, s.startMinute, s.runSeconds))


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
        query = "select day, start_hour, start_minute, run_seconds from schedule where zone_id=:zoneid"        

        conn = sqlite3.connect('sprinkler.db')

        with conn:
        
            curs = conn.cursor()

            for row in curs.execute("select zone_id, name, relay_channel, desc from zone"):
                print("\nZone:{} on relay:{}, desc:{}".format(row[0], row[2], row[3]))
                
                _zone = Zone(zoneId=row[0], name=row[1], relay_channel=row[2], desc=row[3])
                cursor2 = conn.cursor()
                for sch in cursor2.execute(query, {"zoneid": row[0]}):
                    print("\t On {}, start at {:02d}:{:02d} for {} secs".format(DAYS[sch[0]], sch[1], sch[2], sch[3]))
                    _schd = Schedule(zoneId=row[0], 
                                    dayOfWeek=sch[0], startHour=sch[1], 
                                    startMin=sch[2], runSecs=sch[3])
                    _zone.addSchedule(_schd)
                zones.append(_zone)
        return zones 
                
@functools.total_ordering
class Schedule:
    def __init__(self, zoneId, dayOfWeek, startHour, startMin, runSecs):
        self.dayOfWeek = dayOfWeek
        self.zoneId = zoneId
        self.startHour = startHour
        self.startMinute = startMin
        self.runSeconds = runSecs
        self.scheduleStr = "{} {}:{}"
        self.scheduleStr = self.scheduleStr.format(self.dayOfWeek, self.startHour, self.startMinute)
        # print("Schedule {}".format(self.scheduleStr))
        # self.sch_dt = datetime.strptime("{} {}:{}".format(s.dayOfWeek, s.startHour, s.startMinute), '%w %H:%M') 

    def __lt__(self, other):
        return self.getNextRunDatetime() < other.getNextRunDatetime()

    def getNextRunDatetime(self):
        """ returns the schedule as a datetime object. 
        *Note* since the schedule only contains day of the week and hour and minute. The object returned year is set to 1900.
        """
        now = datetime.now()
        currentDay = now.strftime("%w")
        currentHour = now.strftime("%-H")
        currentMin = now.strftime("%-M")

        delta = timedelta(days=int(currentDay), hours=int(currentHour), minutes=int(currentMin))
        #gets to start of week 
        baseline = now - delta
        
        # to base line add the schedule time. 
        # print("baseline:{}".format(ddd.strftime("%a %d-%b-%Y-%H:%M")))
        return baseline + timedelta(days=int(self.dayOfWeek), hours=int(self.startHour), minutes=int(self.startMinute))

        # return datetime.strptime("{} {}:{}".format(self.dayOfWeek, self.startHour, self.startMinute), '%d-%b-%Y %w %H:%M') 

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
        _d = self.getNextRunDatetime()
        _d = _d + timedelta(seconds=self.runSeconds)
        # print("date time : {}, {}, {}".format(_d, _))
        return "Zone {}, to run on {}, at {:02d}:{:02d} until {}:{} for {} secs".format(self.zoneId, DAYS[self.dayOfWeek], 
            self.startHour, self.startMinute, _d.strftime("%H"), _d.strftime("%M"), self.runSeconds)

