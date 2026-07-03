i number;
begin
   select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='BGTSOURCE';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPROFUND add  BGTSOURCE varchar2(40) ';
  end if;
  
  execute immediate ' 
create or replace view v_perf_t_selfprofund as
select * from perf_t_selfprofund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

delete from bus_t_diccolumn where tablecode ='PERF_T_SELFPROFUND' and columncode ='BGTSOURCE';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BGTSOURCE', '1', '2020', '87', 'E11R82C7B1831E57E0533315A8C02435', 'BGTSOURCE', 'PERF_T_SELFPROFUND', '资金来源标识', 'S', '40', null, 1, 1, null, sysdate);
