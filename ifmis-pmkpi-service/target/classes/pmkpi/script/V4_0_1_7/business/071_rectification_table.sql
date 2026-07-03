i number;
begin
  --Ö÷±íÌí¼Ó pro_code×Ö¶Î
  select count(1) into i from user_tab_cols where table_name = 'PERF_T_RECTIFY' and column_name = 'PRO_CODE';
if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add PRO_CODE varchar2(40)';
     execute immediate 'UPDATE PERF_T_RECTIFY t1 SET t1.PRO_CODE = (select t2.PROJCODE from PERF_T_RECTIFY t2 where t1.guid = t2.guid)';
  end if;

--±í×Ö¶Î×¢²á  Ìí¼Ópro_code ×Ö¶Î
delete from bus_t_diccolumn where TABLECODE='PERF_T_RECTIFY' and DBCOLUMNCODE = 'PRO_CODE' and COLUMNCODE='PRO_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', null, null, 'E222285D0410BE7423E9ABEC529C2670', 'PRO_CODE', 'PERF_T_RECTIFY', null, 'S', '40', null, null, 1, null, sysdate);
  
  --ÖØ¹¹ÊÔÍ¼
  execute immediate '
  create or replace view v_perf_t_rectify as
   select *
  from PERF_T_RECTIFY t 
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and 
  PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--¼à¿ØÔ¤Ëã
execute immediate '
create or replace view v_perf_t_probgtfund as
select t.*
 from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
