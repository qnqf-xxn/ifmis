--绩效监控预算执行情况业务表中增加字段bgtsource 区分按资金来源还是按投资方向
i number;
begin

--1.表增加字段
select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROBGTFUND' and t.COLUMN_NAME='BGTSOURCE';
if i=0 then
  execute immediate 'alter table PERF_T_PROBGTFUND add  BGTSOURCE varchar2(40) ';
end if;

  
--2.重建视图  
execute immediate 'create or replace view v_perf_t_probgtfund as
select * from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--3.注册字段
delete from bus_t_diccolumn where tablecode ='PERF_T_PROBGTFUND' and columncode ='BGTSOURCE';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BGTSOURCE', '1', '2020', '87', 'E11382C7B1831E57E0533315A8C02435', 'BGTSOURCE', 'PERF_T_PROBGTFUND', '资金来源标识', 'S', '40', null, 1, 1, null, sysdate);
