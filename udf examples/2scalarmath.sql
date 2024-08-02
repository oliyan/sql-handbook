create or replace function cmpsys.show_day (
  input_date date
  )
returns varchar(10)
language sql
deterministic
no external action
begin
  declare output_day varchar(10) default ' ';
  set output_day = case dayofweek(input_date)
      when 1 then 'Sunday'
      when 2 then 'Monday'
      when 3 then 'Tuesday'
      when 4 then 'Wednesday'
      when 5 then 'Thursday'
      when 6 then 'Friday'
      when 7 then 'Saturday'
      else 'invalid'
  end;
  return output_day;
end;

