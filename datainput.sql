--����ѧ����
use ME
go
insert into student(sno,sname,ssex)
(
 SELECT  sno,sname,ssex  FROM ѧ��
)

--����γ̱�
insert into course(kno,cname,ccride)
(
 select kno,cname,ccride from �γ�
)

--����ɼ���
insert into sc(sno,kno ,score)
(
 select sno,kno,score from �ɼ�
)

update sc set bktime = 1;--��ʼ������ʱ���Ϊ1
