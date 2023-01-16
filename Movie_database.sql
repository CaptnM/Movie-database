# PROJECT DONE ON MOVIES DETAIL RECORDS
show databases;
create database Movie_Project;
use Movie_Project;

# create parent table no.1 actor
#creating Actor table
create table  actor(act_id int primary key,
act_fname varchar(20),
act_lname varchar(20),
act_gender varchar(1));

#Inserting values into actor table
insert into actor values
(1,'Aamir','Khan','M'),
(2,'Emraan','Hashmi','M'),
(3,'Salman','Khan','M'),
(4,'Ranvir','Singh','M'),
(5,'Sushant','Rajput','M'),
(6,'Kajol','Devgan','F'),
(7,'Deepika','Padukone','F'),
(8,'Tapsee','Pannu','F'),
(9,'Kiara','Advani','F'),
(10,'Vidya','Balan','F');
select * from actor;
#drop table actor;

# create parent table no.2 director
#Creating Director table
create table  director(dir_id int primary key,
dir_fname varchar(20),
dir_lname varchar(20));

#Insert values in director table
insert into director values
(1,'Raju','Hirani'),
(2,'Anurag','Kashyap'),
(3,'Farhan','Akhtar'),
(4,'Rajkumar','Santoshi'),
(5,'Asif','Karim'),
(6,'Nandita','Das'),
(7,'Zoya','Akhtar'),
(8,'Kiran','Rao');
select * from director;

# create parent table no.3 movie
create table movie (
mov_id int primary key,
mov_title varchar(50),
mov_year int,
mov_time int,
mov_lang varchar(50),
mov_rel_dt date,
mov_rel_country varchar(10));
desc movie;

insert into movie values
(1,'3 idiots',2006,167,'Hindi','2014-01-05','India'),
(2,'Jannat',2010,150,'Arabic','2014-02-10','Dubai'),
(3,'Tiger',2002,180,'English','2014-03-15','America'),
(4,'Gullyboy',2009,190,'Hindi','2014-04-20','India'),
(5,'M.S.Dhoni',2002,130,'Italiian','2014-05-25','Italy'),
(6,'DDLJ',2008,180,'Arabic','2014-08-30','Dubai'),
(7,'Padmavati',2005,145,'Hindi','2014-10-01','India'),
(8,'Badla',2015,155,'English','2014-12-06','America'),
(9,'Kabir Singh',2020,190,'Korean','2014-06-11','Korea'),
(10,'Kahani',2012,135,'Chinese','2014-07-22','China');
select * from movie;

# create parent table no.4 reviewer
create table reviewer (
rev_id int primary key,
rev_name varchar(30));
desc reviewer;

insert into reviewer values 
(100,'Kamal R Khan'),
(200,'Anupama Chopra'),
(300,'Taran Adarsh'),
(400,'Vijaykrishnan'),
(500,'Derek Bose');
select * from reviewer;

# create parent table no.5 genres
create table genres (
gen_id int primary key,
gen_title varchar(20));
desc genres;

insert into genres values
(1001,'Drama'),
(1002,'Mystery'),
(1003,'Action'),
(1004,'Thriller'),
(1005,'Romance'),
(1006,'Comedy'),
(1007,'Historical Fiction'),
(1008,'Legendary'),
(1009,'Horror');
select * from genres;

# create child table no.6 movie_cast
create table movie_cast (
act_id int,
constraint act_id_fk foreign key(act_id) references actor(act_id),
mov_id int,
constraint mov_id_fk foreign key(mov_id) references movie(mov_id),
role varchar(30));
desc movie_cast;

Insert into movie_cast values
(1,1,'Lead Role'),
(3,3,'Cameo'),
(5,5,'Side role'),
(7,7,'Recurring'),
(9,9,'Guest Appearance');
select * from movie_cast;

# create child table no.7 movie_direction
create table movie_direction (
dir_id int,
constraint dir_id_fk foreign key(dir_id) references director(dir_id),
mov_id int,
constraint dir_mov_id_fk foreign key(mov_id) references movie(mov_id));
desc movie_direction;

insert into movie_direction values
(1,3),
(2,7),
(3,4),
(4,1),
(5,2),
(6,5),
(7,6);
select * from movie_direction;

# create child table no.8 movie_genres
create table movie_genres (
mov_id int,
constraint mv_id_fk foreign key(mov_id) references movie(mov_id),
gen_id int,
constraint gn_id_fk foreign key(gen_id) references genres(gen_id));
desc movie_genres;

insert into movie_genres values
(2,1001),
(4,1002),
(6,1003),
(8,1004),
(10,1005);
select * from movie_genres;

