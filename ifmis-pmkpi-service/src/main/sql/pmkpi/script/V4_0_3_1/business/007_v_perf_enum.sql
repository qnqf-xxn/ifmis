begin

execute immediate '
create or replace view v_perf_enum as
select t.*
,superid as superguid
 FROM PERF_ENUM T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') and t.status=1';
