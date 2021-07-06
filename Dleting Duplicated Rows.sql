USE datascience;
DROP TABLE IF EXISTS contacts;

-- Creating pre-sample data

CREATE TABLE contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

INSERT INTO contacts (first_name,last_name,email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');
       
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

SELECT * FROM contacts

