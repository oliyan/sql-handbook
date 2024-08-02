create or replace procedure CMPSYS.RCVDTA (
  In dqName   char(10),
  In dqLib    char(10),
  Out dqData   char(40)
)

language rpgle
specific CMPSYS.RCVDTA
not deterministic
no sql
called on null input
external name 'CMPSYS/RCVDTAQ1'
parameter style general with nulls;