zone 0 = backyard mango and main tree and side fence 
zone 1 = bath window and cottage 
zone 2 only kaitlin cottage
zone 3 facing lawn bath window. 
zone 4 front lawn 
zone 5 front tree, hedge near nook, rose bush on front side walk, maple tree, side mandar  
zone 6 - fence west side near garbage and shed. 
zone 7 - back lawn near brick side
zone 8 - back lawn umbrella tre
zone 9 - umbrella tree side 
zone 10 - fence side 
zone 11 - master bedroom bush 


CREATE TABLE Zone (
	id INT PRIMARY KEY NOT NULL, 
	channel INT NOT NULL UNIQUE, 
	name TEXT NOT NULL, desc TEXT, 
	isActive BOOLEAN DEFAULT 1, 
	createTS DATETIME DEFAULT CURRENT_TIMESTAMP, 
	updateTS DATETIME DEFAULT CURRENT_TIMESTAMP);




CREATE TABLE WaterLog (
	startTime text not null, 
	channel int not null, 
	endTime text not null, 
	secondsOn int not null,
	createTS DATETIME DEFAULT CURRENT_TIMESTAMP
);

insert into zone (id, channel, name, desc) values (0, 0, "zone 0", "(b) backyard, mango, main tree, side fence east");
insert into zone (id, channel, name, desc) values (1, 1, "zone 1", "(b) bath window and cottage"); 
insert into zone (id, channel, name, desc) values (2, 2, "zone 2", "(b) only kaitlin cottage"); 
insert into zone (id, channel, name, desc) values (3, 3, "zone 3", "(b) facing backyard lawn near bath window"); 
insert into zone (id, channel, name, desc) values (4, 4, "zone 4", "(f) front lawn"); 
insert into zone (id, channel, name, desc) values (5, 5, "zone 5", "(f) front tree, hedge near nook, rose bush on front side walk, maple tree, side mandar, letter box"); 
insert into zone (id, channel, name, desc) values (6, 15, "zone 6", "(b) fence west side near garbage and shed."); 
insert into zone (id, channel, name, desc) values (7, 14, "zone 7", "(b) back lawn near brick side"); 
insert into zone (id, channel, name, desc) values (8, 13, "zone 8", "(b) back lawn umbrella tree"); 
insert into zone (id, channel, name, desc) values (9, 12, "zone 9", "(b) umbrella tree side"); 
insert into zone (id, channel, name, desc) values (10,11, "zone 10", "(b) fence west side"); 
insert into zone (id, channel, name, desc) values (11,10, "zone 11", "(b) master bedroom bush"); 


drop table schedule; 
CREATE TABLE Schedule (
	day INT NOT NULL, 
	startHour INT NOT NULL, 
	startMinute INT NOT NULL, 
	runForSeconds INT NOT NULL, 
	zoneID INT NOT NULL, 
	createTS DATETIME DEFAULT CURRENT_TIMESTAMP, 
	updateTS DATETIME DEFAULT CURRENT_TIMESTAMP);	

insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (0, 0, 4, 0, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (0, 2, 4, 0, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (0, 3, 4, 0, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (0, 4, 4, 0, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (0, 5, 4, 0, 60*5);

insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (1, 0, 4, 6, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (1, 2, 4, 6, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (1, 3, 4, 6, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (1, 5, 4, 6, 60*5);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (2, 0, 4, 12, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (2, 2, 4, 12, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (2, 3, 4, 12, 60*5);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (2, 5, 4, 12, 60*5);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (3, 0, 4, 18, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (3, 2, 4, 18, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (3, 3, 4, 18, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (3, 5, 4, 18, 60*4);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (4, 0, 4, 23, 60*10);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (4, 2, 4, 23, 60*10);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (4, 3, 4, 23, 60*10);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (4, 5, 4, 23, 60*10);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (5, 0, 4, 34, 60*15);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (5, 2, 4, 34, 60*15);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (5, 3, 4, 34, 60*15);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (5, 4, 4, 34, 60*15);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (5, 5, 4, 34, 60*15);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (6, 0, 4, 50, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (6, 2, 4, 50, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (6, 3, 4, 50, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (6, 5, 4, 50, 60*3);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (7, 0, 4, 54, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (7, 2, 4, 54, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (7, 3, 4, 54, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (7, 5, 4, 54, 60*3);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (8, 0, 4, 58, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (8, 2, 4, 58, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (8, 3, 4, 58, 60*4);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (8, 5, 4, 58, 60*4);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (9, 0, 5, 03, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (9, 2, 5, 03, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (9, 3, 5, 03, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (9, 5, 5, 03, 60*3);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (10, 0, 5, 7, 60*6);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (10, 2, 5, 7, 60*6);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (10, 3, 5, 7, 60*6);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (10, 5, 5, 7, 60*6);


insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (11, 0, 5, 14, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (11, 2, 5, 14, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (11, 3, 5, 14, 60*3);
insert into schedule (zoneID, day, startHour, startMinute, runForSeconds) values (11, 5, 5, 14, 60*3);





