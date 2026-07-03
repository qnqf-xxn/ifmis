begin

delete from perf_t_treetab t ;
insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E251C61F2CE0533315A8C01585', '/pmkpi/workevaluate/report/list', 'subprovince', '下级财政', 1, '审核情况', 1, 2016, 87, 'C88ABD0AB41D140CE0533315A8C0DBFE', 'subprovinceworkreporthide');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E251C71F2CE0533315A8C01585', '/pmkpi/workevaluate/report/list', 'dept', '部门整体', 1, null, 2, 2016, 87, 'C33452C06CA5C699E053B11FA8C0AACB', 'deptworkreporthide');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252091F2CE0533315A8C01585', '/pmkpi/workevaluate/audit/list', 'subprovince', '下级财政', 1, '审核情况', 1, 2016, 87, 'C88ABD0AB41D140CE0533315A8C0DBFE', 'subprovinceworketaskaudithide');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E2520A1F2CE0533315A8C01585', '/pmkpi/workevaluate/audit/list', 'dept', '部门整体', 1, null, 2, 2016, 87, 'C33452C06CA5C699E053B11FA8C0AACB', 'deptworketaskaudithide');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E2528F1F2CE0533315A8C01585', '/pmkpi/workevaluate/query/list', 'subprovince', '下级财政', 1, '审核情况', 1, 2016, 87, null, 'subprovinceworkevaluatequeryhide');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01585', '/pmkpi/workevaluate/query/list', 'dept', '部门整体', 1, '审核情况', 2, 2016, 87, null, 'deptworkevaluatequeryhide');

--左侧树表配置添加分区同步表
delete from bus_t_settmp t where t.tablecode='v_perf_t_treetab';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('v_perf_t_treetab', 'guid', null, null, null, 1);

--添加是否湖北模式系统参数
delete from perf_t_systemset t where t.paramcode='IS_HUBEI';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('CC289937D29153DBE0533315A8C0AFFC', 'IS_HUBEI', '判断是否是湖北模式', '0', '1是其他否，默认为否', 'pmkpi', 36, 2016, '87', 1);


--添加是否天津模式系统参数
delete from perf_t_systemset t where t.paramcode ='IS_TIANJIN';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DD289937D29153DBE0533315A8C0AFFC', 'IS_TIANJIN', '判断是否是天津模式', '0', '1是其他否，默认为否', 'pmkpi', 28, 2016, '87', 1);


--数据权限
delete from pmkpi_t_datarule t where t.guid in('tjqh','sjqh','sjxsyzqh','xjqh');
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('tjqh', '同级区划', 'pub', ' ruletable.province like SUBSTR(''#province#''，0，length(''#province#'')-7)||''%'' and ruletable.province not like ''%999'' and exists(select 1 from V_ELE_VD08001 prov where prov.guid=ruletable.province and prov.levelno = (select levelno from V_ELE_VD08001 where guid = ''#province#''))', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('sjqh', '上级区划', 'pub', ' ruletable.province = SUBSTR(''#province#''，0，length(''#province#'')-5)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('sjxsyzqh', '上级下所有子区划', 'pub', ' ruletable.province like SUBSTR(''#province#''，0，length(''#province#'')-5)||''%''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('xjqh', '下级区划', 'pub', ' ruletable.province not like ''%999'' and exists(select * from V_ELE_VD08001 prov where prov.superguid = (select case when superguid =''#'' then guid else superguid end superguid from V_ELE_VD08001 where guid = ''#province#'') and t.superguid=prov.guid)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

--河北监控报告

DELETE FROM perf_filetype t WHERE t.bustype='hbtracereportupload';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4E1F054AE33F4A9493664319BF1A0BEC', '001', '监控汇总资料', null, '#', 1, 0, 1, 1, 'hbtracereportupload', '20210403204753', '20210403204753', 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4FDEAAA55D98435D9694AF2DB7336E87', '001001', '监控汇总报告', null, '4E1F054AE33F4A9493664319BF1A0BEC', 2, 1, 2, 1, 'hbtracereportupload', '20210403204753', '20210403204753', 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F3D228023A3E463890E93A399309906C', '001002', '其他相关监控资料', null, '4E1F054AE33F4A9493664319BF1A0BEC', 2, 1, 3, 1, 'hbtracereportupload', '20210403204753', '20210403204753', 2016, '87');
