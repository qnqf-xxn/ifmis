begin
  
delete from perf_t_uitabpage_chec t where key='/pmkpi/selfparent/program/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2F7BA1279AC27D7CE063020011ACEBDE', null, '预算执行情况', '/pmkpi/selfparent/program/edit', 'bdgpay', 1, 'v_perf_t_selfprofund', '20250304133610', '20250304133610', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2F7BA1279AC37D7CE063020011ACEBDE', null, '指标完成情况', '/pmkpi/selfparent/program/edit', 'selfindex', 1, 'v_perf_t_selfperfindex', '20250304133610', '20250304133610', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2F7BA1279AC47D7CE063020011ACEBDE', null, '自评分析', '/pmkpi/selfparent/program/edit', 'selfdesc', 1, 'v_perf_t_selfperfdesc', '20250304133610', '20250304133610', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2F7BA1279AC57D7CE063020011ACEBDE', null, '附件管理', '/pmkpi/selfparent/program/edit', 'file', 2, 'v_perf_file', '20250304133610', '20250304133610', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2F7BA1279AC87D7CE063020011ACEBDE', null, '项目基本信息', '/pmkpi/selfparent/program/edit', 'projinfo', 1, 'v_perf_t_selfevaltask', '20250304133813', '20250304133813', '2016', '87');
