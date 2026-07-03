begin

update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/program/trace/manage/prolist') and t.code='query';

update p#busfw_t_uitabpage t set t.componentid='adjustproindexiframe' where t.key='/pmkpi/program/trace/report/ordinaryedit' and code='proindex';

update p#busfw_t_uitabpage t set t.componentid='taskfundsiframe' where t.key='/pmkpi/trace/report/deptedit' and code='tracefund';

delete from p#busfw_t_uitable t where t.key='/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812ED0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'pro_code', ' t.wfstatus=''011'' and exists(select 1 from v_pm_perf_goal_info gl where gl.pro_code=t.pro_code and gl.yearflag=0 and not exists(select 1 from v_perf_t_deptperfmiddeclare nz where nz.pro_code=gl.pro_code and nz.wfstatus<>''011'')) and exists (select * from (select pro_code from v_bgt_pm_annual an where an.is_deleted = 2 group by an.pro_code) t2 where t2.pro_code = t.pro_code and t2.pro_code is not null)', 'pmkpi', null);
