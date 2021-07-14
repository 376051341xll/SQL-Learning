#进阶6 连接查询
/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询

笛卡尔乘积现象：表1 有m行， 表2有n行，结果=m*n行

发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
     按年代分类：sql192标准（仅仅支持内连接），sql199标准【推荐】（支内连接，左外连接，右外连接，交叉连接）
     按功能分类：内连接--等值连接、非等值连接、自连接
                 外连接--左外连接，右外连接，全外连接
                 交叉连接

*/
SELECT * FROM beauty;
SELECT * FROM boys;

#错误 笛卡尔乘积现象
SELECT NAME, boyname FROM boys, beauty;



#一、sql92标准
/*
1.多表等值连接的结果为多表的交集部分
2.n表连接，至少需要n-1个连接条件
3.多表的顺序没有要求
4.一般需要为表起别名
5.可以搭配前面介绍的所有子句使用
*/
#案例1 查询女神名和对应的男神名
SELECT NAME, boyname FROM boys, beauty WHERE beauty.`boyfriend_id` = boys.id;

#案例2 查询员工名对应的部门名
SELECT last_name, `department_name` FROM `employees`, `departments` 
WHERE `employees`.`department_id`=`departments`.`department_id`;


#2.为表起别名  --提高语句的简洁度，区分多个重名的字段；如果为表起了别名，查询字段就不能再使用原名

#查询员工名、公众号、工种名
SELECT last_name, e.`job_id`, `job_title` FROM `employees` e,`jobs` j
WHERE e.`job_id`=j.`job_id`;

#3.表的顺序是否可以交换

#查询员工名、公众号、工种名
SELECT last_name, e.`job_id`, `job_title` FROM `employees` e,`jobs` j
WHERE e.`job_id`=j.`job_id`;

#4.可以加筛选？
#案例：查询有奖金的员工名，部门名
SELECT last_name, `department_name`,`commission_pct`
FROM `departments` d,`employees` e
WHERE d.`department_id` = e.`department_id`
AND e.`commission_pct` IS NOT NULL;

#案例2 查询城市名中第二个字符为o的部门名和城市名
SELECT `department_name`,`city`
FROM `locations` l, `departments` d
WHERE l.`location_id` = d.`location_id`
AND city LIKE '%o%';

#5.可以加分组
#案例1 查询每个城市的部门个数
SELECT COUNT(*) 个数,city, l.`location_id`
FROM `departments` d, `locations` l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;

#案例2 查询出有奖金的每个部门名和部门领导编号和该部门的最低工资
SELECT `department_name`,d.`manager_id`, MIN(salary),`commission_pct`
FROM `departments` d,`employees` e
WHERE d.`department_id`=e.`department_id`
AND `commission_pct` IS NOT NULL
GROUP BY d.`department_name`,d.`manager_id`;

#6.可以加排序
#案例：查询每个工种名和员工的个数，并且按员工的个数降序
SELECT `job_title`,COUNT(*)
FROM `jobs`,`employees`
WHERE `jobs`.`job_id` = `employees`.`job_id`
GROUP BY `job_title`
ORDER BY COUNT(*) DESC;


#7.实现三表连接
#案例：查询员工名、部门名和所在的城市

SELECT last_name, `department_name`,`city`
FROM `employees` e,`departments` d ,`locations` l
WHERE d.`location_id`=l.`location_id`
AND e.`department_id`=d.`department_id`
AND city LIKE 's%';

#二、非等值连接

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

#案例1：查询员工的工资和工资级别
SELECT salary, `grade_level`
FROM `employees` e,`job_grades` j
WHERE salary BETWEEN j.`lowest_sal` AND `highest_sal`
AND j.`grade_level` = 'A';

SELECT * FROM `job_grades`;

#三、自连接
#案例：查询 员工名和上级名
SELECT e.`employee_id`,e.`last_name`,m.`employee_id`,m.`last_name`
FROM `employees` e, `employees` m
WHERE e.`manager_id` = m.`employee_id`;

SELECT MAX(salary), AVG(salary) FROM employees;

SELECT `employee_id`, `job_id`, `last_name`
FROM `employees`
ORDER BY `department_id` DESC, `salary`ASC;

SELECT job_id
FROM `employees`
WHERE job_id LIKE '%a%e%';

