USE datascience;
DROP TABLE IF EXISTS contacts;

-- Creating pre-sample data

CREATE TABLE contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL,
    Occupation VARCHAR(50) NOT NULL
);

INSERT INTO contacts (first_name,last_name,email,Occupation) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net',"Doctor"),
       ('Jean','King','jean.king@me.com',"Actor"),
       ('Peter','Ferguson','peter.ferguson@google.com',"Actor"),
       ('Janine ','Labrune','janine.labrune@aol.com',"Teacher"),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com',"Teacher"),
       ('Janine ','Labrune','janine.labrune@aol.com',"Actor"),
       ('Susan','Nelson','susan.nelson@comcast.net',"Actor"),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net',"Teacher"),
       ('Roland','Keitel','roland.keitel@yahoo.com',"Doctor"),
       ('Julie','Murphy','julie.murphy@yahoo.com',"Doctor"),
       ('Kwai','Lee','kwai.lee@google.com',"Teacher"),
       ('Jean','King','jean.king@me.com',"Teacher"),
       ('Susan','Nelson','susan.nelson@comcast.net',"Doctor"),
       ('Roland','Keitel','roland.keitel@yahoo.com',"Teacher");
       
SELECT * FROM contacts
ORDER BY first_name;

SELECT first_name, count(first_name)
FROM contacts
group by first_name
having count(first_name) >1 ;


-- DELETING DUPLICATE ROWS, MySQL provides you with the DELETE JOIN statement that allows you to remove duplicate rows quickly.

-- This query references the contacts table twice, therefore, it uses the table alias t1 and t2.
DELETE t1 FROM contacts t1
inner join contacts t2
where t1.id < t2.id AND t1.email = t2.email ; 

-- Querying again
SELECT first_name, count(first_name)
FROM contacts
group by first_name
having count(first_name) >1 ;

SELECT * FROM contacts;

-- Query the two NAMES with the shortest and longest lengths
use datascience;
(SELECT first_name
FROM contacts
order by char_length(first_name), first_name
LIMIT 1)
UNION
(SELECT first_name
FROM contacts
order by char_length(first_name) DESC, first_name
LIMIT 1) ;



#Picking maximum and mininmum length characters
(SELECT first_name
FROM contacts
order by char_length(first_name), first_name
LIMIT 1)
UNION
(SELECT first_name
FROM contacts
order by char_length(first_name) DESC, first_name
LIMIT 1) ;


SELECT concat(first_name,"(",substring(first_name,1,1),")") as namep
FROM contacts
order by namep;

SELECT concat("There are a total of" , count(Occupation), Occupation)
FROM contacts
GROUP BY Occupation
ORDER BY 




