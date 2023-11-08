create table employee (
emp_id int,
first_name varchar(40),
last_name varchar(40),
birth_date date,
sex varchar(1),
salary int,
branch_id int,
super_id int,
primary key (emp_id)
);

create table branch(
branch_id int,
branch_name varchar(40),
mgr_id int,
mgr_start_date date,
primary key (branch_id),
foreign key (mgr_id) references employee(emp_id)
);

alter table employee
add foreign key (branch_id) references branch(branch_id) on delete set null;

alter table employee 
add foreign key (super_id) references employee(emp_id) on delete set null;

create table client(
client_id int primary key,
client_name varchar(40),
branch_id int
);

alter table client
add foreign key (branch_id) references branch(branch_id)on delete set null;

create table works_with(
emp_id int,
client_id int,
total_sales int,
primary key (emp_id,client_id),
foreign key (emp_id)  references employee(emp_id) on delete cascade,
foreign key (client_id) references client(client_id) on delete cascade
);

create table supplier(
branch_id int,
sup_name varchar(40),
product_type varchar(40),
primary key (branch_id,sup_name),
foreign key (branch_id) references branch(branch_id) on delete cascade
);

insert into employee values(100,'David','Wallace','1967-11-17','M',250000,null,null);
insert into branch values(1,'Corporate','2006-02-09',100);
update employee set branch_id=1 where emp_id=100;

insert into employee values(101,'Jan','Levinson','1961-05-11','F',110000,1,100);

insert into employee values(102,'Michael','Scott','1964-03-15','M',75000,null,100);
insert into branch values(2,'Scranton','1992-04-06',102);
update employee set branch_id=2 where emp_id=102;

insert into employee values(103,'Angela','Martin','1971-06-25','F',63000,2,102);
insert into employee values(104,'Kelly','Kapoor','1980-02-05','F', 55000,2,102);
insert into employee values(105,'Stanley','Hudson','958-02-19','M',69000,2,102);
insert into employee values(106,'Josh','Porter','1969-09-05','M',78000,null,100);
insert into branch values(3,'Stamford','1998-02-13',106);
update employee set branch_id=3 where emp_id =106;

insert into employee values(107,'Andy','Bernard','1973-07-22','M',65000,3,106);
insert into employee values(108,'Jim','Halpert','1978-10-01','M',71000,3,106);

insert into client values(400,'Dunmore Highschool',2);
insert into client values(401,'Lackawana Country',2);
insert into client values(402,'FedEx',3);
insert into client values(403,'John Daly Law,LLC',3);
insert into client values(404,'Scranton Whitepages',2);
insert into client values(405,'Times Newspaper',3);
insert into client values(406,'FedEx',2);

insert into works_with values(105,400,55000);
insert into works_with values(102,401,267000);
insert into works_with values(108,402,22500);
insert into works_with values(107,403,5000);
insert into works_with values(108,403,12000);
insert into works_with values(105,404,33000);
insert into works_with values(107,405,26000);
insert into works_with values(102,406,15000);
insert into works_with values(105,406,130000);

insert into supplier values(2,'Hammer Mill','Paper');
insert into supplier values(2,'Uni-ball','Writing Utensils');
insert into supplier values(3,'Patriot Paper','Paper');
insert into supplier values(2,'J.T.Forms & Labels','Custom Forms');
insert into supplier values(3,'Uni-ball','Writing Utensils');
insert into supplier values(3,'Hammer Mill','Paper');
insert into supplier values(3,'Stamford Labels','Custom Forms');

-- Find all employees orderd by descending salary
select *
from employee
order by salary desc;

-- Find all employees ordered by sex then name
select *
from employee
order by sex, last_name,first_name;

-- Find the forenames and surnames of all employees
select first_name as forename, last_name as surname
from employee;

-- Find all different genders
select distinct sex
from employee;

-- Find all female employees
select *
from employee
where sex='F';

-- Find all employee's id's and names who were born after 1972
select emp_id, concat(first_name,' ', last_name) as full_name
from employee
where birthday>'1973-01-01';

-- Find all employees who are female & born after 1969 or who make over 80000
select *
from employee
where (sex='F' and birthday >'1970-01-01') or salary>80000;

-- Find all employees named Jim, Michael, Johnny or David
select *
from employee
where first_name in ('Jim','Michael','Johny','David');

-- Find the number of employees
select count(emp_id)
from employee;

-- Find the average of all employee's salaries
select avg(salary)
from employee;

-- Find out how many males and females there are
select count(sex),sex
from employee
group by sex;

-- Find the total sales of each salesman
select sum(total_sales),emp_id
from works_with
group by emp_id ;

-- Find the total amount of money spent by each client
select sum(total_sales),client_id
from works_with
group by client_id ;

-- Find any clients who are an LLC
select *
from client
where client_name like '%LLC';

-- Find any branch suppliers who are in the label business
select *
from supplier
where sup_name like '%label%';

-- Find any employee born in October
select *
from employee
where birthday like '____-10%';

-- Find a list of employee and branch names
select employee.first_name as Employee_Branch_List
from employee
union
select branch.branch_name 
from branch;

-- Find all branches and their managers
select branch.branch_name, employee.first_name, employee.last_name 
from employee
join branch
on branch.mgr_id =employee.emp_id ;

-- Find the names of all employees who have sold over 50000
select first_name,last_name
from employee
where emp_id in (
	select emp_id
	from works_with
	where total_sales >50000
);

-- Find all clients who are handled by the branch that Michael Scott manages
-- Assume you don´t know Michael's ID
select client_name
from client
where branch_id in (
	select branch_id 
	from branch 
	where mgr_id = (
		select emp_id
		from employee
		where first_name='Michael' and last_name='Scott')
);

-- Find the names of employees who work with clients handled by the Scranton branch
select first_name,last_name
from employee
where emp_id in (
	select emp_id 
	from works_with) 
and branch_id=2;

