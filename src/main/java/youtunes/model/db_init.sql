/*
James Smith
1/16/2020
CSD460
Module 3 Assignment
*/

DROP DATABASE IF EXISTS youtunes;
CREATE DATABASE youtunes;

DROP USER IF EXISTS 'youtunes_user'@'localhost';

CREATE USER 'youtunes_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'MySQL8IsGreat!';

GRANT ALL PRIVILEGES ON youtunes.* TO'youtunes_user'@'localhost';

CREATE TABLE `youtunes`.`artists` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  PRIMARY KEY (`artist_id`)
);

CREATE TABLE `youtunes`.`albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `album_title` VARCHAR(100),
  `img_url` VARCHAR(150),
  `release_year` INT,
  `artist_id` INT,
  `genre` VARCHAR(100),
  `price` DOUBLE,
  PRIMARY KEY (`album_id`),
  FOREIGN KEY (`artist_id`) REFERENCES `artists`(`artist_id`)
);

INSERT INTO `youtunes`.`artists` (`first_name`, `last_name`) 
	VALUES 
	('Luke', 'Bryan'),
	('Katy', 'Perry'),
	('Mariah', 'Carey'),
	('Janet', 'Jackson'),
	('Bob', 'Dylan');

INSERT INTO `youtunes`.`albums` (`album_title`,`img_url`,`release_year`,`artist_id`,`genre`, `price`)
	VALUES 
	('Doin'' My Thing', 'images/doing_my_thing.jpg', 2009, 1, 'Country', 17.99),
	('Kill the Lights', 'images/dylan.jpg', 2015, 1, 'Country', 15.99),
	('Teenage Dream', 'images/teenage_dream.jpg', 2010, 2, 'Pop/Rock', 18.99),
	('One of the Boys', 'images/one_of_the_boys.jpg', 2008, 2, 'Pop/Rock', 19.99),
	('Memoirs of an Imperfect Angel', 'images/memoirs_of_an_imperfect_angel.jpg', 2009, 3, 'R&B', 20.99),
	('Me. I Am Mariah... The Elusive Chanteuse', 'images/me_i_am_mariah.jpg', 2014, 3, 'R&B', 15.99),
	('Discipline', 'images/discipline.jpg', 2008, 4, 'R&B', 16.99),
	('Unbreakable', 'images/unbreakable.jpg', 2015, 4, 'R&B', 19.99),
	('Dylan', 'images/dylan.jpg', 2007, 5, 'Pop/Rock', 21.99),
	('Together Through Life', 'images/together_through_life.jpg', 2009, 5, 'Pop/Rock', 10.99);