# create child table no.9 rating
create table rating (
mov_id int,
constraint rat_fk foreign key(mov_id) references movie(mov_id),
rev_id int,
constraint rev_fk foreign key(rev_id) references reviewer(rev_id),
rev_stars int,
num_of_ratings int);
desc rating;

insert into rating values
(1,100,4,8),
(3,200,3,7),
(5,300,5,9),
(7,400,4,9),
(9,500,3,6);
select * from rating;

# if i want to see all the foreign key name and constraints
# we can check by using below synatx
select *  from information_schema.table_constraints where table_name in
('actor','director','movie','reviewers','genres',
'movie_cast','movie_direction','movie_genres','rating');

#_____________________INNER JOIN_____________________________________
(select actor.act_id,actor.act_fname,actor.act_lname,actor.act_gender,
movie_cast.mov_id,movie_cast.role
from actor
inner join movie_cast 
on actor.act_id = movie_cast.act_id
where act_fname = 'Salman');

#_____________________LEFT JOIN________________________________________
select movie_cast.act_id,movie_cast.mov_id,movie_cast.role,
movie.mov_title,movie.mov_year,movie.mov_time,movie.mov_lang,movie.mov_rel_dt,movie.mov_rel_country
#rating.rev_id,rating.rev_stars,rating.num_of_ratings
from movie
left join movie_cast
on movie.mov_id = movie_cast.mov_id;

select * from actor;
select * from movie_cast;

#_____________________RIGHT JOIN________________________________________
select movie_cast.act_id,movie_cast.mov_id,movie_cast.role,
movie.mov_title,movie.mov_year,movie.mov_time,movie.mov_lang,movie.mov_rel_dt,movie.mov_rel_country,
rating.rev_id,rating.rev_stars,rating.num_of_ratings
from movie_cast
right join movie
on movie.mov_id = movie_cast.mov_id
right join rating
on movie.mov_id = rating.mov_id;

#_____________________FULL OUTER JOIN________________________________________
select movie_cast.act_id,movie_cast.mov_id,movie_cast.role,
movie.mov_title,movie.mov_year,movie.mov_time,movie.mov_lang,movie.mov_rel_dt,movie.mov_rel_country,
rating.rev_id,rating.rev_stars,rating.num_of_ratings
from movie_cast
left join movie
on movie.mov_id = movie_cast.mov_id
left join rating
on movie.mov_id = rating.mov_id
union
select movie_cast.act_id,movie_cast.mov_id,movie_cast.role,
movie.mov_title,movie.mov_year,movie.mov_time,movie.mov_lang,movie.mov_rel_dt,movie.mov_rel_country,
rating.rev_id,rating.rev_stars,rating.num_of_ratings
from movie_cast
right join movie
on movie.mov_id = movie_cast.mov_id
right join rating
on movie.mov_id = rating.mov_id;

#_______________________ UNION JOIN_____________________________________
select * from reviewer
union
select * from genres
union
select *from movie_genres;

#_______________________ USING WHERE OPERATOR___________________________
select * from movie where mov_rel_country = (select mov_rel_country 
from movie where mov_rel_country = 'Korea');
select * from movie where mov_rel_country = 'Dubai' and mov_year > 2000;
select * from actor where act_gender = 'F' and act_lname like 'P%';
select * from actor where act_gender = 'F' and act_lname like '_a%'; # put underscore for next character
select * from actor where act_gender = 'M' and act_lname like 'k%';
select * from movie where mov_lang = 'Hindi' or mov_rel_country = 'India';
select * from rating where num_of_ratings < 9 or rev_stars > 4;

#_______________ GROUP BY, HAVING, ORDER BY CLAUSE__________________________________
select * from director group by dir_id having dir_id > 4;
select * from movie order by mov_title desc;
select * from movie order by mov_time desc;

#Write a query to get movie name ,reviewer name and reviewer stars together using join and in descending order
select mov_title,rev_name,rev_stars from movie
join rating on rating.mov_id=movie.mov_id
join reviewer on reviewer.rev_id=rating.rev_id
order by rev_stars desc;

#To get the action movie name using joins
select mov_title,gen_title from movie
join movie_genres on movie.mov_id=movie_genres.mov_id 
join genres on movie_genres.gen_id=genres.gen_id
where gen_title='Thriller';

#To get the name of only female actress with their movie name
select act_fname,act_lname,act_gender,mov_title from actor
join movie_cast on movie_cast.act_id=actor.act_id
join movie on movie.mov_id=movie_cast.mov_id
where act_gender='F';

#write a SQL query to find the mov_name and mov_year of the movies. 
select mov_title,mov_year from movie;
#____________________________________________________________________________________________________