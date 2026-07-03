begin
  delete from Perf_t_Deptamt t where t.province = '87' and t.year = 2016;
  insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('incomamt1', null, 'incamt', '收入构成', '财政拨款', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 1);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('incomamt2', null, 'incamt', '收入构成', '财政专户管理资金', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 2);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('incomamt3', null, 'incamt', '收入构成', '单位资金', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 3);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('incomamt', null, 'incamtsum', '收入构成', '合计', null, 100.0000, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 4);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('expamt1', null, 'expamt', '支出构成', '人员类项目支出', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 5);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('expamt2', null, 'expamt', '支出构成', '运转类项目支出', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 6);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('expamt3', null, 'expamt', '支出构成', '特定目标类项目支出', null, null, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 7);

insert into Perf_t_Deptamt (GUID, AGENCYGUID, AGENCYNAME, TYPENAME, FUNDNAME, YEARAMT, RATE, FAMT, SAMT, MAINGUID, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR, IS_DELETED, ORDERNUM)
values ('expamt', null, 'expamtsum', '支出构成', '合计', null, 100.0000, null, null, null, '20220509115547', '20220509115547', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016, 2, 8);

update p#Busfw_t_Uicolumn t set t.name = '支出项目类别' where t.key = '/pmkpi/deptperformance/report/deptproexp' and t.columncode = 'PROTYPE';
update p#Busfw_t_Uicolumn t set t.requirement = 1 where t.key = '/pmkpi/deptperformance/report/deptperf' and t.columncode in ('KPI_CONTENT','KPI_EVALSTD');