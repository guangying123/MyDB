use ME;
go
--录入一位学生(学号 姓名 性别 出生年月 班级)
insert into student values( )


--录入老师给班级授课的情况表
insert into TCKclass(tno,cno,kno) valuse( A,B , C) --A,B,C为输入对应的记录





--按学号查询学生的基本信息
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where student.sno = '03051001' and student.cno = class.cno  --user为输入学号  



--按姓名查询学生的基本信息
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where student.sname = '许艳芳' and student.cno = class.cno --user为输入姓名 


--按专业查询学生的基本信息
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where class.mno = 'IS' and student.cno = class.cno --user为输入的专业 





--录入一位学生的成绩(学号 课程号 分数)
insert into sc values()



--@_@为下面(1) (2) (3) (4) 所需的公共表(可查出学生的专业计划表)
--专业计划表
  select * into theplan  from plan1  where plan1.mno =
  (
  select mno from class where class.cno =
  (select cno from student  where student.sno = '03051001')  --USER为学生学号
  )
 


--（1）查询一位学生当前学期的（所选课程，课程性质，学期,学分，成绩)，学期形如为1 2 3...(设计按学号及学期查)
select sc.kno,theplan.type,theplan.time,course.ccride,sc.score 
from sc,theplan,course 
 where sc.kno = theplan.kno and sc.kno = course.kno and theplan.time  = 1 and sc.sno = '03051001' --user为学生输入的当前学期
drop table theplan


--（2）查询一位学生直到该学期的（所选课程，课程性质，学期,学分，成绩)学期形如为1 2 3...(设计按学号及学期查)
select sc.kno,theplan.type,theplan.time,course.ccride,sc.score 
from sc,theplan,course 
 where sc.kno = theplan.kno and sc.kno = course.kno and theplan.time  <= 2 and sc.sno = '03051001' --user为学生输入的当前学期
drop table theplan




--查询一位学生被那些老师教过(选修体现为学院任选)
select TCKlass.tno,TCKlass.kno from TCKlass where 
TCKlass.cno = (select cno from student where student.sno = '03051001') and TCKlass.kno in
(select kno from sc where sc.sno = '03051001')  -- user为输入的学生学号



--(3)查询他的必修课的平均成绩
select SUM(sc.score*course.ccride)/ SUM(ccride) 
from sc,theplan,course 
where sc.sno = '03051001'--user为你输入的学号
and sc.kno = course.kno and theplan.kno = sc.kno and theplan.type ='必修'
drop table theplan



--(4)查询他的全部课的平均成绩
select SUM(sc.score*course.ccride)/ SUM(ccride) 
from sc,course,theplan 
where sc.sno = '03051001' --user为你输入的学号
and sc.kno = course.kno and theplan.kno = sc.kno 
drop table theplan


--@@
--查询并开除未达标的学生
--查询未达标的学生（03051040）
select sc.sno,sum(ccride) as bxiuundabiao into a
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = 
(select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)
) and plan1.kno = sc.kno and sc.score < 60 and sc.bktime = 0 
and plan1.type = '必修'
group by sc.sno having sum(ccride)  >=15
 select *from a

--(验证03051040的全部不及格课程情况)
--select sc.kno,sc.score,course.ccride from sc,course where sc.kno = course.kno and sc.sno = '03051040'  and score < 60--27
 
--(03051041)
select sc.sno,sum(ccride) as xxiuundaiao  into b
from sc,course,plan1
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno))and plan1.kno = sc.kno
 and sc.score < 60 and sc.bktime = 0  and plan1.type = '选修'
group by sc.sno having sum(ccride) >=20
select*from b
--
--select SC.kno ,SC.score,course .ccride FROM  sc,course  where SC.kno = course.kno AND SC.sno = '03051041' and score < 60 

--select * from a full join b on a.sno = b.sno全连接



--开除未达标学生

delect cascade from student where student.sno in (select a.sno from a) or  student.sno in (select b.sno from b)
drop table a
drop table b



--查询快要开除的学生（03051043）

select sc.sno,sum(ccride) as bxiuundabiao 
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)) and sc.score < 60 and sc.bktime = 0 
and plan1.kno = sc.kno and plan1.type = '必修'
group by sc.sno having 15>=sum(ccride) AND sum(ccride) >=12


(03051045)
select sc.sno,sum(ccride) as xxiuundaiao
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)) and sc.score < 60 and sc.bktime = 0 
and plan1.kno = sc.kno and plan1.type = '选修'
group by sc.sno having 20>=sum(ccride)AND   sum(ccride)>=17

