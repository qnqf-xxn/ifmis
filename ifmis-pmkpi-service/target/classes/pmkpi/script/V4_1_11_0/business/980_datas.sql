begin

--添加系统参数，控制指标系统送审校模式
delete from perf_t_systemset t where t.paramcode = 'sendbdgchecktype';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('319605651ACCB0F88AD6AD89BF0935GD', 'sendbdgchecktype', '指标系统送审校验绩效模式', '2', '1、校验申报年度绩效+年中追加终审;2、配置“绩效调整指标（预算调整调剂）”审核定义校验', null, 98, 1, 2016, '87');

--添加系统参数，控制导出报表是否可根据斜杠分割新建文件夹
delete from perf_t_systemset t where t.paramcode = 'is_expfilenamefolder';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('319605651ACCB0F88AD6AD89BF093R5E', 'is_expfilenamefolder', '导出报表是否可根据斜杠新建文件夹', '2', '1、是;2、否，会替换斜杠为全角', null, 98, 1, 2016, '87');
