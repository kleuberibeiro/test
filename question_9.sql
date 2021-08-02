-- code oracle plsql
-- question 9
-- criar sequence, compilar procedure e trigger

create sequence seq_oid;

create or replace procedure pc_om_record(p_rec in out om_record%rowtype) is
begin
  --
  p_rec.oid          := seq_oid.nextval;
  p_rec.data_criacao := sysdate;
  --
  begin
    select n.natureza into p_rec.natureza
    from om_record_natureza n
    where n.tipo  = p_rec.tipo
    and n.subtipo = p_rec.subtipo;
  exception
    when NO_DATA_FOUND then
      p_rec.natureza := 0;
  end;
  --
  insert into om_record values p_rec;
  --
end;
/

create or replace trigger tg_tcall
  after insert on tcall
  for each row
declare
v_rec om_record%rowtype;
begin
  v_rec.tipo    := :new.tipo;
  v_rec.subtipo := :new.subtipo;
  pc_om_record(p_rec => v_rec);
end;
/

