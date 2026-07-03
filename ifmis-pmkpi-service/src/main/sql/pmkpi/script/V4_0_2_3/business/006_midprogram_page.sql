begin
--年中追加选择项目  过滤条件在数据库配置(申报了年度绩效目标)
delete from p#busfw_t_uitable  where key ='/pmkpi/program/report/list';
insert into p#busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30ECA274CE0533315A8C0ACDD', '/pmkpi/program/report/list', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', null, 'pmkpi', '{"nzpro":"pro_phase=''2'' and not exists (select 1 from v_pm_perf_goal_info gf where gf.pro_code = t.pro_code and gf.YEARFLAG = ''0'')","configsql":"t.pro_cat_code in(''22'',''3'')"}');




