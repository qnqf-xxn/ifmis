  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='ISSELFEVAL';
if i=0 then
   execute immediate 'alter table PERF_T_MANCEOPEN add ISSELFEVAL NUMBER(1)';
end if;

--业务数据视图
v_sql :='
create or replace view V_PERF_T_MANCEOPEN as
select t.* from PERF_T_MANCEOPEN t where year = global_multyear_cz.v_pmyear
and province = global_multyear_cz.v_pmdivid and is_deleted = ''2''';
select fn_alterview('V_PERF_T_MANCEOPEN',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--待填报取数视图
select count(*) into i from user_views where VIEW_NAME = 'V_PERF_T_MANCEOPENTEMP';
if i=1 then
	v_sql :='
	create or replace view V_PERF_MANCEOPEN as
	select t.*,a.guid,a.isopen,a.openamt,a.openurl,a.openreason,a.wfstatus,a.wfid,a.auditor,a.lastupdatetime,a.updatetime,a.isselfeval
	from v_perf_t_manceopentemp t
	left join v_perf_t_manceopen a on a.xmly=t.xmly and a.pro_code=t.pro_code and t.bustype=a.bustype
	where t.province = global_multyear_cz.v_pmdivid';
	select fn_alterview('V_PERF_MANCEOPEN',v_sql) into ln_i;
	if ln_i = 0 then
		return;
	end if;
end if;
