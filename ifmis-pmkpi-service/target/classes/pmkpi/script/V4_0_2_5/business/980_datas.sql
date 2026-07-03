begin

--项目指标表status值改为null，不然调整有问题
update pm_perf_indicator t set t.status = null;
--部门指标表status值改为null，不然调整有问题
update bgt_perf_indicator t set t.status = null;

--添加是否广西模式系统参数
delete from perf_t_systemset where paramcode='IS_GUANGXI';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DB66CF8F342E5F9FE0533315A8C016E8', 'IS_GUANGXI', '判断是否是广西模式', '0', '1是其他否，默认为否', 'pmkpi', 26, 2016, '87', 1);

--页面配置维护 财政评价项目确定-关联项目-选择关联项目
delete from PERF_T_PAGEMENU where guid in ('405E34D8007716DD0A5680E3E0F3052E','D40AEAD1EF2E224C2340EF99439A3CF9','ACB103C743B4C10E22CC4AA0766781B3');
insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('405E34D8007716DD0A5680E3E0F3052E', '1', '选择关联项目', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'D613341C95461822E0533315A8C006A3', 6, 1, 1, 1, '20220413104020', '20220413104020', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');
insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('D40AEAD1EF2E224C2340EF99439A3CF9', '1', '查看评价成果', '/pmkpi/evaluation/financial/result/edit', 'D613341C953C1822E0533315A8C006A3', 4, 1, 1, 1, '20220413165920', '20220413165920', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');
insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('ACB103C743B4C10E22CC4AA0766781B3', '2', '查看项目明细', '/pmkpi/evaluation/financial/deptfill/proedit', 'D613341C95451822E0533315A8C006A3', 4, 1, 2, 1, '20220413165645', '20220413165645', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--分区初始化（导出模板表）
delete from bus_t_settmp t where t.tablecode in('v_perf_t_impexpmain','v_perf_t_impexpsub');
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('v_perf_t_impexpmain', 'guid', null, null, null, 1);

insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('v_perf_t_impexpsub', 'guid', null, null, null, 1);

--合肥原因类型
delete from perf_t_datasource t where t.elementcode ='REASONTYPE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '因政策调整影响项目实施或资金支付', null, null, null, null, 1, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '因疫情原因影响项目实施或资金支付', null, null, null, null, 2, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '因履行政府采购程序影响项目实施或资金支付', null, null, null, null, 3, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4', '4', '因其他不可控因素影响项目实施或资金支付', null, null, null, null, 4, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('5', '5', '根据计划安排项目暂未实施', null, null, null, null, 5, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('6', '6', '根据合同约定资金暂未支付', null, null, null, null, 6, 'REASONTYPE', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('7', '7', '其他原因', null, null, null, null, 7, 'REASONTYPE', 1, '20201224', '20201224', 2022, '87');

--绩效监控填报左侧树页签
delete from perf_t_treetab t where t.key in('/pmkpi/program/trace/report');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43973375E0533315A8C0E105', '/pmkpi/program/trace/report', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protracereporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43983375E0533315A8C0E105', '/pmkpi/program/trace/report', 'depttrace', '部门整体', 1, '导入,一般监控模板导出,一般监控导入', 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracereporthide');

--一般监控导入字段配置
delete from perf_t_impexpmain t where t.guid='traceordprogram';
insert into perf_t_impexpmain (GUID, CODE, NAME, PROVINCE, YEAR, TABLECODE, BEANID)
values ('traceordprogram', 'traceordprogram', '一般监控导入模板', '87', '2016', 'dual', 'pmkpi.perfprotrace.report.ProTraceTaskBOTX');

delete from perf_t_impexpsub t where t.mainguid='traceordprogram';
insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7DE5F55E0533315A8C05642', 'num', null, '序号', 1, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7145F55E0533315A8C05642', 'mof_dep_code', null, '处室名称', 2, '['''','''','''','''','''','''','''']', null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_project_info');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7155F55E0533315A8C05642', 'agency_code', 'VD00010', '单位名称', 3, null, '#code-#name', 'tree', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_project_info');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7165F55E0533315A8C05642', 'pro_cat_code', null, '项目类别', 4, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_project_info');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7175F55E0533315A8C05642', 'pro_code', null, '项目编码', 5, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_project_info');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7185F55E0533315A8C05642', 'pro_name', null, '支出项目名称', 6, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_project_info');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7195F55E0533315A8C05642', 'amt1', null, '年初预算数', 7, null, null, 'amt', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71A5F55E0533315A8C05642', 'amt7', null, '追加数', 8, null, null, 'amt', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71B5F55E0533315A8C05642', 'amt8', null, '追减数', 9, null, null, 'amt', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71C5F55E0533315A8C05642', 'amt3', null, '调整预算数', 10, null, null, 'amt', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71D5F55E0533315A8C05642', 'goal', null, '绩效目标', 11, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71E5F55E0533315A8C05642', 'amt4', null, '截止X月底支出数', 12, null, null, 'amt', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E71F5F55E0533315A8C05642', 'bgtget', null, '预算执行率', 13, null, null, 'n', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_probgtfund');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7205F55E0533315A8C05642', 'measures', null, '截止X月底绩效目标执行情况', 14, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_protraceanalysis');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7215F55E0533315A8C05642', 'xsjdwarn', 'glbenumwh', '是否达到序时支出进度', 15, null, '#code-#name', 'tree', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_protraceanalysis');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7225F55E0533315A8C05642', 'isgoal', 'glbenumwh', '是否达到阶段性绩效目标', 16, null, '#code-#name', 'tree', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_protraceanalysis');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7235F55E0533315A8C05642', 'reasontype', 'PMKPIREASONTYPE', '原因类型', 17, null, '#code-#name', 'tree', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_protraceanalysis');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7245F55E0533315A8C05642', 'deviation', null, '情况分析', 18, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_protraceanalysis');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE)
values ('DCE4AD04E7255F55E0533315A8C05642', 'adjustremark', null, '绩效目标调整情况', 19, null, null, 's', 'traceordprogram', null, '87', '2016', null, null, 'v_perf_t_adjustgoal');


 --财政个性分类授权部门 
delete from perf_t_systemset where PARAMCODE ='INDEXFINAGIVEDEPT';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DD27AB70D09F67B1E0533315A8C0F6B6', 'INDEXFINAGIVEDEPT', '财政个性分类授权部门', '2', '1、授权 2、不授权', null, 66, 2016, '87', 1);

