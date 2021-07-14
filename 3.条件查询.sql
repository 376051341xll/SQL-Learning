#进阶2 条件查询
/*
语法：
     select 查询列表 from 表名 where 筛选条件;

分类:
    一、按条件表达式筛选
    条件运算符 ： > = !=  <> >= <=, 
    二、按逻辑表达式筛选
    逻辑运算符：&& || ！ and or not
    
    && 和 and ：两个条件都为true，结果为true，否则为false;
    
    三、模糊查询 like， between and , is null,
*/
#1.按条件表达式查询
#案例1 查询工资大于12000员工的信息

SELECT * FROM employees WHERE salary > 12000;

#案例2.部门编号不等于90的员工名和部门编号
SELECT last_name,department_id FROM employees WHERE department_id != 90;

#2、按逻辑表达式筛选
#案例1 查询工资在10000到12000之间的员工名、工资以及奖金
SELECT `last_name`,`salary`,`commission_pct` FROM employees WHERE salary >=10000 AND salary <=12000;

#案例2 查询部门编号不是在90到110之间的，或者工资高于150000的员工信息
SELECT * FROM employees WHERE department_id < 90 OR department_id >150 OR salary > 15000;
SELECT * FROM employees WHERE NOT(department_id >=90 AND department_id <=110) OR salary > 15000;

#3.模糊查询 
/*
like 
  特点：一般个通配符搭配只用
  % 任意多个字符，包含0个字符
  _ 任意单个制字符
  \ 转义字符
  ESCAPE 转义
between and 
in 
is null , is not null
*/
#案例1 查询员工名中包含字符a的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%';
#案例2 查询员工名中第三个字符为e，第5个字符为a
SELECT * FROM employees WHERE last_name LIKE '__n_l%';
#案例3 查询员工名中第二个字符为_的员工名
SELECT * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';

#2. between and 
/*
1.可以提高简洁度
2.包含临界值
3.两个临界值不能调换
*/
#案例1 查询员工编号在100到120之间的员工信息
SELECT * FROM employees WHERE `employee_id` BETWEEN 100 AND 120;

#3.in
/*
  含义：用于判断某字段的值是否适于in列表中的某个值
  特点：1.使用in提高语句简洁度；2.in列表的值类型必须统一或箭筒
*/
#案例1 查询员工的工种编号是IT_PROG，AD_VP中的一个员工名和工种编号
SELECT last_name, job_id FROM employees WHERE job_id IN ('IT_PROG', 'AD_VP');

#4.is null
#案例1 查询没有奖金的员工名和奖金率
SELECT last_name, `commission_pct` FROM employees WHERE `commission_pct` IS NULL;
#案例2 查询有奖金的员工名和奖金率
SELECT last_name, `commission_pct` FROM employees WHERE `commission_pct` IS NOT NULL;


#安全等于<=>：判断是否等于
#案例1 查询没有奖金的员工名和奖金率
SELECT last_name, `commission_pct` FROM employees WHERE `commission_pct` <=> NULL;

#案例2 查询没有奖金的员工名和奖金率
SELECT last_name, `salary` FROM employees WHERE salary <=> 12000;


#is null  pk <=>
/*is null : 仅仅可以判断是否是null
<=>: 既可以判断是否是null，又可以判断是否是数值*/