/*
二、sql99语法
   select 查询列表 
   from 表1 别名 【连接类型】
   join 表2 别名
   on 连接条件
   【where 筛选条件】
   【group by 分组】
   【having 筛选条件】
   【order by 排序列表】
分类：
 内连接：inner
 外连接：
   左外：left【outer】
   右外：right【outer】
   全外：full【outer】
交叉连接：cross
*/

#内连接
/*
语法
select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件；

分类：
等值
非等值
自连接

特点：
1.添加排序、分组、筛选
2.inner可以省略
3.筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
4.inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集
*/

#1.等值连接
#案例1 查询员工名、部门名（调换位置）
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.`employee_id`=d.`department_id`;

#案例2 查询名字中包含e的员工名和工种名
SELECT last_name, job_title
FROM `employees` e
INNER JOIN `jobs` j
ON e.job_id = j.job_id;
WHERE e.last_name LIKE '%e%';


#案例3 查询部门个数>3的城市市名和部门个数，（分组+筛选）
SELECT city, COUNT(*) 部门个数
FROM `departments` d
INNER JOIN `locations` l
ON d.`location_id` = l.`location_id`
GROUP BY city
HAVING COUNT(*) > 3;


#案例4 查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序（排序）
SELECT `department_name`, COUNT(*)
FROM `departments` d
INNER JOIN `employees` e
ON d.`department_id` = e.`department_id`
GROUP BY `department_name`
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;


#案例5 查询员工名、部门名、工种名，并按部门名降序
SELECT `last_name`, `department_name`, `job_title`
FROM `departments` d
INNER JOIN `employees` e ON d.`department_id`= e.`department_id`
INNER JOIN `jobs` j ON e.`job_id` = j.`job_id`
ORDER BY department_name DESC;

#二、非等值连接

#查询员工的等级级别
SELECT salary,`grade_level`
FROM `employees` e
INNER JOIN `job_grades` j
ON e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;

#查询每个工资级别的个数>20,并且进行降序排序
SELECT COUNT(*),`grade_level`
FROM `employees` e
INNER JOIN `job_grades` j
ON e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`
GROUP BY `grade_level`
HAVING COUNT(*) > 20
ORDER BY `grade_level` DESC;


#三、自连接

#查询员工的名字，上级的名字
SELECT e.last_name, m.last_name
FROM `employees` e
JOIN `employees` m
ON e.`manager_id` = m.`employee_id`;


#外连接
/*
应用场景：用于查询一个表中有，另一个表中没有的记录
特点：
  1.外连接的查询结果为主表中的所有记录
    如果从表中有和他匹配的，则显示匹配的值
    如果从表中没有匹配的，则显示null
    外连接查询结果=内连接结果+主表中有而从表中没有的记录
  2.左外连接，left左边的是主表
    右外连接，right右边的是主表
  3.左外和右外交换两个表的顺序，可以实现同样的效果
  4.全外连接 = 内连接的结果 + 表1中有单表2中没有的 + 表2中有单表1中没有的
*/
#引入：查询没有男朋友的女神
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT b.`name`, bo.boyName
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NOT NULL;

#案例1 查询哪个部门没有员工
SELECT d.`department_name`
FROM `departments` d
LEFT OUTER JOIN `employees` e
ON d.`department_id` = e.`employee_id`
WHERE e.`employee_id` IS NULL;

SELECT d.`department_name`
FROM `employees` e
RIGHT OUTER JOIN `departments` d
ON d.`department_id` = e.`employee_id`
WHERE e.`employee_id` IS NULL;

#全外连接

SELECT b.*, bo.*
FROM beauty b
FULL OUTER JOIN boys bo
ON b.boysfriend_id = bo.id;

#交叉连接
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;

#SQL92和sql99pk
/*
功能：sql99支持的较多
可读性：SQL99实现连接条件和筛选条件分离，可读性高
*/

SELECT bo.*
FROM boys bo
LEFT OUTER JOIN beauty b
ON bo.id = b.boyfriend_id
WHERE b.id > 3;

SELECT l.city
FROM locations l
LEFT OUTER JOIN `departments` d
ON l.`location_id`=d.`location_id`
WHERE d.`department_id` IS NULL;

SELECT e.`employee_id`,d.`department_name`
FROM `employees` e
LEFT OUTER JOIN `departments` d
ON e.`department_id`=d.`department_id`
WHERE `department_name` IN ('SAL','IT');






