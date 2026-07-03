begin

--项目监控预算执行
delete from perf_t_fundtemp t where t.year='2016' and t.province='87';
insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('B73C570FE6D745C3E0530100007F63AC', 'totalamt', '预计全年资金结余', null, null, null, '20160826165404066', 2016, '87', null, null, '合计', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('B73C570FE6D845C3E0530100007F63AC', 'amt1', '预计全年资金结余', null, null, null, '20160826165404069', 2016, '87', null, null, '小计', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('B73C570FE6D945C3E0530100007F63AC', 'amt2', '预计全年资金结余', null, null, null, '20160826165404071', 2016, '87', null, null, '中央级', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('7AB7D63F956A49D39ED0C8A2DCE7F6CD', 'amt3', '预计全年资金结余', null, null, null, '20160826165404052', 2016, '87', null, null, '省级', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('063156D6D71A4144A8DFCF52076F15DD', 'amt4', '预计全年资金结余', null, null, null, '20160826165404055', 2016, '87', null, null, '地市级', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('593FBA5A75084ED29BF7347EC8098540', 'amt5', '预计全年资金结余', null, null, null, '20160826165404058', 2016, '87', null, null, '小计', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('399E138B58E44874905CD24EC938C024', 'amt6', '预计全年资金结余', null, null, null, '20160826165404060', 2016, '87', null, null, '单位自筹', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('0A4C132AE5B44BE0B488106484EE5A92', 'amt7', '预计全年资金结余', null, null, null, '20160826165404063', 2016, '87', null, null, '银行贷款', 5, '1');

insert into perf_t_fundtemp (GUID, CODE, NAME, QUERYSQL, SUMCOL, UPDATETIME, CREATETIME, YEAR, PROVINCE, AMT, FUNDTYPE, FUNDNAME, ORDERNUM, ISEDIT)
values ('BC9A94862FEF4D4BA82CD37D3B5E9449', 'amt8', '预计全年资金结余', null, null, null, '20160826165404066', 2016, '87', null, null, '社会资金', 5, '1');

--审核定义菜单
delete from perf_t_auditdefinemenu t where t.guid in('B7279B405D6C7EB4E0530100007FD738','B74D29A870344446E0530100007F1A5A','B760B51D6FA06B86E0530100007F27AE','B760B51D6F9E6B86E0530100007F27AE');
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B7279B405D6C7EB4E0530100007FD738', '007003001', '基本信息', null, 'B5A085C812D00888E0535164A8C0487E', 3, 1, 1, 1, '1', '20201230042115', null, '87', 2020);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B74D29A870344446E0530100007F1A5A', '007003002', '预算执行情况', null, 'B5A085C812D00888E0535164A8C0487E', 3, 1, 2, 1, '1', '20201230042115', null, '87', 2020);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B760B51D6F9E6B86E0530100007F27AE', '007003004', '监控分析', null, 'B5A085C812D00888E0535164A8C0487E', 3, 1, 4, 1, '1', '20201230042116', null, '87', 2020);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B760B51D6FA06B86E0530100007F27AE', '007003003', '绩效目标完成情况', null, 'B5A085C812D00888E0535164A8C0487E', 3, 1, 3, 1, '1', '20201230042116', null, '87', 2020);

--预警规则
delete from perf_t_warnset t where 1 = 1;
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('BA5BCAA67FF70D8BE053B11FA8C07179', 'depttracewarn', '合肥部门监控预警', 'depttracewarn', 'select case when a.value1 = ''yes'' and a.value2=''1'' then ''green'' when a.value1 = ''yes'' and a.value2=''0'' then ''yellow'' when a.value1 = ''no'' and a.value2=''1'' then ''red'' when a.value1 = ''no'' and a.value2=''0'' then ''red'' end value from (select ''#isexpfunc# '' value1, ''#isperfgoal#'' value2 from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('434BA1A7F44A47DAB115B85F9E40DED1', 'positiveindex01', '正向指标', 'positiveindex', 'select case when value < 60 then ''red'' when 60 <= value and value < 80 then ''yellow'' when 80 <= value and value < 120 then ''green'' when value > =120 then ''blue'' end value from (select #indexval#/(#targetvalue#/12*#month#)*100 value from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('88A1F226D98E4ACD924B7F59B65620A1', 'reverseindex02', '反向指标小于等于', 'reverseindex', 'select case when value<=#targetvalue# then ''green'' else ''red'' end value from (select #indexval# value from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('563FD5339CE04035BB2BA9F120F2241C', 'qualitativeindex03', '定性指标', 'qualitativeindex', 'select case when value=''达成目标'' then ''green'' when value=''部分达成目标并具有一定效果'' then ''yellow'' when value=''未达成目标且效果较差'' then ''red'' end value from (select ''#indexval# ''value from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DB8540E3EF9A46E0B82BC415F11CD0AD', 'bgttracewarn', '预算执行预警', 'bgttracewarn', 'select case when value < 60 then ''red'' when 60 <= value and value < 80 then ''yellow'' when 80 <= value then ''green'' end value from (select (select replace(bgtget,''%'','''')bgtget from v_perf_fund_project where  proguid=''#proguid#'')/((#month#/12)*100)*100 value from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('9C45001EBE3446649D719D6569905860', 'goalwarn', '目标执行预警', 'goalwarn', 'select case when instr(WM_CONCAT(warn), ''red'') > 0 then ''red'' when instr(WM_CONCAT(warn), ''yellow'') > 0 then ''yellow'' when instr(WM_CONCAT(warn), ''green'') > 0 then ''green'' when instr(WM_CONCAT(warn), ''blue'') > 0 then  ''blue'' end value from (select warn from v_perf_t_proindextrace t group by mainguid, warn having t.mainguid = ''#mainguid#'') a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('2EC5F43B3EAE4F9787798DF770B3C97B', 'reverseindex02', '反向指标小于', 'reverselessindex', 'select case when value<#targetvalue# then ''green'' else ''red'' end value from (select #indexval# value from dual) a', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('BA6668DFDFB61167E053B11FA8C08965', 'protracewarn', '合肥部门监控预警', 'protracewarn', 'select case when a.value1 = ''yes'' and a.value2=''1'' then ''green'' when a.value1 = ''yes'' and a.value2=''0'' then ''yellow'' when a.value1 = ''no'' and a.value2=''1'' then ''red'' when a.value1 = ''no'' and a.value2=''0'' then ''red'' end value from (select ''#isexpfunc# '' value1, ''#isperfgoal#'' value2 from dual) a', null, null, '2016', '87');


--审核定义菜单
delete from perf_t_auditdefinemenu t where guid in('B9B1886CA7A600A1E053B11FA8C0DBA4','B9B1886CA7A700A1E053B11FA8C0DBA4','B9D8BDAA8B2FDDAEE053B11FA8C04101','B9D8BDAA8B30DDAEE053B11FA8C04101');
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B9B1886CA7A600A1E053B11FA8C0DBA4', '008001001', '项目调整目标', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 1, 1, '1', '20210129115939', null, '87', 2021);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B9B1886CA7A700A1E053B11FA8C0DBA4', '008001002', '项目调整指标', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 2, 1, '1', '20210129115939', null, '87', 2021);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B9D8BDAA8B2FDDAEE053B11FA8C04101', '008001003', '部门调整目标', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 3, 1, '1', '20210129115939', null, '87', 2021);

insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B9D8BDAA8B30DDAEE053B11FA8C04101', '008001004', '部门调整指标', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 4, 1, '1', '20210129115939', null, '87', 2021);


--系统配置
delete from perf_t_systemset t where t.guid in('B9DD48E616D24744E053B11FA8C01BA3','B9ED1F7009C72EC2E053B11FA8C00E35','B2172C9A2E795C4FE0539E1E380A5987','BC763EBA1671FC3BE053B11FA8C02423');
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('B9DD48E616D24744E053B11FA8C01BA3', 'isadjust', '绩效目标调整是否替换项目目标/指标', '1', '1替换2不替换', null, 10, 2016, '87', 1);

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('B9ED1F7009C72EC2E053B11FA8C00E35', 'adjusthide', '绩效目标调整填报页隐藏主键，填写组件id多个用逗号隔开', ',', '页签组件名称：tabpage', null, 11, 2016, '87', 1);

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('B2172C9A2E795C4FE0539E1E380A5987', 'PERFREVIEISFILEDIV', '第三方评审推送是否显示文件', '1', '0不显示1显示', null, 12, 2016, '87', 1);

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('BC763EBA1671FC3BE053B11FA8C02423', 'REVIEWSHOWTAB', '目标评审指标显示', '1', '1显示总和年度2显示年度', null, 13, 2016, '87', 1);


--数据权限
DELETE FROM pmkpi_t_datarule t where t.guid in ('jgps','zjcj');
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('zjcj', '专家创建', 'pub', ' guid in (SELECT t.MAINGUID FROM v_PERF_EXPERTREVIEW t  where t.MAINGUID is not null and t.expertguid= ''#curruser#'' )', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('jgps', '机构评审', 'pub', ' guid in (SELECT t.review FROM V_PERF_REVIEWINTERMEDIARY t  where t.intermediary = ''#curruser#'' )', '20180531172208210', '20180531172208210', 1, 0, '87', 0);


delete from perf_t_systemset t where t.guid='BCC749CFE993EAF2E053480A050A3A41';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('BCC749CFE993EAF2E053480A050A3A41', 'isProview', '是否项目库绩效目标评审', '1', '1是其他否', null, 10, 2016, '87', 1);

delete from perf_t_datasource t  where t.elementcode='perftask' and code like '02%';

--预警规则表内置为刷新分区同步
delete from bus_t_settmp t where t.tablecode='V_PERF_T_WARNSET';

insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_WARNSET', 'guid', '', '', '', 1);

delete from bus_t_settmp t where t.tablecode='V_PERF_T_SYSTEMSET';

insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_SYSTEMSET', 'guid', '', '', '', 1);

delete from fw_t_sysapp t where t.appid = 'pmkpi';
insert into fw_t_sysapp (APPID, APPNAME, STATUS, DEVELOPER, DBVERSION, ISBGT, ISCOMMONMENU, DIIDE, ORDERNUM)
values ('pmkpi', '预算绩效管理', null, 'LT', sysdate, 0, null, null, null);


UPDATE perf_enum t set t.code='1' where t.guid='B9C7D80EC03A8933E053B11FA8C0A5D6' and t.elementcode='REVIEWOPINION';
UPDATE perf_enum t set t.code='2' where t.guid='B9C7D80EC03B8933E053B11FA8C0A5D6' and t.elementcode='REVIEWOPINION';
UPDATE perf_enum t set t.code='3' where t.guid='B9C7D80EC03C8933E053B11FA8C0A5D6' and t.elementcode='REVIEWOPINION';
UPDATE perf_enum t set t.code='4' where t.guid='B9C7D80EC03D8933E053B11FA8C0A5D6' and t.elementcode='REVIEWOPINION';
