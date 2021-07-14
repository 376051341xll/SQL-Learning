#进阶4 常见函数
/*
功能：类似于java的方法，将一组逻辑语句封装在方法中，对外暴露方法名

好处：1.隐藏了实现细节 2.提高代码的重用性

调用：select 函数名 （实例参数） 【from 表】；

特点：1.叫什么（函数名） 2.干什么（函数功能）

分类：1.单行函数（如 contact， length， ifnull）  2.分组函数（做统计使用）
*/

#一、字符函数
#1.length
SELECT LENGTH("join");
SELECT LENGTH("张三丰");
SHOW VARIABLES LIKE '%char&=%';

#2.concat 拼接字符
SELECT CONCAT(last_name, '_', first_name) FROM employees;

#3.upper lower
SELECT UPPER("join");
SELECT LOWER("JOIN");
#案例：把姓大写，名小写，然后拼接
SELECT CONCAT (UPPER(last_name), '_', LOWER(first_name)) FROM employees;

#4.substr, substring 截取字符串, 索引从1开始
SELECT SUBSTR('李莫愁爱上了陆展元', 7) output;
SELECT SUBSTR('李莫愁爱上了陆展元', 1, 3 ) output;

#案例 将姓名中首字符大写，其他字符小写，用_拼接，显示出来
SELECT CONCAT( UPPER(SUBSTR(last_name,1,1)) , SUBSTR(last_name, 2),'_', LOWER(first_name)) output FROM employees;

#5.instr 返回子串在字符串中的起始索引
SELECT INSTR('杨不悔爱上了殷六侠','殷六侠') AS output;

#6.trim
SELECT LENGTH(TRIM('   张翠    ' )) AS output ;
SELECT TRIM('a' FROM 'aaaaaaa张aaaaa翠山aaaaaaa')  output;

#7.Lpad 左填充指定长度
SELECT LPAD('殷素素', 10, '*') AS output;

#8 Rpad 
SELECT RPAD('殷素素',12,'ab') AS output;

#9.replace 替换
SELECT REPLACE('周芷若爱上了张无忌','周芷若', '赵敏') AS output;


#二、数学函数

#round 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.567,2);

#ceil 向上取整,大于等于的最小整数
SELECT CEIL(1.11);

#floor 向下取整数
SELECT FLOOR(-9.99);

#truncate 截断
SELECT TRUNCATE(1.69999,1);

#mod 取余
SELECT MOD(10,3);

#三、日期函数

#now 返回当前系统日期+时间
SELECT NOW();

#curtime 返回当前时间，不包含日期
SELECT CURTIME();

#可以获取指定的部分，年、月、日
SELECT YEAR(NOW()) 年;
SELECT YEAR ('1998-1-1') 年;
SELECT MONTHNAME(`hiredate`) 月 FROM employees;

#str_to_date 将日期格式的字符转换成指定格式的日期
SELECT STR_TO_DATE('1998-3-2','%Y-%c-%d') AS output;

#查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE `hiredate` = '1992-4-3';

#data_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(), '%y年%m月%d日') AS output;

#查询有将近的员工名和入职日期
SELECT last_name, DATE_FORMAT(`hiredate`, '%m月%d日/ %y年') 入职日期 FROM employees WHERE `commission_pct` IS NOT NULL;


#四、其他函数

SELECT VERSION();
SELECT DATABASE();
SELECT USER();
SELECT PASSWORD();
SELECT MD5();


#五、流程控制函数

#1. if函数： if else 的效果

SELECT IF(10>5 , '大', '小');

SELECT last_name, `commission_pct` ,IF(`commission_pct` IS NULL, '呵呵', '嘻嘻') 备注 FROM employees;

#2. case函数的使用一：switch case的效果
/*
switch(变量或表达式)
      case 常量1： ;break
      .....
*/

#案例：查询员工的工资，要求
/*
部门号=30，显示工资为1.1
部门号=40，显示工资为1.2
*/

SELECT salary 原始工资, department_id ,
      CASE `department_id`
      WHEN 30 THEN salary*1.1
      WHEN 40 THEN salary*1.2
      WHEN 50 THEN salary*1.3
      ELSE salary
      END AS 新工资
      FROM employees;


#3.case 函数使用二，类似于多重if
/*
如果工资》20000，显示a级别
*/

SELECT salary, 
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS '工资级别'
FROM employees;


SELECT NOW();













