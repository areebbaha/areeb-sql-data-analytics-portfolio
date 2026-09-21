
/*🎬 MySQL DDL Practice Task — TFI Database
Scenario
You are working as a Database Designer for the Telugu Film Industry (TFI).
A production company wants to build a database to manage information about movies, actors, directors, producers, and genres.
Your job is to create and modify the database structure using DDL commands only.
*/
-- Part 1 — Create the Database
create database if not exists tfi_database;
use tfi_database;
-- part 2 Create the Tables
create table movies(
movie_id int,
title varchar(100),
release_date date,
language varchar(30),
genre varchar(50),
budget decimal(12,2),
box_office decimal(12,2),
rating decimal(3,1)
);
create table actors(
actor_id int,
actor_name varchar(100),
date_of_birth date,
debut_year year
);
create table directors(
director_id int,
director_name varchar(100),
date_of_birth date,
debut_year year
);
create table producer(
producer_id int,
producer_name varchar(100),
production_house varchar(100)
);
create table genres(
genre_id int,
genre_name varchar(100),
description varchar(200)
); 
-- Part 3  — ALTER TABLE
select * from movies;
-- task 1 Add the following column to movies: runtime_minutes → INT
alter table movies 
add runtime_minutes int;

-- task 2 Add the following column to actors: phone → VARCHAR(15)
alter table actors 
add phone varchar(15);

-- task 3  The production company decides that language is not a good column name.Rename:language → movie_language
alter table movies
rename column language to movie_language;

-- task 4 The rating system has changed.
-- Modify: rating DECIMAL(3,1) to: rating DECIMAL(4,2)
alter table movies
modify rating decimal (4,2);

-- task 5  The production company no longer wants to maintain the description column in genres.Remove it.
alter table genres 
drop column description ; 

-- task 6 Add a new column to directors: awards_count → INT
alter table directors
add awards_count int;

-- part 4 — Rename Tables The company wants to improve its naming convention.
-- Rename: actors → tfi_actors and: directors → tfi_directors

rename  table actors to tfi_actors;
rename table directors to tfi_directors;

-- part 5 Create a temporary table:
-- test_movies with: movie_id → INT title → VARCHAR(100)
create table test_movies (
movie_id int,
title varchar(100)
);

-- task 1 Which command would you use if you wanted to remove all records but keep the table structure?
-- ans: truncate table test_movies; 

-- task 2 Which command would you use if you wanted to completely remove the table?
-- ans:drop table test_movies;

-- challenge 1 : You accidentally created: 
-- movie_details but the company wants: movies Which DDL command should you use?
-- ans: rename

-- challenge 2 The company wants to add:
-- music_director → VARCHAR(100) to the movie table. Which command?
alter table movies
add music_director varchar(100);

-- challenge 3 The company decides that phone is no longer required in tfi_actors. Which command?
alter table tfi_actors 
drop column phone;

-- challenge 4 The company wants to completely remove the temporary test_movies table. Which command?
drop table test_movies;