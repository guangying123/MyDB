create database ME;
go

use ME;
create table major--����רҵ��
 (
  mno   char(8) primary key,
  mname varchar(8)not null 
 )

create table class--�����༶
 (
 cno     char(8) primary key,
 cnumber int not null ,
 mno char(8) references major(mno) not null
 )
create table student--����ѧ����
(
 sno    char(8) primary key,
 sname  varchar(20)not null,
 ssex   char(4) check(ssex in('��','Ů')),
 sbirth date check(sbirth > '1990-1-1'),--ѧ�����䲻����26��
 cno    char(8) references class(cno)
 )
 
 create table teacher--������ʦ��
 (
  tno    char(8) primary key,
  tname  varchar(8)not null,
  tsex   char(4) check(tsex in('��','Ů')),
  tbirth date check(tbirth > '1956-1-1')--��ʦ����С��60��
 )
 
 create table course--�����γ̱� 
 (
 kno    char(9) primary key,
 cname  varchar(50)not null,
 ccride int
 )
 
 create table TCKlass--������ʦ.�༶.�γ̱�
 (
 tno char(8) references teacher(tno),
 cno char(8) references class(cno),
 kno  char(9) references course(kno),
 unique(cno,kno),
 primary key(tno,cno)
 )

 create table sc--����ѡ�α�
 (
 sno    char(8) references student(sno),
 kno    char(9) references course(kno),
 score  int not null check(score between 0 and 100),
 bktime int
 )
 

create table plan1--����רҵ�ƻ���
(
mno  char(8) references major(mno),
kno  char(9) references course(kno),
type varchar(10),
time int,
cishu int
primary key(mno,kno)
)

create index my_score on sc(score)
