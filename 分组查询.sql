#进阶5 分组查询



/*
group by语法
        select 分组函数，列(要求出现在group by的后面)
        from 表
        【where 筛选条件】
        group by 分组的列表
        【order by 子句】
注意：
        要求查询列表必须特殊，要求是分组函数和group by后出现的字段

特点：
        1.分组查询中的筛选条件可以分成两类
                     数据源             位置               关键字
        分组前筛选   原始表           group by子句前面     where
        分组后筛选   分组后的结果集   group by子句后面     having
        
        1.分组函数做条件肯定是放在having子句中
        2.能用分组前筛选的，优先考虑用分组前筛选
        
        2.group by子句支持单个字段分组，也支持多个字段分组（多个字段之间用都好隔开没有顺序要求），表达式或函数（用得较少）
        3.也可以添加排序，也可以放在整个语句后面
*/

#引入：查询每个部门的平均工资
SELECT AVG(salary) FROM employees;

#案例1 查询每个工种的最高工资
SELECT MAX(salary), job_id FROM employees GROUP BY `job_id`;

#案例2 查询每个位置上的部门个数
SELECT COUNT(*) , location_id FROM `departments` GROUP BY `location_id`;

#添加筛选条件  ----分组前的查询
#案例1 查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary), `department_id` FROM employees WHERE email LIKE '%a%' GROUP BY `department_id`;

#案例2 查询有奖金的每个领导手下的最高工资
SELECT MAX(salary) , `manager_id` FROM employees WHERE `commission_pct` IS NOT NULL GROUP BY `manager_id`;

#添加复杂的筛选条件---分组后的查询
#案例1 查询哪个部门的员工个数>2

#1.查询每个部门的员工个数
SELECT COUNT(*),  department_id FROM employees GROUP BY `department_id`;
#2.根据1的结果进行筛选，查询哪个部门的
SELECT COUNT(*) , department_id FROM employees GROUP BY `department_id` HAVING COUNT(*) >2;

#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#1.查询每个工种有奖金的最高工资
SELECT MAX(salary), `job_id` FROM employees WHERE `commission_pct` IS NOT NULL GROUP BY `job_id` HAVING MAX(salary) > 12000;

#案例3 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及其最低工资
SELECT MIN(salary), `manager_id` FROM employees WHERE `manager_id` > 102 GROUP BY `manager_id` HAVING MIN(salary) > 5000;

#按表达式分组

#案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些
SELECT COUNT(*) c ,LENGTH(last_name) len_name
FROM employees 
GROUP BY len_name
HAVING c > 5;

#按多个字段分组
#案例:查询每个部门每个工种的员工的平均工资
SELECT AVG(salary),`department_id`,`job_id` FROM employees GROUP BY `department_id`,`job_id`;

#添加排序
#案例:查询每个部门每个工种的员工的平均工资，并且按平均工资的高低显示
SELECT AVG(salary),`department_id`,`job_id` 
FROM employees 
WHERE `department_id` IS NOT NULL
GROUP BY `department_id`,`job_id` 
ORDER BY AVG(salary) DESC;

SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary), `job_id`
FROM employees
GROUP BY `job_id`
ORDER BY `job_id`;

SELECT MAX(salary)-MIN(salary) difference  FROM employees;

SELECT MIN(salary),`manager_id` 
FROM employees 
WHERE `manager_id` IS NOT NULL 
GROUP BY `manager_id` 
HAVING MIN(salary)>=6000;











