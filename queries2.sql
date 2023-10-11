# Необходимо написать запрос, который покажет сумму платежей по основному долгу и процентам. 
# Суммы необходимо считать только по тем договорам, которые платили и основной долг и проценты. 
# Результат предоставить в виде: id договора, сумма платежей по основному долгу, сумма платежей по процентам.


create table payments_principal
(
  payment_dt date,
  agr_id int,
  payment_sum int
);


create table payments_interest
(
  payment_dt date,
  agr_id int,
  payment_sum int
);


insert into payments_principal values ('2019-05-11',31,8281);
insert into payments_principal values ('2019-05-12',7,4622);
insert into payments_principal values ('2019-05-13',5,7686);
insert into payments_principal values ('2019-07-01',1,9917);
insert into payments_principal values ('2019-07-23',1,6534);
insert into payments_principal values ('2019-08-20',64,4336);
insert into payments_principal values ('2019-08-24',3,7464);
insert into payments_principal values ('2019-08-25',9,8505);
insert into payments_principal values ('2019-08-27',1,9857);
insert into payments_principal values ('2019-07-07',7,6294);
insert into payments_principal values ('2019-07-17',7,3182);
insert into payments_principal values ('2019-08-28',4,9708);
insert into payments_principal values ('2019-08-29',4,8632);
insert into payments_principal values ('2019-08-30',3,8303);
insert into payments_principal values ('2019-09-01',7,3141);
insert into payments_principal values ('2019-08-25',1,9139);
insert into payments_principal values ('2019-08-25',2,7624);
insert into payments_principal values ('2019-09-01',7,3793);
insert into payments_principal values ('2019-09-01',3,3260);
insert into payments_principal values ('2019-08-21',5,9002);
insert into payments_principal values ('2019-08-22',2,5500);
insert into payments_principal values ('2019-08-23',2,3980);
insert into payments_principal values ('2019-08-29',2,5849);


insert into payments_interest values ('2019-05-11',31,98);
insert into payments_interest values ('2019-05-12',7,90);
insert into payments_interest values ('2019-05-13',5,39);
insert into payments_interest values ('2019-07-01',1,82);
insert into payments_interest values ('2019-07-23',1,59);
insert into payments_interest values ('2019-08-20',50,96);
insert into payments_interest values ('2019-08-24',3,1);
insert into payments_interest values ('2019-08-25',9,22);
insert into payments_interest values ('2019-08-27',1,95);
insert into payments_interest values ('2019-07-07',7,79);
insert into payments_interest values ('2019-07-17',7,72);
insert into payments_interest values ('2019-08-28',4,61);
insert into payments_interest values ('2019-08-29',4,49);
insert into payments_interest values ('2019-08-30',3,78);
insert into payments_interest values ('2019-09-01',7,29);
insert into payments_interest values ('2019-08-25',1,88);
insert into payments_interest values ('2019-08-25',2,77);
insert into payments_interest values ('2019-09-01',6,6);
insert into payments_interest values ('2019-09-01',3,18);
insert into payments_interest values ('2019-08-21',5,15);
insert into payments_interest values ('2019-08-22',2,28);
insert into payments_interest values ('2019-08-23',2,23);
insert into payments_interest values ('2019-08-29',2,84);

WITH cte_agr_id AS (SELECT DISTINCT agr_id FROM payments_principal
WHERE agr_id IN (SELECT agr_id FROM payments_interest)
ORDER BY 1)

SELECT interest.agr_id as agr_id, principal_payment_sum, interest_payment_sum 
FROM (SELECT agr_id, SUM(payment_sum) as interest_payment_sum FROM payments_interest
GROUP BY 1) as interest
INNER JOIN (SELECT agr_id, SUM(payment_sum) as principal_payment_sum FROM payments_principal
GROUP BY 1) as principal 
ON interest.agr_id = principal.agr_id
WHERE interest.agr_id IN (SELECT * FROM cte_agr_id)
