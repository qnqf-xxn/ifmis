begin
--绩效目标修订填报--选择项目--总体目标条件改为年度目标条件
--ui表配置
delete from p#busfw_t_uitable where key = '/pmkpi/program/report/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30ECA274CE0533315A8C0ACDD', '/pmkpi/program/report/list', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', null, 'pmkpi', '{"nzpro":"pro_phase=''2'' and not exists (select 1 from v_pm_perf_goal_info gf where gf.pro_code = t.pro_code and gf.YEARFLAG = ''0'')","configsql":"t.pro_cat_code in(''22'',''3'')","xdsql":" exists (select 1 from v_pm_perf_goal_info gf where gf.pro_code = t.pro_code and gf.YEARFLAG = 0)"}');
