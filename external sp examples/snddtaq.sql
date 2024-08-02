create or replace procedure CMPSYS.SNDDTA (
  In dqName   char(10),
  In dqLib    char(10),
  In dqData   char(40)
)

language rpgle
specific CMPSYS.SNDDTA
not deterministic
no sql
external name 'CMPSYS/SNDDTAQ1'
parameter style general;