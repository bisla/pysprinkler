-- zone 0 = backyard mango and main tree and side fence 
-- zone 1 = bath window and cottage 
-- zone 2 only kaitlin cottage
-- zone 3 facing lawn bath window. 
-- zone 4 front lawn 
-- zone 5 front tree, hedge near nook, rose bush on front side walk, maple tree, side mandar  
-- zone 6 - fence west side near garbage and shed. 
-- zone 7 - back lawn near brick side
-- zone 8 - back lawn umbrella tre
-- zone 9 - umbrella tree side 
-- zone 10 - fence side 
-- zone 11 - master bedroom bush 

-- drop table zone; 
CREATE TABLE zone (
    zone_id         INT PRIMARY KEY NOT NULL, 
    relay_channel   INT NOT NULL UNIQUE, /* these range from 0 - 15 */
    name            TEXT NOT NULL, 
    desc            TEXT, 
    isActive        BOOLEAN DEFAULT 1, 
    create_ts       DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')), 
    update_ts       DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);

insert into zone (zone_id, relay_channel, name, desc) values (0, 0, "zone 0", "(b) backyard, mango, main tree, side fence east");
insert into zone (zone_id, relay_channel, name, desc) values (1, 1, "zone 1", "(b) bath window and cottage"); 
insert into zone (zone_id, relay_channel, name, desc) values (2, 2, "zone 2", "(b) only kaitlin cottage"); 
insert into zone (zone_id, relay_channel, name, desc) values (3, 3, "zone 3", "(b) facing backyard lawn near bath window"); 
insert into zone (zone_id, relay_channel, name, desc) values (4, 4, "zone 4", "(f) front lawn"); 
insert into zone (zone_id, relay_channel, name, desc) values (5, 5, "zone 5", "(f) front tree, hedge near nook, rose bush on front side walk, maple tree, side mandar, letter box"); 
insert into zone (zone_id, relay_channel, name, desc) values (6, 15, "zone 6", "(b) fence west side near garbage and shed."); 
insert into zone (zone_id, relay_channel, name, desc) values (7, 14, "zone 7", "(b) back lawn near brick side"); 
insert into zone (zone_id, relay_channel, name, desc) values (8, 13, "zone 8", "(b) back lawn umbrella tree"); 
insert into zone (zone_id, relay_channel, name, desc) values (9, 12, "zone 9", "(b) umbrella tree side"); 
insert into zone (zone_id, relay_channel, name, desc) values (10,11, "zone 10", "(b) fence west side"); 
insert into zone (zone_id, relay_channel, name, desc) values (11,10, "zone 11", "(b) master bedroom bush"); 

-- drop table waterlog; 
CREATE TABLE waterlog (
	start_ts        TEXT NOT NULL, 
	zone_id         INT NOT NULL, 
	end_ts          TEXT NOT NULL, 
	run_seconds     INT NOT NULL, 
	create_ts       DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);

-- drop table schedule; 
CREATE TABLE schedule (
    zone_id         INT NOT NULL, 
	day             INT NOT NULL, 
	start_hour      INT NOT NULL, 
	start_minute    INT NOT NULL, 
	run_seconds     INT NOT NULL, 
	create_ts       DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')), 
	update_ts       DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime'))
);	

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (0, 0, 4, 0, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (0, 2, 4, 0, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (0, 3, 4, 0, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (0, 4, 4, 0, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (0, 5, 4, 0, 60*5);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (1, 0, 4, 6, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (1, 2, 4, 6, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (1, 3, 4, 6, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (1, 5, 4, 6, 60*5);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (2, 0, 4, 12, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (2, 2, 4, 12, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (2, 3, 4, 12, 60*5);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (2, 5, 4, 12, 60*5);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (3, 0, 4, 18, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (3, 2, 4, 18, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (3, 3, 4, 18, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (3, 5, 4, 18, 60*4);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (4, 0, 4, 23, 60*10);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (4, 2, 4, 23, 60*10);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (4, 3, 4, 23, 60*10);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (4, 5, 4, 23, 60*10);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (5, 0, 4, 34, 60*15);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (5, 2, 4, 34, 60*15);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (5, 3, 4, 34, 60*15);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (5, 4, 4, 34, 60*15);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (5, 5, 4, 34, 60*15);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (6, 0, 4, 50, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (6, 2, 4, 50, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (6, 3, 4, 50, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (6, 5, 4, 50, 60*3);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (7, 0, 4, 54, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (7, 2, 4, 54, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (7, 3, 4, 54, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (7, 5, 4, 54, 60*3);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (8, 0, 4, 58, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (8, 2, 4, 58, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (8, 3, 4, 58, 60*4);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (8, 5, 4, 58, 60*4);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (9, 0, 5, 03, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (9, 2, 5, 03, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (9, 3, 5, 03, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (9, 5, 5, 03, 60*3);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (10, 0, 5, 7, 60*6);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (10, 2, 5, 7, 60*6);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (10, 3, 5, 7, 60*6);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (10, 5, 5, 7, 60*6);

insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (11, 0, 5, 14, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (11, 2, 5, 14, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (11, 3, 5, 14, 60*3);
insert into schedule (zone_id, day, start_hour, start_minute, run_seconds) values (11, 5, 5, 14, 60*3);
