use ME;
go
--¼��һλѧ��(ѧ�� ���� �Ա� �������� �༶)
insert into student values( )


--¼����ʦ���༶�ڿε������
insert into TCKclass(tno,cno,kno) valuse( A,B , C) --A,B,CΪ�����Ӧ�ļ�¼





--��ѧ�Ų�ѯѧ���Ļ�����Ϣ
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where student.sno = '03051001' and student.cno = class.cno  --userΪ����ѧ��  



--��������ѯѧ���Ļ�����Ϣ
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where student.sname = '���޷�' and student.cno = class.cno --userΪ�������� 


--��רҵ��ѯѧ���Ļ�����Ϣ
select student.sno ,student.cno,student.sbirth,student.sname,student.ssex,class.mno from
student,class
where class.mno = 'IS' and student.cno = class.cno --userΪ�����רҵ 





--¼��һλѧ���ĳɼ�(ѧ�� �γ̺� ����)
insert into sc values()



--@_@Ϊ����(1) (2) (3) (4) ����Ĺ�����(�ɲ��ѧ����רҵ�ƻ���)
--רҵ�ƻ���
  select * into theplan  from plan1  where plan1.mno =
  (
  select mno from class where class.cno =
  (select cno from student  where student.sno = '03051001')  --USERΪѧ��ѧ��
  )
 


--��1����ѯһλѧ����ǰѧ�ڵģ���ѡ�γ̣��γ����ʣ�ѧ��,ѧ�֣��ɼ�)��ѧ������Ϊ1 2 3...(��ư�ѧ�ż�ѧ�ڲ�)
select sc.kno,theplan.type,theplan.time,course.ccride,sc.score 
from sc,theplan,course 
 where sc.kno = theplan.kno and sc.kno = course.kno and theplan.time  = 1 and sc.sno = '03051001' --userΪѧ������ĵ�ǰѧ��
drop table theplan


--��2����ѯһλѧ��ֱ����ѧ�ڵģ���ѡ�γ̣��γ����ʣ�ѧ��,ѧ�֣��ɼ�)ѧ������Ϊ1 2 3...(��ư�ѧ�ż�ѧ�ڲ�)
select sc.kno,theplan.type,theplan.time,course.ccride,sc.score 
from sc,theplan,course 
 where sc.kno = theplan.kno and sc.kno = course.kno and theplan.time  <= 2 and sc.sno = '03051001' --userΪѧ������ĵ�ǰѧ��
drop table theplan




--��ѯһλѧ������Щ��ʦ�̹�(ѡ������ΪѧԺ��ѡ)
select TCKlass.tno,TCKlass.kno from TCKlass where 
TCKlass.cno = (select cno from student where student.sno = '03051001') and TCKlass.kno in
(select kno from sc where sc.sno = '03051001')  -- userΪ�����ѧ��ѧ��



--(3)��ѯ���ı��޿ε�ƽ���ɼ�
select SUM(sc.score*course.ccride)/ SUM(ccride) 
from sc,theplan,course 
where sc.sno = '03051001'--userΪ�������ѧ��
and sc.kno = course.kno and theplan.kno = sc.kno and theplan.type ='����'
drop table theplan



--(4)��ѯ����ȫ���ε�ƽ���ɼ�
select SUM(sc.score*course.ccride)/ SUM(ccride) 
from sc,course,theplan 
where sc.sno = '03051001' --userΪ�������ѧ��
and sc.kno = course.kno and theplan.kno = sc.kno 
drop table theplan


--@@
--��ѯ������δ����ѧ��
--��ѯδ����ѧ����03051040��
select sc.sno,sum(ccride) as bxiuundabiao into a
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = 
(select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)
) and plan1.kno = sc.kno and sc.score < 60 and sc.bktime = 0 
and plan1.type = '����'
group by sc.sno having sum(ccride)  >=15
 select *from a

--(��֤03051040��ȫ��������γ����)
--select sc.kno,sc.score,course.ccride from sc,course where sc.kno = course.kno and sc.sno = '03051040'  and score < 60--27
 
--(03051041)
select sc.sno,sum(ccride) as xxiuundaiao  into b
from sc,course,plan1
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno))and plan1.kno = sc.kno
 and sc.score < 60 and sc.bktime = 0  and plan1.type = 'ѡ��'
group by sc.sno having sum(ccride) >=20
select*from b
--
--select SC.kno ,SC.score,course .ccride FROM  sc,course  where SC.kno = course.kno AND SC.sno = '03051041' and score < 60 

--select * from a full join b on a.sno = b.snoȫ����



--����δ���ѧ��

delect cascade from student where student.sno in (select a.sno from a) or  student.sno in (select b.sno from b)
drop table a
drop table b



--��ѯ��Ҫ������ѧ����03051043��

select sc.sno,sum(ccride) as bxiuundabiao 
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)) and sc.score < 60 and sc.bktime = 0 
and plan1.kno = sc.kno and plan1.type = '����'
group by sc.sno having 15>=sum(ccride) AND sum(ccride) >=12


(03051045)
select sc.sno,sum(ccride) as xxiuundaiao
from sc,course,plan1 
where sc.kno = course.kno and plan1.mno = (select mno from class where class.cno = 
(select cno from student where student.sno = sc.sno)) and sc.score < 60 and sc.bktime = 0 
and plan1.kno = sc.kno and plan1.type = 'ѡ��'
group by sc.sno having 20>=sum(ccride)AND   sum(ccride)>=17

