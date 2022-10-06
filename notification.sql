create database mysql_notification;
use mysql_notification;
create table user
(
id int not null,
name varchar(45) not null,
primary key (id)
)engine= InnoDB

show tables;

insert into user (id,name) values (101, "lilis setiyorini");
insert into user (id,name) values (102, "Waldy Irfan Naufal");
insert into user (id,name) values (103, "Fatimah");
insert into user (id,name) values (104, "Budiarto");

select * from user;
show tables;

create table category
(
id int not null,
name varchar(45) not null,
primary key (id)
) engine = InnoDB

insert into category (id,name) values (201,"info"),(202,"promo");

select * from category;

create table notification
(
id int not null auto_increment,
title varchar(45) not null,
detail text not null,
create_at timestamp not null,
user_id int not null,
category_id int not null,
primary key(id),
constraint fk_notification_user
foreign key (user_id) references user(id)
)Engine = InnoDB;

alter table notification
add constraint fk_notification_category
foreign key (category_id) references category(id);

INSERT INTO notification(title, detail, create_at, user_id,category_id) 
VALUES ('Contoh Pesanan', 'Detail Pesanan', CURRENT_TIMESTAMP(), '101','201');
INSERT INTO notification(title, detail, create_at, user_id,category_id)
VALUES ('Contoh Promo', 'Detail Promo', CURRENT_TIMESTAMP(), '104', '202');
INSERT INTO notification(title, detail, create_at, user_id,category_id)
VALUES ('Contoh Pembayaran', 'Detail Pembayaran', CURRENT_TIMESTAMP(), '102','201');
INSERT INTO notification(title, detail, create_at, user_id,category_id)
VALUES ('Contoh Pembayaran', 'Detail Pembayaran', CURRENT_TIMESTAMP(), '103','201');
INSERT INTO notification(title, detail, create_at, user_id,category_id)
VALUES ('Contoh promo', 'Detail promo', CURRENT_TIMESTAMP(), '104','202');

select * from notification;

select * from notification
where (user_id = 101 or user_id = 102)
order by create_at desc;

create table notification_read
(
id int not null auto_increment,
is_read boolean not null,
notification_id int not null,
user_id int not null,
primary key(id)
)engine = innoDB;

show tables;

alter table notification_read
add constraint fk_notification_read_notification
foreign key (notification_id) references notification(id);

alter table notification_read
add constraint fk_notification_read_user
foreign key (user_id) references user(id);

desc notification;

INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 1, '101');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 2, '104');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 3, '102');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 4, '103');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 5, '104');


select * from notification_read;

SELECT *
FROM notification n
JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = 101 OR n.user_id = 104) AND (n.user_id = 103 OR nr.user_id = 101)
ORDER BY n.create_at DESC;

#counter
SELECT COUNT(*)
FROM notification n
JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = 101 OR n.user_id = 104) AND (n.user_id = 103 OR nr.user_id = 101)
ORDER BY n.create_at DESC;

INSERT INTO notification(title, detail, category_id, user_id, create_at)
VALUES ('Contoh Pesanan Lagi', 'Detail Pesanan lagi', '202', '101', CURRENT_TIMESTAMP());
INSERT INTO notification(title, detail, category_id, user_id, create_at)
VALUES ('Contoh Pesanan Lagi', 'Detail Pesanan lagi', '201', '101', CURRENT_TIMESTAMP());
INSERT INTO notification(title, detail, category_id, user_id, create_at)
VALUES ('Contoh Promo Lagi', 'Detail Pesanan lagi', '202', '102', CURRENT_TIMESTAMP());

INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 6, '101');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 7, '101');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 8, '102');

select * from notification;
select * from notification_read;


SELECT COUNT(*)
FROM notification n
JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
ORDER BY n.create_at DESC;
