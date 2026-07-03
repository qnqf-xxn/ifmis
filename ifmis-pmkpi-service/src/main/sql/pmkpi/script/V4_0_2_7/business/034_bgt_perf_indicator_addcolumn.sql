i number;
begin
--表新增字段
--ENDVALTYPE        取值方式
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='ENDVALTYPE';
if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add ENDVALTYPE VARCHAR2(100)';
end if;
--ENDVALSOURCE      指标完成值数据来源
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='ENDVALSOURCE';
if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add ENDVALSOURCE VARCHAR2(100)';
end if;
--SCOREWEIGHT            指标分值权重
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='WEIGHT';
if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add WEIGHT NUMBER(5,2)';
end if;
--VALRULE           赋分规则
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='VALRULE';
if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add VALRULE VARCHAR2(100)';
end if;
--EVIDENCEFILE      佐证资料要求
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='EVIDENCEFILE';
if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add EVIDENCEFILE VARCHAR2(100)';
end if;

--重构视图
execute immediate '
create or replace view v_bgt_perf_indicator as
select *
    from BGT_PERF_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
      
      
--表字段注册
delete bus_t_diccolumn  where tablecode = 'BGT_PERF_INDICATOR' and columncode in('ENDVALTYPE','ENDVALSOURCE','WEIGHT','VALRULE','EVIDENCEFILE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFENDVALSOURCE', null, '1', 'ENDVALSOURCE', '1', '2016', '87', 'E1DE2D0E0AAA51DDE0533315A8C0B2C6', 'ENDVALSOURCE', 'BGT_PERF_INDICATOR', '指标完成值数据来源', 'S', '100', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFENDVALTYPE', null, '1', 'ENDVALTYPE', '1', '2016', '87', 'E1DE2D0E0AAB51DDE0533315A8C0B2C6', 'ENDVALTYPE', 'BGT_PERF_INDICATOR', '取值方式', 'S', '100', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFEVIDENCEFILE', null, '1', 'EVIDENCEFILE', '1', '2016', '87', 'E1DE2D0E0AAC51DDE0533315A8C0B2C6', 'EVIDENCEFILE', 'BGT_PERF_INDICATOR', '佐证资料要求', 'S', '100', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WEIGHT', '1', '2016', '87', 'E1DE2D0E0AAE51DDE0533315A8C0B2C6', 'WEIGHT', 'BGT_PERF_INDICATOR', '指标分值权重', 'N', '10', null, 1, 0, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'VALRULE', '1', '2016', '87', 'E1DE2D0E0AAD51DDE0533315A8C0B2C6', 'VALRULE', 'BGT_PERF_INDICATOR', '赋值规则', 'S', '100', null, 1, 1, null, sysdate);
