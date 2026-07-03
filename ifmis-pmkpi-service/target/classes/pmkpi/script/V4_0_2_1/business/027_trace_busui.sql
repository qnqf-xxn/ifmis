begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812ED0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'V_PERF_ADJUSTPROJECT_INFO', 100, 1, 0, 't.pro_code', 'exists(select 1 from v_pm_perf_goal_info a where a.pro_code=t.pro_code and a.yearflag=''0'') and t.pro_cat_code in(''22'',''3'')', 'pmkpi', null);
