# Имеем таблицу с данными о ценах продажи товаров за разные даты
# Необходимо посчитать дату начала и окончания действия цены на определенный товар 

create table sales(
 item int,
 date date,
 price int
);

insert into sales(item, date, price) 
values
(1,'2023-05-01', 200),
(1,'2023-06-11', 210),
(1,'2023-06-27', 225),
(1,'2023-08-01', 250),
(2,'2023-02-10', 600),
(2,'2023-04-21', 650),
(2,'2023-06-17', 675),
(2,'2023-07-23', 700);

SELECT item, date AS Date_Start, price, 
       IFNULL(lead(date,1) OVER w, CURRENT_DATE()) as Date_END
FROM sales
WINDOW w AS (PARTITION BY item
             ORDER BY date
)