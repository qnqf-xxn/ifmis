i number;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='ISSELFEVAL';
if i=0 then
   execute immediate 'alter table PERF_T_MANCEOPEN add ISSELFEVAL NUMBER(1)';
end if;

--业务数据视图
execute immediate 'create or replace view v_perf_t_manceopen as
select t.* from PERF_T_MANCEOPEN t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = ''2''';

--待填报取数视图
select count(*) into i from user_views where VIEW_NAME = 'V_PERF_T_MANCEOPENTEMP';
if i=1 then
	execute immediate 'create or replace view v_perf_manceopen as
select t.*,a.guid,a.isopen,a.openamt,a.openurl,a.openreason,a.wfstatus,a.wfid,a.auditor,a.lastupdatetime,a.updatetime,a.isselfeval
from v_perf_t_manceopentemp t
left join v_perf_t_manceopen a on a.xmly=t.xmly and a.pro_code=t.pro_code and t.bustype=a.bustype
where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
end if;

