--1. Таблица employees
--Создать таблицу employees
--- id. serial,  primary key,
--- employee_name. Varchar(50), not null
--Наполнить таблицу employee 70 строками.
--Наполнение таблицы через Pyhton
CREATE TABLE employees(
	id serial PRIMARY KEY,
	employee_name varchar(50) not null
);
SELECT * FROM employees; 

--2. Таблица salary
--Создать таблицу salary
--- id. Serial  primary key,
--- monthly_salary. Int, not null
--Наполнить таблицу salary 15 строками
--Наполнение таблицы через Pyhton
CREATE TABLE salary(
	id serial PRIMARY KEY,
	monthly_salary int NOT NULL
);
SELECT * FROM salary;	

--3. Таблица employee_salary
--Создать таблицу employee_salary
--- id. Serial  primary key,
--- employee_id. Int, not null, unique
--- salary_id. Int, not null
--Наполнить таблицу employee_salary 40 строками:
--- в 10 строк из 40 вставить несуществующие employee_id
CREATE TABLE employee_salary(
	id serial  primary key,
	employee_id Int not null UNIQUE,
	salary_id Int not NULL)
	
INSERT INTO employee_salary(employee_id, salary_id)
values (3,7),
(1,4),
(5,9),
(40,13),
(23,4),
(11,2),
(52,10),
(15,13),
(26,4),
(16,1),
(33,7),
(2,4),
(6,5),
(4,6),
(7,7),
(8,8),
(9,9),
(10,4),
(12,15),
(13,14),
(14,1),
(17,2),
(18,3),
(19,4),
(20,5),
(21,6),
(22,7),
(24,8),
(25,9),
(27,10),
(80,11),
(79,10),
(78,1),
(71,4),
(72,5),
(73,6),
(74,7),
(75,8),
(76,4),
(77,17);
SELECT * FROM employee_salary;

--4. Таблица roles
--Создать таблицу roles
--- id. Serial  primary key,
--- role_name. int, not null, unique
--Поменять тип столба role_name с int на varchar(30)
--Наполнить таблицу roles 20 строками:

CREATE TABLE roles(
	id serial PRIMARY KEY,
	role_name int NOT NULL UNIQUE);
ALTER TABLE roles 
ALTER COLUMN role_name TYPE varchar(30);

INSERT INTO roles(role_name)
VALUES ('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');
SELECT * FROM roles;

--5. Таблица roles_employee
--Создать таблицу roles_employee
--- id. Serial  primary key,
--- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
--- role_id. Int, not null (внешний ключ для таблицы roles, поле id)
--Наполнить таблицу roles_employee 40 строками:
CREATE TABLE roles_employee(
	id serial  primary KEY,
	employee_id Int not null UNIQUE,
	role_id Int not NULL
	FOREIGN KEY (employee_id)
		REFERENCES employees(id),
	FOREIGN KEY (role_id)
		REFERENCES roles(id)
);
INSERT INTO roles_employee(employee_id,role_id)
VALUES (7,2),
		(20,4),
		(3,9),
		(5,13),
		(23,4),
		(11,2),
		(10,9),
		(22,13),
		(21,3),
		(34,4),
		(6,7),
		(35,1),
		(36,2),
		(37,3),
		(38,4),
		(39,5),
		(40,1),
		(41,1),
		(42,6),
		(43,7),
		(44,8),
		(45,9),
		(46,10),
		(47,11),
		(48,12),
		(49,13),
		(50,14),
		(51,15),
		(52,16),
		(53,17),
		(54,18),
		(55,19),
		(56,20),
		(57,19),
		(58,18),
		(59,17),
		(60,16),
		(61,15),
		(62,14),
		(63,13);
SELECT * FROM roles_employee;


-- JOIN HW3

--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
SELECT employee_name, monthly_salary 
FROM employee_salary 
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON employee_salary.employee_id = employees.id;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
SELECT employee_name, monthly_salary 
FROM employee_salary 
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON employee_salary.employee_id = employees.id
WHERE monthly_salary < 2000;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
SELECT employee_name, monthly_salary 
FROM employee_salary 
JOIN salary ON employee_salary.salary_id = salary.id
LEFT JOIN employees ON employee_salary.employee_id = employees.id;
WHERE employee_name is NULL;

