-- code oracle plsql
-- question 4
-- executar em SQL Window com Output habilitado

begin
  dbms_output.put_line(concateremove(p_s => 'blablablabla',
                                     p_t => 'blablabcde',
                                     p_k => 8));
end;
