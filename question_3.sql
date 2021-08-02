create or replace function ConcatERemove(p_s varchar2,
                                         p_t varchar2,
                                         p_k number) return varchar2 is
--
-- code oracle plsql
-- question 3
-- compilar function
--
s          varchar2(4000);
t          varchar2(4000);
pos_diff   number := 0;
qtd_diff_s number := 0;
qtd_diff_t number := 0;
del        number := 0;
add        number := 0;
v_retorno  varchar2(3);
--
begin
  --
  s := p_s;
  t := p_t;
  --  
  -- verifica posicao com caracter diferente entre s e t
  for i in 1..length(s) loop
    if substr(s,i,1) <> substr(t,i,1) then
      pos_diff   := i;
      qtd_diff_s := length(s)-pos_diff+1;
      qtd_diff_t := length(t)-pos_diff+1;
      exit;
    end if;
  end loop;
  --
  if qtd_diff_s > 0 and qtd_diff_t > 0 then
    -- remove ultimos caracteres diferentes
    loop
      s := substr(s,1,length(s)-1);
      del := del + 1;
      exit when del = qtd_diff_s;
    end loop;
    -- add ultimos caracteres diferentes
    loop
      s := s||substr(t,pos_diff+add,1);
      add := add + 1;
      exit when add = qtd_diff_t;
    end loop;
  end if;
  --
  if s = t and del+add <= p_k then
    v_retorno := 'sim';
  else
    v_retorno := 'não';
  end if;
  --
  return v_retorno;
end;
/
