begin

--7、年中追加项目年度绩效目标填报-送审校验
delete from perf_t_uitabpage_chec where key = '/pmkpi/midprogram/report/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D55F74D596775D1BB12A26E9C3DCB99C', 'D4D3D3E37962274CE0533315A8C0ACDD', '项目基本信息', '/pmkpi/midprogram/report/edit', 'proinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('72BC3AAE199B5BCD8FDC6A167316B98A', 'D4D3D3E3791B274CE0533315A8C0ACDD', '年度绩效目标', '/pmkpi/midprogram/report/edit', 'yeargoal', 2, 'pm_perf_goal_info,v_pm_perf_goal_info', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CDC9D7FD7CA9DC55BEC0A4E7C5D75FAE', 'D4D3D3E37919274CE0533315A8C0ACDD', '年度绩效指标', '/pmkpi/midprogram/report/edit', 'yearindex', 2, 'pm_perf_indicator,v_pm_perf_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('88BF68BE58F54C7046F7A243B12EA375', 'DE683511A989FD2D2C9E801DCE32BBFF', '年度绩效(湖北)', '/pmkpi/midprogram/report/edit', 'goalandindex', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--8、省、市级绩效管理工作考核填报-送审校验
--8-1、下级财政
delete from perf_t_uitabpage_chec where key = '/pmkpi/workevaluate/report/subprovinceedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('99095BD5C407D140F71874408CEB997C', 'D4D3D3E37934274CE0533315A8C0ACDD', '基本信息', '/pmkpi/workevaluate/report/subprovinceedit', 'editinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('DA15BA1294583AF7B5D1F90403394232', 'D4D3D3E37935274CE0533315A8C0ACDD', '县（市）区、开发区预算绩效管理工作考核评分表', '/pmkpi/workevaluate/report/subprovinceedit', 'subprovincework', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('B36F79F41EF77BC0B67D07A443931D86', 'D4D3D3E37936274CE0533315A8C0ACDD', '附件上传', '/pmkpi/workevaluate/report/subprovinceedit', 'workfile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
--8-2、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/workevaluate/report/deptedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0938B40BC9AB29A4BD5754F8219A7E91', 'D4D3D3E3793E274CE0533315A8C0ACDD', '基本信息', '/pmkpi/workevaluate/report/deptedit', 'editinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('A2BA3456E33E4719785EA02D94B2221E', 'D4D3D3E3793F274CE0533315A8C0ACDD', '市直部门预算绩效管理工作考核评分表', '/pmkpi/workevaluate/report/deptedit', 'deptwork', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F1FA5D3A48AB897C6DFA136CBE5F4B97', 'D4D3D3E37940274CE0533315A8C0ACDD', '市预算绩效管理重点推进任务考核评分表', '/pmkpi/workevaluate/report/deptedit', 'deptkeywork', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('323781D1348638C5977A34098FAADA7D', 'D4D3D3E37941274CE0533315A8C0ACDD', '附件上传', '/pmkpi/workevaluate/report/deptedit', 'workfile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--9、部门评价成果申报-送审校验
delete from perf_t_uitabpage_chec where key = '/pmkpi/evaluation/dept/result/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BA6338862F364E95BD94B262C6D3C649', 'E4257E79F6872FF4E0533315A8C02DE5', '基本信息', '/pmkpi/evaluation/dept/result/edit', 'info', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('77802FE4758595ABC098819A803306BB', 'E4257E79F6882FF4E0533315A8C02DE5', '项目附件', '/pmkpi/evaluation/dept/result/edit', 'profile', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('7FE336D16C4FAF46BF5D3E1CA15D5A04', 'E4257E79F6892FF4E0533315A8C02DE5', '评估结论', '/pmkpi/evaluation/dept/result/edit', 'assessinfo', 2, 'v_perf_t_deptevaluation', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('36FFADD65D9F098BB5AEA409C9810144', 'E4257E79F68A2FF4E0533315A8C02DE5', '评价成果', '/pmkpi/evaluation/dept/result/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--10、预算部门自评-送审校验
--10-1、项目支出
delete from perf_t_uitabpage_chec where key = '/pmkpi/evaluation/financial/deptfill/proedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BC97485619ED0A3E4811435894E918CC', 'E4257E79F68B2FF4E0533315A8C02DE5', '基本信息', '/pmkpi/evaluation/financial/deptfill/proedit', 'info', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('85EA5DC21A6CA71A290681799AA1FAA8', 'E4257E79F68C2FF4E0533315A8C02DE5', '项目资料', '/pmkpi/evaluation/financial/deptfill/proedit', 'profile', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F35316CC4064DA3F2185E11DDBBB2F0E', 'E4257E79F68D2FF4E0533315A8C02DE5', '评分表', '/pmkpi/evaluation/financial/deptfill/proedit', 'score', 2, 'v_perf_t_deptscore', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('94D5781E8C557C07D2FD61B4DD3E2CCB', 'E4257E79F68E2FF4E0533315A8C02DE5', '附件上传', '/pmkpi/evaluation/financial/deptfill/proedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('B9B3DA214FC72A813D82017BDA9ADEC1', 'E4257E79F68F2FF4E0533315A8C02DE5', '关联项目', '/pmkpi/evaluation/financial/deptfill/proedit', 'relation', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
--10-2、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/evaluation/financial/deptfill/deptedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('7DA02A053EA07E7D9E9B02B0805BB2DC', 'E4257E79F6902FF4E0533315A8C02DE5', '项目资料', '/pmkpi/evaluation/financial/deptfill/deptedit', 'profile', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('18ADE935B2F847BD1E119BE09E8F6683', 'E4257E79F6912FF4E0533315A8C02DE5', '基本信息', '/pmkpi/evaluation/financial/deptfill/deptedit', 'info', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CE89F324529E434A421BA60A95F51C77', 'E4257E79F6922FF4E0533315A8C02DE5', '评分表', '/pmkpi/evaluation/financial/deptfill/deptedit', 'score', 2, 'v_perf_t_deptscore', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('424904E4ADA4000D77F9F15BA4A835E2', 'E4257E79F6932FF4E0533315A8C02DE5', '附件上传', '/pmkpi/evaluation/financial/deptfill/deptedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--11、部门综合评价填报-送审校验[暂不支持]
--12、整改情况反馈-送审校验[暂不支持]
--13、部门整体绩效录入-送审校验[没浙江环境，暂时不做]