-- code oracle plsql
-- question 5

create table alunos(
id    number(3),
nome  varchar2(100),
valor number(3)
);

insert into alunos(id,nome,valor) values(1,'Julia',81);
insert into alunos(id,nome,valor) values(2,'Carol',68);
insert into alunos(id,nome,valor) values(3,'Maria',99);
insert into alunos(id,nome,valor) values(4,'Andreia',78);
insert into alunos(id,nome,valor) values(5,'Jaqueline',63);
insert into alunos(id,nome,valor) values(6,'Marcela',88);

create table notas(
nota    number(2),
val_min number(3),
val_max number(3)
);

insert into notas(nota,val_min,val_max) values(1,0,9);
insert into notas(nota,val_min,val_max) values(2,10,19);
insert into notas(nota,val_min,val_max) values(3,20,29);
insert into notas(nota,val_min,val_max) values(4,30,39);
insert into notas(nota,val_min,val_max) values(5,40,49);
insert into notas(nota,val_min,val_max) values(6,50,59);
insert into notas(nota,val_min,val_max) values(7,60,69);
insert into notas(nota,val_min,val_max) values(8,70,79);
insert into notas(nota,val_min,val_max) values(9,80,89);
insert into notas(nota,val_min,val_max) values(10,90,99);

-- query de resolucao
select case when n.nota < 8 then 'NULL' else a.nome end nome,n.nota,a.valor
from alunos a,notas n
where a.valor between n.val_min and n.val_max
order by n.nota desc,
         case when n.nota >= 8 then a.nome  end,
         case when n.nota <  8 then a.valor end;
