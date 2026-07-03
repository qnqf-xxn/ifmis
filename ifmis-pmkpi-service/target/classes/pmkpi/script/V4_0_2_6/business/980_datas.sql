begin

--自评自动计算得分规则
delete from PERF_T_WARNSET where type in('selfpositiveindex','selfequalindex','selfreverseindex','selfqualscorecheck');
insert into PERF_T_WARNSET (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DA61946DCA40101EE0533315A8C0D73D', 'selfpositiveindex', '正向指标-绩效自评', 'selfpositiveindex', 'select case when #actualvalue# >= #indexval# then #weight# when #actualvalue# < #indexval# then round((#actualvalue# / #indexval#) * #weight#, 2) end as value from dual', null, null, '2016', '87');
insert into PERF_T_WARNSET (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DA61946DCA3F101EE0533315A8C0D73D', 'selfequalindex', '等于指标-绩效自评', 'selfequalindex', 'select case when #indexval# = 0 then case when #actualvalue# <= 0 then #weight# when #actualvalue# > 0 then 0 end when #indexval# > 0 then case when #actualvalue# >= #indexval# then #weight# when #actualvalue# < #indexval# then round((#actualvalue#/#indexval#)*#weight#,2) end end as value from dual', null, null, '2016', '87');
insert into PERF_T_WARNSET (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DA61946DCA41101EE0533315A8C0D73D', 'selfreverseindex', '反向指标-绩效自评', 'selfreverseindex', 'select case when #actualvalue# <= #indexval# then #weight# when ( #indexval# < #actualvalue# and #actualvalue# < (2 * #indexval#) ) then round((1 - (#actualvalue# - #indexval#) / #indexval#) * #weight#,2) when #actualvalue# >= (2 * #indexval#) then 0 end as value from dual', null, null, '2016', '87');
insert into PERF_T_WARNSET (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DA61946DCA3E101EE0533315A8C0D73D', 'selfqualscorecheck', '定性指标区间校验-绩效自评', 'selfqualscorecheck', 'select case when ''#actualvalue#'' = ''达成年度指标'' then case when round(#weight# * 0.8, 2) <= #score# and #score# <= #weight# then ''1'' else ''权重*80%(含)-权重'' end when ''#actualvalue#'' = ''部分达成年度指标并具有一定效果'' then case when round(#weight# * 0.6, 2) <= #score# and #score# < round(#weight# * 0.8, 2) then ''1'' else ''权重*60%(含)-权重*80%'' end when ''#actualvalue#'' = ''未达成年度指标且效果较差'' then case when 0 <= #score# and #score# < round(#weight# * 0.6, 2) then ''1'' else ''0-权重*60%'' end else ''1'' end as value from dual', null, null, '2016', '87');

--安徽监控报告导入
delete from perf_t_imptemp t where temptype in('ahbmztjxjkbg','ahxmjxjkbg');
insert into perf_t_imptemp (GUID, TEMPTYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, DATATYPE, YEAR, PROVINCE)
values ('DEB399392DBD6073E0533315A8C0C34B', 'ahbmztjxjkbg', 8, 'name', 'amt1', 'amt7', 'amt4', 'bgtget', 'amt6', 'amt9', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'bgtget', '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, DATATYPE, YEAR, PROVINCE)
values ('DEB399392DBE6073E0533315A8C0C34B', 'ahbmztjxjkbg', 14, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'deviationanalysis', 'otherreasons', 'completeanalysis', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'index', '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, DATATYPE, YEAR, PROVINCE)
values ('DEB46397B59D74E2E0533315A8C03F45', 'ahbmztjxjkbg', 11, 'ndgoal', 'measures', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'analysis', '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, DATATYPE, YEAR, PROVINCE)
values ('DE8CA1FE363E536AE0533315A8C09844', 'ahxmjxjkbg', 9, 'name', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'bgtget', '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, DATATYPE, YEAR, PROVINCE)
values ('DE8D3F713B1A63CDE0533315A8C01D25', 'ahxmjxjkbg', 14, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'deviationanalysis', 'otherreasons', 'completeanalysis', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'index', '2016', '87');

--
delete from bus_t_settmp t where t.tablecode='v_perf_t_imptemp';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('v_perf_t_imptemp', 'guid', null, null, null, 1);

--安徽自评导入数据
delete from perf_t_imptemp t where t.temptype in('ahbmztzpmb','ahxmzczpmb');
insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF55857A04301D1BE0533315A8C09783', 'ahbmztzpmb', 'bgtget', 5, 'name', 'completion', 'amt3', 'amt5', 'amt4', 'amt6', 'scores', 'bgtget', 'score', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF55857A04311D1BE0533315A8C09783', 'ahbmztzpmb', 'desc1', 6, 'yeargoal', 'allyeargoal', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF55857A04321D1BE0533315A8C09783', 'ahbmztzpmb', 'desc2', 7, 'deviationanaly', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF55857A04351D1BE0533315A8C09783', 'ahbmztzpmb', 'index', 8, 'findex', 'sindex', 'name', 'actualweight', 'indexval', 'actualvalue', 'score', 'kpi_remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF31D6002B5F7D21E0533315A8C0D81E', 'ahxmzczpmb', 'bgtget', 9, 'name', 'amt1', 'amt3', 'amt4', 'actualweight', 'bgtget', 'score', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF31D6002B617D21E0533315A8C0D81E', 'ahxmzczpmb', 'desc', 13, 'yeargoal', 'allyeargoal', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DF31D6002B607D21E0533315A8C0D81E', 'ahxmzczpmb', 'index', 15, 'findex', 'sindex', 'name', 'indexval', 'actualvalue', 'actualweight', 'score', 'kpi_remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

--湖北部门指标导入，项目类型数据源
delete from fasp_t_dicdssource where code ='INDEXCOMFUNCHuBei';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNCHuBei', 'INDEXCOMFUNCHuBei', 'INDEXCOMFUNCHuBei', '湖北指标导入模板项目类型分类', '1', '20140422000000000', '20150423', null, '2020', '87', null, '8717', '1', '2', 'select * from perf_t_indexcomfunc t where t.year = ''2016'' and t.province = ''87'' and code not in(''02'')  order by code', null, 1, 'pmkpi');

--合肥监控导入配置
delete from perf_t_imptemp t where t.temptype in('hfxmzczdjkmb','hfbmztjkmb');
insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC802531E0533315A8C03422', 'hfxmzczdjkmb', 'bgtget', 8, 'amt1', 'amt7', 'amt8', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC812531E0533315A8C03422', 'hfxmzczdjkmb', 'analysis', 10, 'yeargoal', 'measures', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC822531E0533315A8C03422', 'hfxmzczdjkmb', 'index', 13, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'completeanalysis', 'otherreasons', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC842531E0533315A8C03422', 'hfbmztjkmb', 'bgtget', 7, 'amt1', 'amt7', 'amt8', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC852531E0533315A8C03422', 'hfbmztjkmb', 'analysis', 9, 'yeargoal', 'measures', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC862531E0533315A8C03422', 'hfbmztjkmb', 'index', 12, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'completeanalysis', 'otherreasons', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

--监控左侧页签
delete from perf_t_treetab t where t.key='/pmkpi/program/trace/query' and t.code='depttrace';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439B3375E0533315A8C0E105', '/pmkpi/program/trace/query', 'depttrace', '部门整体', 1, '一般监控导出（合肥）', 2, '2016', '87', null, 'depttracequeryhide');

delete from perf_t_treetab t where t.key='/pmkpi/program/trace/report' and t.code='depttrace';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43983375E0533315A8C0E105', '/pmkpi/program/trace/report', 'depttrace', '部门整体', 1, '导入,一般监控模板导出,一般监控导入', 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracereporthide');

--页面配置一般项目监控
delete from perf_t_pagemenu t where t.guid='BFEDD90AE5631869E053470A050A5B72';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('BFEDD90AE5631869E053470A050A5B72', '3', '阶段监控填报', '/pmkpi/trace/report/proedit/ordwarn', 'BFEDD90AE55F1869E053470A050A5B72', 4, 1, 3, 1, '20210414205334', '20210414205334', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--问题整改 --选择项目，查询区自评结论 优良差数据源
delete from fasp_t_dicdssource where code ='PMKPISELFRESULT';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPISELFRESULT', 'PMKPISELFRESULT', 'PMKPISELFRESULT', '绩效自评结论', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''selfresult'' order by ordernum', null, 1, 'pmkpi');

