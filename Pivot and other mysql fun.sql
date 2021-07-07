CREATE TABLE products
(
prod_id INT NOT NULL primary key ,
prod_name VARCHAR(50) NOT NULL
);
insert into products(prod_id,prod_name)
values (1,"shoes"), (2,"pants"), (3,"shirt");

create table reps
(
rep_id int not null primary key,
rep_name varchar(50) not null
);
insert into reps (rep_id,rep_name)
values (1,"john"), (2,"sheli"), (3,"bob");

create table sales
(
prod_id int not null,
rep_id int not null,
sale_date datetime not null,
quantity int not null,
primary key(prod_id,rep_id,sale_date),
foreign key(prod_id) references products(prod_id),
foreign key (rep_id) references reps(rep_id)
);
insert into sales(prod_id,rep_id,sale_date,quantity)
values 
(1, 1, '2013-05-16', 20),
  (1, 1, '2013-06-19', 2),
  (2, 1, '2013-07-03', 5),
  (3, 1, '2013-08-22', 27),
  (3, 2, '2013-06-27', 500),
  (3, 2, '2013-01-07', 150),
  (1, 2, '2013-05-01', 89),
  (2, 2, '2013-02-14', 23),
  (1, 3, '2013-01-29', 19),
  (3, 3, '2013-03-06', 13),
  (2, 3, '2013-04-18', 1),
  (2, 3, '2013-08-03', 78),
  (2, 3, '2013-07-22', 69);
  
  
-- We can easily query the rep, sales, and product data by joining the tables:
select 
	r.rep_name,
	p.prod_name,
	s.sale_date,
	s.quantity
from reps as r
inner join sales s
	on r.rep_id = s.rep_id
inner join products as p
	on s.prod_id = p.prod_id;

-- But what if we want to see the reps in separate rows with the total number of products 
-- sold in each column. This is where we need to implement the missing PIVOT function, 
-- so we’ll use the aggregate function SUM with conditional logic instead.

select r.rep_name,
	sum(case when p.prod_name ="shoes" then s.quantity else 0 end) as shoes,
	sum(case when p.prod_name ="pants" then s.quantity else 0 end) as pants,
	sum(case when p.prod_name ="shirt" then s.quantity else 0 end) as shirt
from reps r
inner join sales s
	on r.rep_id = s.rep_id
inner join products p
	on s.prod_id = p.prod_id
group by r.rep_name;
 
-- set up a dynamic query using the data above. 
-- we need to report the total quantity of items sold by each rep for each month/year combination. 
-- Again, this is easy if you only had a few dates, you would write the query:

select r.rep_name,
	sum(case when date_format (s.sale_date,"%Y-%M") = "2013-January" then s.quantity else 0 end) as "2013-JANUARY",
  sum(case when Date_format(s.sale_date, '%Y-%M')= '2013-February' then s.quantity else 0 end) as `2013-February`,
  sum(case when Date_format(s.sale_date, '%Y-%M')= '2013-March' then s.quantity else 0 end) as `2013-March`,
  sum(case when Date_format(s.sale_date, '%Y-%M')= '2013-April' then s.quantity else 0 end) as `2013-April`,
  sum(case when Date_format(s.sale_date, '%Y-%M')= '2013-May' then s.quantity else 0 end) as `2013-May`
from reps r
inner join sales s
	on r.rep_id = s.rep_id
inner join products p
	on s.prod_id = p.prod_id
group by r.rep_name;



-- But what happens if you don’t know the dates ahead of time,
-- or you want to pass in certain parameters to filter the dates and
-- make the report flexible. This is where dynamic SQL is needed.
-- In order to create the sql string to execute, you’ll first need to get a full list of the dates 
-- from your sales table. This list will be created by using GROUP_CONCAT() and CONCAT()

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(case when Date_format(s.sale_date, ''%Y-%M'') = '' ',
      dt,
      ' '' then s.quantity else 0 end) AS ` ',
      dt, '`'
    )
  ) 
INTO @sql
from
(
  select Date_format(s.sale_date, '%Y-%M') as dt
  from sales s
  order by s.sale_date
) d;

SET @sql 
  = CONCAT('SELECT r.rep_name, ', @sql, ' 
            from reps r
            inner join sales s
              on r.rep_id = s.rep_id
            inner join products p
              on s.prod_id = p.prod_id
            group by r.rep_name;');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
            
-- SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(case when Date_format(s.sale_date, ''%Y-%M'') = ''',
      dt,
      ''' then s.quantity else 0 end) AS `',
      dt, '`'
    )
  ) INTO @sql
from
(
  select Date_format(s.sale_date, '%Y-%M') as dt
  from sales s
  order by s.sale_date
) d;

SET @sql 
  = CONCAT('SELECT r.rep_name, ', @sql, ' 
            from reps r
            inner join sales s
              on r.rep_id = s.rep_id
            inner join products p
              on s.prod_id = p.prod_id
            group by r.rep_name;');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
