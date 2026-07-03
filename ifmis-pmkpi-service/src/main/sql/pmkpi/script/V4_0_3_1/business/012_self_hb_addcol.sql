    i number;
begin

--湖北-自评分析
--偏差大或目标未完成的原因分析
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='UNFINISHEDANALY';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFDESC add(UNFINISHEDANALY VARCHAR2(2000))';
end if;
--改进措施及结果应用方案
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='RECTIFICPLAN';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFDESC add(RECTIFICPLAN VARCHAR2(2000))';
end if;
execute immediate 'create or replace view v_perf_t_selfperfdesc as
select
    *
from
    PERF_T_SELFPERFDESC
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFPERFDESC' and columncode in( 'UNFINISHEDANALY','RECTIFICPLAN');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'RECTIFICPLAN', '1', '2016', '87', 'EB4B2E1412674D7AE0533315A8C0FE6B', 'RECTIFICPLAN', 'PERF_T_SELFPERFDESC', '改进措施及结果应用方案', 'S', '2000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UNFINISHEDANALY', '1', '2016', '87', 'EB4B2E1412664D7AE0533315A8C0FE6B', 'UNFINISHEDANALY', 'PERF_T_SELFPERFDESC', '偏差大或目标未完成的原因分析', 'S', '2000', null, 1, 1, null, sysdate);


--自评指标表
select count(1) into i from user_tab_cols where table_name='PERF_T_SELFPERFINDEX' and column_name='GOALGUID';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add(GOALGUID VARCHAR2(40))';
end if;
delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFPERFINDEX' and columncode in( 'GOALGUID');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALGUID', '1', '2016', '87', 'DA61946DCA10101EE0533315A8C0D73D', 'GOALGUID', 'PERF_T_SELFPERFINDEX', '目标GUID', 'S', '40', null, 1, 1, null, sysdate);
execute immediate '
create or replace view v_perf_t_selfperfindex as
select
    *
from
    perf_t_selfperfindex
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and is_deleted = 2
';
