# Имеются две таблицы. Первая с сотрудниками, вторая с задачами сотрудников.
# Необходимо найти имя сотрудника и кол-во его задач, если их кол-во больше трех

create table employee
(
id int PRIMARY KEY,
emp_name varchar(255),
rating int
);

insert into employee values (1,'Vasya',5);
insert into employee values (2,'Vasya',3);
insert into employee values (3,'Petya',9);
insert into employee values (4,'Igor',4);
insert into employee values (5,'Nikita',2);


create table tasks
(
id int,
assignee_id int,
rating int
);

insert into tasks values (1,1,5);
insert into tasks values (2,1,4);
insert into tasks values (3,2,2);
insert into tasks values (4,5,5);
insert into tasks values (5,5,1);
insert into tasks values (6,5,7);
insert into tasks values (7,5,9);
insert into tasks values (8,5,3);
insert into tasks values (9,5,3);
insert into tasks values (10,5,5);
insert into tasks values (11,2,7);
insert into tasks values (12,3,8);
insert into tasks values (13,3,8);
insert into tasks values (14,2,7);
insert into tasks values (15,3,9);
insert into tasks values (16,5,4);
insert into tasks values (17,1,5);



SELECT emp_name, count_tasks FROM employee
INNER JOIN (SELECT assignee_id, count(id) as count_tasks FROM tasks
GROUP BY 1
HAVING count_tasks > 3) as tasks_2
ON employee.id = tasks_2.assignee_id
