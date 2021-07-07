-- WHAT IS PIVOT TABLE
-- A pivot table is a statistics tool that summarizes and 
-- reorganizes selected columns and rows of data in a spreadsheet or database table to obtain a desired report. The tool does not actually change the 
-- spreadsheet or database itself, it simply “pivots” or turns the data to view it from 
-- different perspectives.
-- EXAPMLE OF PIVOT : CONVERT DATA FROM ROWS TO COLUMNS

use datascience;
select * from contacts
limit 2;



SET @r1=0, @r2=0, @r3=0, @r4=0;
select Doctor, Teacher, Actor
from(
SELECT CASE 
    WHEN Occupation="Doctor" then @r1:=@r1+1
	when Occupation='Teacher' then @r3:=@r3+1
	when Occupation='Actor' then @r4:=@r4+1 end as RowNumber,
    
    case when Occupation='Doctor' then first_name end as Doctor,
    case when Occupation='Teacher' then first_name  end as Teacher,
    case when Occupation='Actor' then first_name end as Actor
    
FROM contacts
order by first_name) temp
group by RowNumber;

-- Using Min/Max, if there is a name, it will return it, if not, return NULL.
-- Now, we only want the names and not the NULL values from our virtual table. How can we do that? - There maybe be multiple ways, 
-- lets us consider the MIN/MAX (Yes, you can replace MIN with MAX and you will get the same result)


-- With GROUP BY clause - The result set will have one row for EACH group (which is RowNumber in our case).




 
    









