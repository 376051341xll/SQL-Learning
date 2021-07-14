#分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数

分类：
sum求和、avg平均值、max最大值、min最小值、count计算个数
*/

#1.简单的使用

SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

#2.参数支持哪些类型(需要有实际意义，适用于处理数值型)
SELECT SUM(last_name), AVG(last_name) FROM employees;

#3.是否忽略null 是 

SELECT SUM(`commission_pct`),AVG(`commission_pct`) FROM employees;

#4.和distinct搭配
SELECT SUM(DISTINCT salary) , SUM(salary) FROM employees;
SELECT COUNT(DISTINCT salary), COUNT(salary) FROM employees;

#5.count函数的详细介绍
SELECT COUNT(salary) FROM employees;

SELECT COUNT(*) FROM employees;  # 任何列只要非空都只能被查到，只要有一个不为null都会被统计上的

SELECT COUNT(1) FROM employees; #统计行数

/*
效率问题：
myinsam存储引擎下，count（*）的效率高
innob存储引擎下，count（*）和count（1）的效率差不多，比count（字段）要高一些
一般使用count（*）统计行数
*/

#6.和分组函数一同查询的字段有限制
SELECT AVG(salary), `employee_id` FROM employees;
/*
和分组函数一同查询的字段要求是group by后的字段
*/

SELECT MAX(salary), MIN(salary), ROUND(AVG(salary),2) avg_sal, SUM(salary) FROM employees;
SELECT DATEDIFF(MAX(`hiredate`),MIN(`hiredate`)) diffrence FROM employees;
SELECT  COUNT(*) FROM employees WHERE `department_id`=90;