-- 4. Вывести все зарплатные позиции  меньше 2000, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
SELECT employee_name, monthly_salary 
FROM employee_salary 
JOIN salary ON employee_salary.salary_id = salary.id
LEFT JOIN employees ON employee_salary.employee_id = employees.id
WHERE employee_name is NULL AND monthly_salary < 2000;

-- 5. Найти всех работников кому не начислена ЗП.
SELECT employee_name, monthly_salary 
FROM employee_salary 
JOIN salary ON employee_salary.salary_id = salary.id
RIGHT JOIN employees ON employee_salary.employee_id = employees.id
WHERE monthly_salary IS NULL;

-- 6. Вывести всех работников с названиями их должности
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id;

-- 7. Вывести имена и должность только Java разработчиков.
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Java_d%';

-- 8. Вывести имена и должность только Python разработчиков.
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Python%';

-- 9. Вывести имена и должность всех QA инженеров.
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%QA engineer%';

-- 10. Вывести имена и должность ручных QA инженеров.
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Manual QA engineer%';

-- 11. Вывести имена и должность автоматизаторов QA
SELECT employee_name, role_name
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Automation QA engineer%';

-- 12. Вывести имена и зарплаты Junior специалистов
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Junior%';

-- 13. Вывести имена и зарплаты Middle специалистов
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Middle%';
--
-- 14. Вывести имена и зарплаты Senior специалистов
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Senior%';

-- 15. Вывести зарплаты Java разработчиков
SELECT salary.monthly_salary, roles.role_name
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Java_d%';

-- 16. Вывести зарплаты Python разработчиков
SELECT salary.monthly_salary, roles.role_name
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name like '%Python%';

-- 17. Вывести имена и зарплаты Junior Python разработчиков
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Junior_Python%';

-- 18. Вывести имена и зарплаты Middle JS разработчиков
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Middle_JavaScript%';

-- 19. Вывести имена и зарплаты Senior Java разработчиков
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Senior_Java_d%';

-- 20. Вывести зарплаты Junior QA инженеров
SELECT salary.monthly_salary, roles.role_name
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Junior%QA_engineer%';

-- 21. Вывести среднюю зарплату всех Junior специалистов
SELECT avg (salary.monthly_salary)
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Junior%';

-- 22. Вывести сумму зарплат JS разработчиков
SELECT sum (salary.monthly_salary)
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%JavaScrip%';

-- 23. Вывести минимальную ЗП QA инженеров
SELECT min (salary.monthly_salary)
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%QA_engineer%';

-- 24. Вывести максимальную ЗП QA инженеров
SELECT max (salary.monthly_salary)
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%QA_engineer%';

-- 25. Вывести количество QA инженеров
SELECT count (roles.role_name)
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%QA_engineer%';

-- 26. Вывести количество Middle специалистов.
SELECT count (roles.role_name)
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%Middle%';

-- 27. Вывести количество разработчиков
SELECT count (roles.role_name)
FROM roles_employee 
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%developer%'

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
SELECT sum (salary.monthly_salary)
FROM roles_employee
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE role_name LIKE '%developer%';

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
ORDER by monthly_salary ASC;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE monthly_salary BETWEEN 1700 AND 2300 
ORDER by monthly_salary ASC;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE monthly_salary < 2300 
ORDER by monthly_salary ASC;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
SELECT employees.employee_name, salary.monthly_salary, roles.role_name
FROM roles_employee 
JOIN employee_salary ON roles_employee.employee_id = employee_salary.employee_id
JOIN salary ON employee_salary.salary_id = salary.id
JOIN employees ON roles_employee.employee_id = employees.id
JOIN roles ON roles_employee.role_id = roles.id
WHERE monthly_salary IN  ('1100', '1500', '2000')
ORDER by monthly_salary ASC;



