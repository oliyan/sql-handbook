create or replace function cmpsys.xtrfile (
  fullpath varchar(500)
  )
returns varchar(255)
language sql
deterministic
no external action
begin
  declare vcount smallint ;
  declare endSlashPos smallint;

  set vcount  = regexp_count(fullpath, '/'); -- ---------------- find how many times the '/' is present in the given string.
  set endSlashPos = regexp_instr(fullpath, '/', 1, vcount);-- -- find the position of the last '/' present in the given string.

  return substr(fullpath, endSlashPos + 1); -- ----------------- use substring to get only the file name. 
  
end;
