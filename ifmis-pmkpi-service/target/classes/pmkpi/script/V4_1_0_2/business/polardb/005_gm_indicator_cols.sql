i number;
begin
--1
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='INDEXCATEGORIES';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add INDEXCATEGORIES VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='INDUSTRYCATEGORY';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add INDUSTRYCATEGORY VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='INDEXCATEGORY';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add INDEXCATEGORY VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='FILED';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add FILED VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='OCCUPATION';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add OCCUPATION VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='IS_ADD';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add IS_ADD VARCHAR2(2)';
end if;
--- temp
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='INDEXCATEGORIES';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDEXCATEGORIES VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='INDUSTRYCATEGORY';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDUSTRYCATEGORY VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='INDEXCATEGORY';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDEXCATEGORY VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='FILED';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add FILED VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='OCCUPATION';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add OCCUPATION VARCHAR2(40)';
end if;
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='IS_ADD';
if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add IS_ADD VARCHAR2(2)';
end if;


--3
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='INDEXCATEGORIES';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDEXCATEGORIES', '1', '2016', '87', '028BE3C16EEE7E17E0630A64A8C07953', 'INDEXCATEGORIES', 'PM_PERF_INDICATOR', '行业大类', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='INDUSTRYCATEGORY';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDUSTRYCATEGORY', '1', '2016', '87', '028BE3C16EEF7E17E0630A64A8C07953', 'INDUSTRYCATEGORY', 'PM_PERF_INDICATOR', '行业类别', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='INDEXCATEGORY';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDEXCATEGORY', '1', '2016', '87', '028BE3C16EF07E17E0630A64A8C07953', 'INDEXCATEGORY', 'PM_PERF_INDICATOR', '资金用途', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='FILED';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'FILED', '1', '2016', '87', '028BE3C16EF17E17E0630A64A8C07953', 'FILED', 'PM_PERF_INDICATOR', '职能', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='OCCUPATION';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'OCCUPATION', '1', '2016', '87', '028BE3C16EF27E17E0630A64A8C07953', 'OCCUPATION', 'PM_PERF_INDICATOR', '活动', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode ='IS_ADD';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, 'VD00001', null, '1', 'IS_ADD', '1', '2016', '87', '028BE3C16EF37E17E0630A64A8C07953', 'IS_ADD', 'PM_PERF_INDICATOR', '是否新增', 'S', '2', null, 1, 1, null, sysdate);
end if;
-- temp





SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='INDEXCATEGORIES';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDEXCATEGORIES', '1', '2016', '87', '02D98745EC2A4703E0630A64A8C0A279', 'INDEXCATEGORIES', 'PM_PERF_INDICATOR_TEMP', '行业大类', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='INDUSTRYCATEGORY';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDUSTRYCATEGORY', '1', '2016', '87', '02D98745EC2B4703E0630A64A8C0A279', 'INDUSTRYCATEGORY', 'PM_PERF_INDICATOR_TEMP', '行业类别', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='INDEXCATEGORY';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'INDEXCATEGORY', '1', '2016', '87', '02D98745EC2C4703E0630A64A8C0A279', 'INDEXCATEGORY', 'PM_PERF_INDICATOR_TEMP', '资金用途', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='FILED';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'FILED', '1', '2016', '87', '02D98745EC2D4703E0630A64A8C0A279', 'FILED', 'PM_PERF_INDICATOR_TEMP', '职能', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='OCCUPATION';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, '', null, '1', 'OCCUPATION', '1', '2016', '87', '02D98745EC2E4703E0630A64A8C0A279', 'OCCUPATION', 'PM_PERF_INDICATOR_TEMP', '活动', 'S', '40', null, 1, 1, null, sysdate);
end if;
SELECT count(1) into i FROM bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode ='IS_ADD';
if i=0 then
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, 'VD00001', null, '1', 'IS_ADD', '1', '2016', '87', '02D98745EC2F4703E0630A64A8C0A279', 'IS_ADD', 'PM_PERF_INDICATOR_TEMP', '是否新增', 'S', '2', null, 1, 1, null, sysdate);
end if;
