# Имеем 3 таблицы, называемые tables, years и codes.
# Необходимо сделать запрос, который возвращает import для каждого года и для каждого кода, 
# содержащегося в следующих таблицах (return import = 0, где нет записи для определённой комбинации года и кода).
# Имея 6 codes и 5 years, ожидается 30 записей (по одной для каждой комбинации года и кода) вместе с соответствующим значением import.

CREATE TABLE tables 
(year int, 
code int, 
import float(5,2));
insert into tables values
(2019,390107,10.30),
(2021,390107,175.10),
(2022,390107,102.50),
(2022,470101,101.00),
(2022,53015101,140.90);

CREATE TABLE years (year int);
insert into years values
(2018),
(2019),
(2020),
(2021),
(2022);

CREATE TABLE codes (code int);
insert into codes values
(390107),
(470101),
(470103),
(471103),
(53010101),
(53015101);

SELECT years.year, codes.code,  IFNULL(import,0) as import FROM years
CROSS JOIN codes
LEFT JOIN tables
ON (years.year = tables.year AND codes.code = tables.code)
ORDER BY year, code