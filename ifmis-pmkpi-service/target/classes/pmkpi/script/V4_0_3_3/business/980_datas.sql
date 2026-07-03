begin

--自评指标：实际完成值数据源
delete from perf_enum t where t.elementcode='PMKPISELFINDEXVAL';
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('达成预期指标', '1', 'PMKPISELFINDEXVAL', '达成预期指标', '1', null, null, '2016', '87', null, 'pmkpi', '0', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('部分达成预期指标并具有一定效果', '2', 'PMKPISELFINDEXVAL', '部分达成预期指标并具有一定效果', '1', null, null, '2016', '87', null, 'pmkpi', '0', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('未完成预期指标且效果较差', '3', 'PMKPISELFINDEXVAL', '未完成预期指标且效果较差', '1', null, null, '2016', '87', null, 'pmkpi', '0', 1, 1, null, null, 3);

--自评指标实际完成情况展现方式
delete from perf_t_systemset t where t.paramcode='SELFINDEXVAL';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('EFB06F18B6092B8BE0533315A8C0535B', 'SELFINDEXVAL', '自评价完成情况展现方式', '0', '1文本，其他下拉', 'pmkpi', 40, 2016, '87', 1);

--安徽监控报告导入-bgtget
delete from perf_t_imptemp where temptype = 'ahxmjxjkbg' and datatype = 'bgtget';
insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DE8CA1FE363E536AE0533315A8C09844', 'ahxmjxjkbg', 'bgtget', 9, 'name', 'amt1', 'amt2', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');





