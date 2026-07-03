
  i integer;
begin

execute immediate '
create or replace view v_perf_fund_project as
select '''' name,'''' totalamt,'''' amt1,'''' amt2,'''' amt3,'''' amt4,'''' amt5,'''' amt6,'''' amt7,'''' amt8,'''' amt9,'''' proguid,
'''' isedit,'''' update_time,'''' startdate,'''' ordernum,'''' guid,'''' bgtget
 from dual t';

execute immediate '
create or replace view v_perf_fund_dept as
select '''' name,'''' totalamt,'''' amt1,'''' amt2,'''' amt3,'''' amt4,'''' amt5,'''' amt6,'''' amt7,'''' amt8,'''' amt9,'''' proguid,
'''' isedit,'''' update_time,'''' startdate,'''' ordernum,'''' guid,'''' bgtget
 from dual t';
 
