use datascience;

drop table hackers;
CREATE TABLE hackers
(
hacker_id INT NOT NULL,
name VARCHAR(50) NOT NULL
);
insert into hackers(hacker_id,name)
values (1,"sahil"), (2,"pop"), (3,"bob"),(4,"aditi");

drop table challenges;
CREATE TABLE challenges
(
hacker_id INT NOT NULL,
challenge_id INT NOT NULL
);
insert into challenges(hacker_id,challenge_id)
values (1,500), (2,502), (3,403),(1,407),(2,309),(1,509),(4,609),(4,608);



SELECT c.hacker_id, h.name, count(c.hacker_id) as counter
FROM Hackers h
INNER JOIN Challenges c 
on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id

HAVING

counter =( 
    SELECT max(t1.cc) 
    FROM(
        SELECT count(hacker_id)as cc
        FROM challenges
        group by hacker_id
        order by hacker_id
        ) as t1
         )
    
OR

counter in(
    SELECT t2.cc2
    FROM(
        SELECT COUNT(*) AS cc2
        FROM challenges 
        group by hacker_id 
        ) as t2
    group by t2.cc2
    having count(t2.cc2)=1
           )
          
ORDER BY counter DESC,c.hacker_id ;