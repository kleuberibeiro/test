-- code oracle plsql
-- question 2
-- executar em SQL Window com Output habilitado

declare
v_aux varchar2(10);
begin
  for i in 1..100 loop
    v_aux := null;
    if mod(i,3) = 0 then
      v_aux := v_aux||'Foo';
    end if;
    if mod(i,5) = 0 then
      v_aux := v_aux||'Baa';
    end if;
    if v_aux is null then
      v_aux := i;
    end if;
    dbms_output.put_line(v_aux);
  end loop;
end;
