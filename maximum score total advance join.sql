-- ques: The total score of a hacker is the sum of their maximum scores for all of the challenges. 
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
-- If more than one hacker achieved the same total score, 
-- then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.



use datascience;
drop table hackers;
CREATE TABLE hackers
(
hacker_id INT NOT NULL,
name VARCHAR(50) NOT NULL
);
insert into hackers(hacker_id,name)
values (1,"sahil"), (2,"pop"), (3,"bob"),(4,"aditi");

drop table submissions;
CREATE TABLE submissions
(
hacker_id INT NOT NULL,
submission_id int not null,
challenge_id INT NOT NULL,
score int not null
);
insert into submissions(hacker_id,submission_id,challenge_id,score)
values (1,5,1,50), (2,50,1,60), (3,403,1,80),(4,809,1,0),(1,407,2,34),(2,309,1,78),(3,509,2,34),(4,609,2,0),(2,45,2,45);



-- MY QUERY: 
SELECT h.hacker_id, h.name , sum(score) as tscore
FROM Hackers as h
inner join submissions as s
on s.hacker_id = h.hacker_id
WHERE 
score in ( select max(score) as score from submissions group by challenge_id,hacker_id) 
GROUP BY hacker_id
HAVING   tscore > 0 
ORDER BY tscore desc,hacker_id ASC;







