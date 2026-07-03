begin


delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/deptperformance/report/edit' and t.id='perftargetdatatable';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftarget'',headsort:false,addrow:true,name:''年度绩效目标'',edit:true,checkbox:true,title:''年度绩效目标'',initlevel:6,isuphide:false,nextSibling:false}', 'perftargetdatatable', 'pmkpi', null);


--审核菜单
DELETE FROM Perf_t_Auditdefinemenu t where t.code='20001005';
insert into Perf_t_Auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B35BBB0E413B34A6E055000000000001', '20001005', '年度绩效目标', null, 'E612AE4B4B6546F2BAAEB3E7CF8B9567', 3, 1, 5, 1, '1', '20200919105515', null, '87', 2020);


