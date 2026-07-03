i number;
begin
--1.表增加列
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJDEPTAMT' and t.column_name='PROGUID';
if i=0 then
    execute immediate 'alter table PERF_T_ADJDEPTAMT add PROGUID VARCHAR2(40)';
end if;

--2.重构视图
execute immediate '
create or replace view v_perf_t_adjdeptamt as
select * from PERF_T_ADJDEPTAMT t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 and is_deleted = 2';

--3.注册字段
delete FROM Bus_t_Diccolumn t where t.tablecode = 'PERF_T_ADJDEPTAMT' and t.COLUMNCODE in ('PROGUID');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROGUID', '1', '2016', '87', 'E6D18FFC8B092AE2E0533315A8C02354', 'PROGUID', 'PERF_T_ADJDEPTAMT', '申报项目', 'S', '40', null, 1, 1, null, sysdate);
