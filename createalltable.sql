create database ME;
go

use ME;
create table major--创建专业表
 (
  mno   char(8) primary key,
  mname varchar(8)not null 
 )

create table class--创建班级
 (
 cno     char(8) primary key,
 cnumber int not null ,
 mno char(8) references major(mno) not null
 )
create table student--创建学生表
(
 sno    char(8) primary key,
 sname  varchar(20)not null,
 ssex   char(4) check(ssex in('男','女')),
 sbirth date check(sbirth > '1990-1-1'),--学生年龄不大于26岁
 cno    char(8) references class(cno)
 )
 
 create table teacher--创建老师表
 (
  tno    char(8) primary key,
  tname  varchar(8)not null,
  tsex   char(4) check(tsex in('男','女')),
  tbirth date check(tbirth > '1956-1-1')--老师年龄小于60岁
 )
 
 create table course--创建课程表 
 (
 kno    char(9) primary key,
 cname  varchar(50)not null,
 ccride int
 )
 
 create table TCKlass--创建老师.班级.课程表
 (
 tno char(8) references teacher(tno),
 cno char(8) references class(cno),
 kno  char(9) references course(kno),
 unique(cno,kno),
 primary key(tno,cno)
 )

 create table sc--创建选课表
 (
 sno    char(8) references student(sno),
 kno    char(9) references course(kno),
 score  int not null check(score between 0 and 100),
 bktime int
 )
 

create table plan1--创建专业计划表
(
mno  char(8) references major(mno),
kno  char(9) references course(kno),
type varchar(10),
time int,
cishu int
primary key(mno,kno)
)

create index my_score on sc(score)
