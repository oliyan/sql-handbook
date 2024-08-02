create or replace function cmpsys.showdept(
  indept char(3) 
)

returns table(
  empno char(6),
  fname varchar(12),
  wdept char(3)
)

language sql
not fenced
deterministic
specific showdept

return
  select  empno, firstnme, workdept
  from    cmpsys.employee
  where   workdept = indept;


-- select a.*
-- from cmpsys.employee a  
-- join table(cmpsys.showdept('533')) b on (a.workdept = b.wdept);

-- select * from table(cmpsys.showdept('533')) ;