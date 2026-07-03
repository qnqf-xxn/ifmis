i number;
begin

--年中追加项目列表增加 项目guid
select count(1) into i from user_tab_columns where table_name = 'PERF_T_DEPTPERFMIDDECLARE' and column_name = 'PROGUID';
if i < 1 then
    execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add PROGUID VARCHAR2(40)';
    execute immediate 'update perf_t_deptperfmiddeclare set proguid = guid,UPDATETIME = to_char(SYSDATE,''yyyyMMddHH24miss'')   where proguid is null';
end if;

--表字段注册
delete from bus_t_diccolumn where tablecode = 'PERF_T_DEPTPERFMIDDECLARE' and columncode = 'PROGUID';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROGUID', '1', '2016', '87', sys_guid(), 'PROGUID', 'PERF_T_DEPTPERFMIDDECLARE', '项目ID', 'S', '40', null, 1, 0, null, sysdate);

--重构视图
execute immediate '
create or replace view V_PERF_T_DEPTPERFMIDDECLARE as
select * from perf_t_deptperfmiddeclare
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';

