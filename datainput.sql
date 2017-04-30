--导入学生表
use ME
go
insert into student(sno,sname,ssex)
(
 SELECT  sno,sname,ssex  FROM 学生
)

--导入课程表
insert into course(kno,cname,ccride)
(
 select kno,cname,ccride from 课程
)

--导入成绩表
insert into sc(sno,kno ,score)
(
 select sno,kno,score from 成绩
)

update sc set bktime = 1;--初始化补考时间均为1
