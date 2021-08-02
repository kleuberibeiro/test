create or replace function calc_tam_str(p_str varchar2) return number is
--
-- code oracle plsql
-- question 6
-- compilar function
--
str varchar2(1);
tam number := 0;
--
begin
  if p_str is not null then
    loop
      str := substr(p_str,tam+1,1);
      exit when str is null;
      tam := tam + 1;
    end loop;
  end if;
  return tam;
end;
/
