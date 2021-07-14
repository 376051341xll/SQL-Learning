#进阶3 排序查询
#引入
/*
语法 SELECT 查询列表 FROM 表 【where 查询条件】 order by 排序列表 【asc | desc】;
特点：
     1.asc表示升序，desc表示降序；如果不写，默认升序
     2.order by子句中可以支持单个字段、多个字段、表达式、函数、别名
     3.order by子句一般是放在查询语句最后面，limit子句除外
*/

#案例1 查询员工信息，要求工资从高到低排序
SELECT * FROM employees ORDER BY salary DESC;

#案例2 查询部门编号大于等于90的员工信息，按照入职时间先后顺序排序【添加筛选条件】
SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate ASC;

#案例3 按年薪的高低显示员工信息和年薪【按表达式排序】
SELECT *, salary * 12 *(1+ IFNULL(`commission_pct`,0))  年薪 FROM employees ORDER BY  salary * 12 *(1+ IFNULL(`commission_pct`,0)) DESC;

#案例4 按年薪的高低显示员工信息和年薪【按别名排序】
SELECT *, salary * 12 *(1+ IFNULL(`commission_pct`,0))  年薪 FROM employees ORDER BY  年薪 DESC;

#案例5 按姓名的长度显示员工的姓名和工资【按函数排序】
SELECT LENGTH(last_name) 字节长度 , salary FROM employees ORDER BY 字节长度 DESC;

#案例6 查询员工信息，要求先按工资排序，再按员工编号排序【按多个字段排序】
SELECT * FROM employees ORDER BY salary ASC, employee_id DESC;

SELECT `last_name`,`department_id`,salary*12*(1+IFNULL(`commission_pct`,0)) 年薪 FROM employees ORDER BY 年薪 DESC , last_name ASC;

SELECT last_name, salary FROM employees WHERE salary NOT BETWEEN 8000 AND 17000 ORDER BY salary DESC;

SELECT *, LENGTH(email) FROM employees WHERE email LIKE "%e%" ORDER BY LENGTH(email) DESC, department_id ASC;





