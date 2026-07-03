BEGIN

delete from Perf_t_Systemset t where t.paramcode = 'isShowTabPendingTask';

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('319605651ACCB0F88AD6AD89BF098537', 'isShowTabPendingTask', '加载菜单页签待办数量', '1', '1、开启2、关闭', null, 5, 1, 2016, '87');
