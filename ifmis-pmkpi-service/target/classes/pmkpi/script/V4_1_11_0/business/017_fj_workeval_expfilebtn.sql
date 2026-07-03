begin


delete from p#busfw_t_uifunction where key ='/pmkpi/workevaluate/query/list' and code ='expfile';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/query/list', '导出附件', 1, 9, 'searchicon', 'workevalquery.expfile', null, '导出附件', 'pmkpi', 'expfile', null, '{zipname:''''}', '87', '2016', null, null);


update bus_t_pageconsolecomconfig set config ='{key:''/pmkpi/workevaluate/report/subpedit/info'',title:''基本信息'',tablecode:''perf_t_worktaskassign'',iswf:''true'',columnsize:2}' where url ='/pmkpi/workevaluate/audit/subprovinceedit' and id ='infoeditformformal' and appid ='pmkpi';


update perf_t_pagemenu set name = '绩效管理工作考核填报页面',uikey = '#' where guid ='D64BACE27CD468B8E0533315A8C0D95E';

delete from perf_t_pagemenu where guid ='D64BACE27CD468B8E0533315A8C0D96F' or superguid ='D64BACE27CD468B8E0533315A8C0D96F';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('D64BACE27CD468B8E0533315A8C0D96F', '015006', '绩效管理工作考核审核页面', '#', 'CE0FB86D1A7A332AE0533315A8C06C93', 4, 1, 1, 1, '20251120160721', '20251120160721', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('D7E836E45822C9ABD0FD97E17B9540FD', '015006001', '下级财政', '/pmkpi/workevaluate/audit/subprovinceedit', 'D64BACE27CD468B8E0533315A8C0D96F', 5, 1, 1, 1, '20251120160825', '20251120160825', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('6DD0F65996B47E597EFA6B3EB6148FE6', '015006002', '部门整体', '/pmkpi/workevaluate/audit/deptedit', 'D64BACE27CD468B8E0533315A8C0D96F', 5, 1, 2, 1, '20251120160859', '20251120160859', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

