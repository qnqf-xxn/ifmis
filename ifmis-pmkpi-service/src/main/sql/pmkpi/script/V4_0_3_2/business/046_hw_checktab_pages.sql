begin
--7、年中追加项目年度绩效目标填报-送审校验
delete from perf_t_uitabpage_chec where key = '/pmkpi/midprogram/report/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D55F74D596775D1BB12A26E9C3DCB99C', 'D4D3D3E37962274CE0533315A8C0ACDD', '项目基本信息', '/pmkpi/midprogram/report/edit', 'proinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('72BC3AAE199B5BCD8FDC6A167316B98A', 'D4D3D3E3791B274CE0533315A8C0ACDD', '年度绩效目标', '/pmkpi/midprogram/report/edit', 'yeargoal', 2, 'v_pm_perf_goal_info', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CDC9D7FD7CA9DC55BEC0A4E7C5D75FAE', 'D4D3D3E37919274CE0533315A8C0ACDD', '年度绩效指标', '/pmkpi/midprogram/report/edit', 'yearindex', 2, 'v_pm_perf_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('88BF68BE58F54C7046F7A243B12EA375', 'DE683511A989FD2D2C9E801DCE32BBFF', '年度绩效(湖北)', '/pmkpi/midprogram/report/edit', 'goalandindex', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
