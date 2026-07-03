 i number;
begin
--1.表增加列
--QNINDEXVAL         前年指标值
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='QNINDEXVAL';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add QNINDEXVAL VARCHAR2(1000)';
end if;
--SNINDEXVAL      上年指标值
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='SNINDEXVAL';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add SNINDEXVAL VARCHAR2(1000)';
end if;
--COMPUTETYPE            计算方式
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='COMPUTETYPE';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add COMPUTETYPE VARCHAR2(4000)';
end if;
--ISSTANDPUSH           绩效指标来源
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='ISSTANDPUSH';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add ISSTANDPUSH VARCHAR2(4000)';
end if;
--REFERENCESTANDARDS      参考值确定依据
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='REFERENCESTANDARDS';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add REFERENCESTANDARDS VARCHAR2(2000)';
end if;
--INDEXSTANDARDS      指标值确定依据
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='INDEXSTANDARDS';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add INDEXSTANDARDS VARCHAR2(2000)';
end if;
--GOALGUID      目标id
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='GOALGUID';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add GOALGUID VARCHAR2(40)';
end if;
--GOALNAME      目标名称
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='GOALNAME';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTGOAL add GOALNAME VARCHAR2(100)';
end if;
--STATUS      状态
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='STATUS';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTGOAL add STATUS NUMBER(1)';
end if;
--ORDERNUM      排序
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='ORDERNUM';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTGOAL add ORDERNUM NUMBER(4)';
end if;

--2.重构视图
execute immediate '
create or replace view v_perf_t_adjustindex as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--2.重构视图
execute immediate '
create or replace view v_perf_t_adjustgoal as
select * from perf_t_adjustgoal t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--3.注册字段
delete from bus_t_diccolumn where tablecode = 'PERF_T_ADJUSTINDEX' and columncode in ('QNINDEXVAL','SNINDEXVAL','COMPUTETYPE','ISSTANDPUSH','REFERENCESTANDARDS','INDEXSTANDARDS','GOALGUID');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPUTETYPE', '1', '2016', '87', 'E410F3061C7E6A70E0533315A8C081BF', 'COMPUTETYPE', 'PERF_T_ADJUSTINDEX', '计算公式', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXSTANDARDS', null, '1', 'INDEXSTANDARDS', '1', '2016', '87', 'E410F3061C7F6A70E0533315A8C081BF', 'INDEXSTANDARDS', 'PERF_T_ADJUSTINDEX', '指标值设定依据', 'S', '2000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFISSTANDPUSH', null, '1', 'ISSTANDPUSH', '1', '2016', '87', '8ED9044869C3529F9A258E2326698B22', 'ISSTANDPUSH', 'PERF_T_ADJUSTINDEX', '绩效指标来源', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'QNINDEXVAL', '1', '2016', '87', 'E410F3061C806A70E0533315A8C081BF', 'QNINDEXVAL', 'PERF_T_ADJUSTINDEX', '前年指标值', 'S', '1000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REFERENCESTANDARDS', '1', '2016', '87', 'DD535CED078E75BA586C659CF61D5A22', 'REFERENCESTANDARDS', 'PERF_T_ADJUSTINDEX', '参考值确定依据', 'S', '2000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SNINDEXVAL', '1', '2016', '87', 'E410F3061C816A70E0533315A8C081BF', 'SNINDEXVAL', 'PERF_T_ADJUSTINDEX', '上年指标值', 'S', '1000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALGUID', '1', '2016', '87', 'E410F3061C826A70E0533315A8C081BF', 'GOALGUID', 'PERF_T_ADJUSTINDEX', '目标主键', 'S', '40', null, 1, 1, null, sysdate);


delete from bus_t_diccolumn where tablecode = 'PERF_T_ADJUSTGOAL' and columncode in ('GOALNAME','STATUS','ORDERNUM');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', 'E45C13043D4754BAE0533315A8C029D0', 'GOALNAME', 'PERF_T_ADJUSTGOAL', '名称', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'E45C13043D4954BAE0533315A8C029D0', 'ORDERNUM', 'PERF_T_ADJUSTGOAL', '排序', 'N', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIDATATYPE', null, '1', 'STATUS', '1', '2016', '87', 'E45C13043D4854BAE0533315A8C029D0', 'STATUS', 'PERF_T_ADJUSTGOAL', '状态', 'N', '1', null, 1, 1, null, sysdate);
