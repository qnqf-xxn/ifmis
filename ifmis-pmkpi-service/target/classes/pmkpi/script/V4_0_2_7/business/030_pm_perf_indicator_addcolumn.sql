 i number;
begin
--1.表增加列
--ENDVALTYPE        取值方式
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ENDVALTYPE';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add ENDVALTYPE VARCHAR2(40)';
end if;
--ENDVALSOURCE      指标完成值数据来源
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ENDVALSOURCE';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add ENDVALSOURCE VARCHAR2(40)';
end if;
--WEIGHT            指标分值权重
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='WEIGHT';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add WEIGHT NUMBER(5,2)';
end if;
--VALRULE           赋分规则
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='VALRULE';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add VALRULE VARCHAR2(40)';
end if;
--EVIDENCEFILE      佐证资料要求
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='EVIDENCEFILE';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add EVIDENCEFILE VARCHAR2(40)';
end if;

--2.重构视图
execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

--3.注册字段
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in('ENDVALTYPE','ENDVALSOURCE','WEIGHT','VALRULE','EVIDENCEFILE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFENDVALSOURCE', null, '1', 'ENDVALSOURCE', '1', '2016', '87', 'E1A0645C895C4BA6E0533315A8C064F8', 'ENDVALSOURCE', 'PM_PERF_INDICATOR', '指标完成值数据来源', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFENDVALTYPE', null, '1', 'ENDVALTYPE', '1', '2016', '87', 'E1A0645C895D4BA6E0533315A8C064F8', 'ENDVALTYPE', 'PM_PERF_INDICATOR', '完成值取值方式', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFEVIDENCEFILE', null, '1', 'EVIDENCEFILE', '1', '2016', '87', 'E1A0645C895B4BA6E0533315A8C064F8', 'EVIDENCEFILE', 'PM_PERF_INDICATOR', '佐证资料要求', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'VALRULE', '1', '2016', '87', 'E1A0645C895E4BA6E0533315A8C064F8', 'VALRULE', 'PM_PERF_INDICATOR', '赋值规则', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WEIGHT', '1', '2016', '87', '6743E5DE13904E8AA345FDD3B01DEDCB', 'WEIGHT', 'PM_PERF_INDICATOR', '指标分值权重', 'N', '5', null, 1, 0, null, sysdate);
