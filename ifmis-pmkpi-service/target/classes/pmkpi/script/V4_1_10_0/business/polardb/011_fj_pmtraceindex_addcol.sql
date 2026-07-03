  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--新增 预估完成值 字段
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ESTIMATED_VAL';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add ESTIMATED_VAL VARCHAR2(1000)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR as
select * from pm_perf_indicator t
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';
select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR_TEMP' and t.column_name='ESTIMATED_VAL';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR_TEMP add ESTIMATED_VAL VARCHAR2(1000)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from pm_perf_indicator_temp t
where province = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='ESTIMATED_VAL';
if i=0 then
   execute immediate 'alter table PERF_T_PROINDEXTRACE add ESTIMATED_VAL VARCHAR2(1000)';
end if;

v_sql :='
create or replace view V_PERF_T_PROINDEXTRACE as
select * from PERF_T_PROINDEXTRACE
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_PROINDEXTRACE',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--dic注册
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('ESTIMATED_VAL');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ESTIMATED_VAL', '1', '2016', '87', sys_guid(), 'ESTIMATED_VAL', 'PM_PERF_INDICATOR', '预估完成值', 'S', '1000', null, 1, 1, null, sysdate);
  
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode in ('ESTIMATED_VAL');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ESTIMATED_VAL', '1', '2016', '87', sys_guid(), 'ESTIMATED_VAL', 'PM_PERF_INDICATOR_TEMP', '预估完成值', 'S', '1000', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROINDEXTRACE' and columncode in ('ESTIMATED_VAL');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ESTIMATED_VAL', '1', '2016', '87', sys_guid(), 'ESTIMATED_VAL', 'PERF_T_PROINDEXTRACE', '预估完成值', 'S', '1000', null, 1, 1, null, sysdate);

--ui配置 默认为隐藏，需要展示的地区页面配置修改或数据库更新下面配置的ISVISIABLE=1显示对应字段
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode in ('ESTIMATED_VAL');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'ESTIMATED_VAL', '1-8月份指标预估完成值', 11, 0, 1, 0, null, 1, 1, null, null, null, null, null, 0, 's', '{"viewty":"year"}', null, '87', '2016', null, null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report/edit/indextarget' and columncode in ('ESTIMATED_VAL');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', 'ESTIMATED_VAL', '1-8月份指标预估完成值', 8, 0, 0, 0, null, 1, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

