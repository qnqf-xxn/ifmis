begin

--11、整改情况反馈-送审校验create table
--11-1、项目支出
delete from perf_t_uitabpage_chec where key = '/pmkpi/rectification/program/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('84EC7CE217143C7D767E240552725142', 'D4D3D3E37A2B274CE0533315A8C0ACDD', '整改通知附件', '/pmkpi/rectification/program/edit', 'rectifyfile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('6BE04E56BCA3F51DF9D3BF68405A9DFE', 'D4D3D3E37A2C274CE0533315A8C0ACDD', '整改反馈附件', '/pmkpi/rectification/program/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
--11-2、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/rectification/dept/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('08F2EDA535ADF1802BB6381CA2DFDB47', 'D4D3D3E378EF274CE0533315A8C0ACDD', '整改通知附件', '/pmkpi/rectification/dept/edit', 'rectifyfile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('E50A8EA7521840311C0FDB15247C10E6', 'D4D3D3E378F0274CE0533315A8C0ACDD', '整改反馈附件', '/pmkpi/rectification/dept/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--12、部门综合评价填报-送审校验[暂不支持]
--13、部门整体绩效录入-送审校验[没浙江环境，暂时不做]