i number;
begin


select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ISUNMOD';
    if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add(ISUNMOD VARCHAR2(40))';
end if;

select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'ISUNMOD';
if i = 0 then
 execute immediate 'alter table PERF_T_ADJUSTINDEX add(ISUNMOD VARCHAR2(40))';
end if;
  

execute immediate '
create or replace view V_PM_PERF_INDICATOR as
select
    *
from
    PM_PERF_INDICATOR
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select
    *
from
    PERF_T_ADJUSTINDEX
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


delete from bus_t_diccolumn where TABLECODE IN ( 'PM_PERF_INDICATOR','PERF_T_ADJUSTINDEX') and COLUMNCODE ='ISUNMOD';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISUNMOD', '1', '2016', '87', sys_guid(), 'ISUNMOD', 'PM_PERF_INDICATOR', '是否可修改', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISUNMOD', '1', '2016', '87', sys_guid(), 'ISUNMOD', 'PERF_T_ADJUSTINDEX', '是否可修改', 'S', '40', null, null, 1, null, sysdate);