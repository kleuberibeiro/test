-- code oracle plsql
-- question 11 e 12
-- criar tables, executar inserts, criar sequence, compilar package, executar bloco anonimo

create table om_equipes(
                oid number primary key,
                nome varchar2(100),
                nome_b1 varchar2(100),
                nome_b2 varchar2(100),
                nome_b3 varchar2(100),
                status  number(1)
);

create table om_cab_tarefa(
                oid number primary key,
                nome varchar2(100),
                data_criacao date,
                area varchar2(100),
                equipe_responsavel number
);

create table om_log_proc(
                oid number primary key,
                data date,
                codigo number,
                descricao varchar2(100)
);

insert into om_equipes(oid, nome, nome_b1, nome_b2, nome_b3, status)
values(1,'ALPHA1','MT_07019','13TRF','E08796',0);

insert into om_equipes(oid, nome, nome_b1, nome_b2, nome_b3, status)
values(2,'BETA2','MT_11606','13TRF','E08115',1);

insert into om_equipes(oid, nome, nome_b1, nome_b2, nome_b3, status)
values(3,'BETA1','MT_07901','13TRF','E09516',1);

create sequence seq_om_tarefa;

-- package
create or replace package om_pkg_task is
--
function insere(p_nome varchar2,
                       p_area varchar2) return number;
--
end;
/
create or replace package body om_pkg_task is
--
function insere(p_nome varchar2,
                       p_area varchar2) return number is
--
v_area               varchar2(100);
v_nome_b1            varchar2(100);
v_nome_b2            varchar2(100);
v_nome_b3            varchar2(100);
v_equipe_responsavel number;
v_status             number(1);
v_seq_om_tarefa      number;
v_result             number;
--
begin
  --
  v_area := p_area;
  --
  v_nome_b1 := substr(v_area,1,instr(v_area,'/')-1);
  v_area    := substr(v_area,instr(v_area,'/')+1);
  v_nome_b2 := substr(v_area,1,instr(v_area,'/')-1);
  v_area    := substr(v_area,instr(v_area,'/')+1);
  v_nome_b3 := v_area;
  --
  begin
    select e.oid,e.status into v_equipe_responsavel,v_status
    from om_equipes e
    where e.nome_b1 = v_nome_b1
    and e.nome_b2   = v_nome_b2
    and e.nome_b3   = v_nome_b3;
  exception
    when NO_DATA_FOUND then
      v_equipe_responsavel := 0;
  end;
  --
  if v_equipe_responsavel > 0 and v_status = 1 then
    v_result := 0;
  elsif v_equipe_responsavel = 0 then
    v_result := -1;
  elsif v_equipe_responsavel > 0 and v_status = 0 then
    v_equipe_responsavel := 0;
    v_result := -2;
  end if;
  --
  v_seq_om_tarefa := seq_om_tarefa.nextval;
  --
  insert into om_cab_tarefa(oid,nome,data_criacao,area,equipe_responsavel)
  values(v_seq_om_tarefa,p_nome,sysdate,p_area,v_equipe_responsavel);
  --
  insert into om_log_proc(oid,data,codigo,descricao)
  values(v_seq_om_tarefa,sysdate,v_result,p_nome);
  --
  return v_result;
  --
end;
--
end;
/

-- bloco anonimo de teste
declare
v_result number;
begin
  savepoint salva;
  --
  begin
    v_result := om_pkg_task.insere(p_nome => 'Teste 1',
                                          p_area => 'MT_07019/13TRF/E08796');
    dbms_output.put_line('Teste 1 success result = '||v_result);
    savepoint salva;
  exception
    when others then
      rollback to salva;
  end;
  --
  begin
    v_result := om_pkg_task.insere(p_nome => 'Teste 2',
                                          p_area => 'MT_11606/13TRF/E08115');
    dbms_output.put_line('Teste 2 success result = '||v_result);
    savepoint salva;
  exception
    when others then
      rollback to salva;
  end;
  --
  begin
    v_result := om_pkg_task.insere(p_nome => 'Teste 3',
                                          p_area => 'MT_07901/13TRF/E09516');
    dbms_output.put_line('Teste 3 success result = '||v_result);
    savepoint salva;
  exception
    when others then
      rollback to salva;
  end;
  --
end;
/

-- saida
/*
Teste 1 success result = -2
Teste 2 success result = 0
Teste 3 success result = 0
*/

SQL> select * from om_cab_tarefa;
 OID NOME     DATA_CRIACAO         AREA                   EQUIPE_RESPONSAVEL
---- -------- -------------------- ---------------------- ------------------
   1 Teste 1  02/08/2021 22:00:00  MT_07019/13TRF/E08796                   0
   2 Teste 2  02/08/2021 22:00:00  MT_11606/13TRF/E08115                   2
   3 Teste 3  02/08/2021 22:00:00  MT_07901/13TRF/E09516                   3

SQL> select * from om_log_proc;
 OID DATA                  CODIGO DESCRICAO
---- -------------------- ------- ----------
   1 02/08/2021 22:00:00       -2 Teste 1
   2 02/08/2021 22:00:00        0 Teste 2
   3 02/08/2021 22:00:00        0 Teste 3

