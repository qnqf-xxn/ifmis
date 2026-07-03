begin


delete from Perf_t_Systemset t where t.guid in('AF18FCA645FA0EC6E0530100007F659C','EEE3F4C0FF6EED84740CF5628DA85048');

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('AF18FCA645FA0EC6E0530100007F659C', 'ismergeindex', '指标值是否合并单位符号显示', '1', '1、合并显示2、分开显示', null, 5, 1, 2016, '87');


insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('EEE3F4C0FF6EED84740CF5628DA85048', 'porgramurl_index', '绩效项目指标嵌套url', 'pdm/cross_request.html', '项目库嵌套绩效页面url', null, 2, 1, 2016, '87');
