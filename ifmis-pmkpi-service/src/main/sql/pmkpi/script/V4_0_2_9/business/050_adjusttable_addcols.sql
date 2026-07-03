i number;
begin
--1.表增加列
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='ENDYEAR';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add ENDYEAR NUMBER(4)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='LINKMAN';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add LINKMAN VARCHAR2(50)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='TELEPHONE';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add TELEPHONE VARCHAR2(30)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='FUNCDESC';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add FUNCDESC VARCHAR2(3000)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='PERFGOAL';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add PERFGOAL VARCHAR2(4000)';
end if;

--2.重构视图
execute immediate '
create or replace view v_perf_t_adjust as
select * from perf_t_adjust t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--3.注册字段
delete FROM Bus_t_Diccolumn t where t.tablecode = 'PERF_T_ADJUST' and t.COLUMNCODE in ('LINKMAN','TELEPHONE','ENDYEAR','FUNCDESC','PERFGOAL');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIDEPTPERFENDYEAR', null, '1', 'ENDYEAR', '1', '2016', '87', 'E410F3061C7D6A70E0533315A8C081BF', 'ENDYEAR', 'PERF_T_ADJUST', '长期目标截止年份', 'N', '4', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FUNCDESC', '1', '2016', '87', 'E5B6E35164AC6AB4E0533315A8C04B67', 'FUNCDESC', 'PERF_T_ADJUST', '职能描述', 'S', '3000', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LINKMAN', '1', '2016', '87', 'E5B6E35164AB6AB4E0533315A8C04B67', 'LINKMAN', 'PERF_T_ADJUST', '联系人', 'S', '50', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PERFGOAL', '1', '2016', '87', 'E5B6E35164AD6AB4E0533315A8C04B67', 'PERFGOAL', 'PERF_T_ADJUST', '年度绩效目标', 'S', '4000', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TELEPHONE', '1', '2016', '87', 'E5B6E35164AF6AB4E0533315A8C04B67', 'TELEPHONE', 'PERF_T_ADJUST', '联系电话', 'S', '30', null, 1, 1, null, sysdate);
