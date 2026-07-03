begin

delete from perf_t_systemset t where t.paramcode='workevaluatetab';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('C84E8AE490F81989E0533315A8C0261E', 'workevaluatetab', '工作管理考核左侧树显示页签配置', '{"types":"subprovince,dept","dept":"","subprovince":"审核情况"}', 'types为页签类型，可根据页签进行按钮隐藏显示', null, 25, 2016, '87', 1);

delete from perf_filetype t where t.bustype='subprovinceworkeval';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C8B7928DDE806FB3E0533315A8C08CFB', '001', '绩效工作管理考核', null, '#', 1, 0, 1, 1, 'subprovinceworkeval', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C8B7928DDE836FB3E0533315A8C08CFB', '001001', '附件材料', null, 'C8B7928DDE806FB3E0533315A8C08CFB', 2, 1, 2, 1, 'subprovinceworkeval', null, null, 2016, '87');

delete from perf_t_datasource t where t.guid in('provincework','citywork');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('provincework', '002003', '省级预算绩效管理工作考核评分表', null, 'workscore', 1, 1, 7, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('citywork', '002004', '市级预算绩效管理工作考核评分表', null, 'workscore', 1, 1, 7, 'scoretype', 1, '20201204', '20201204', 2020, '87');

--绩效自评查询左侧树页签
delete from PERF_T_SYSTEMSET where paramcode  = 'selfquery';
insert into PERF_T_SYSTEMSET (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('F2CF93EF4CA8A7A5A9A0D1F5A79FF1CB', 'selfquery', '绩效自评查询左侧树页签', '{"types":"program,dept","dept":"查看项目","program":"预留隐藏按钮使用"}', 'types为页签类型，可根据页签进行按钮隐藏显示', null, 4, 2016, '87', 1);

--自评补充信息规则(自评分规则分为部门和项目)--start--
delete from perf_t_warnset where type in( 'selfscoreproject', 'selfresultproject', 'selfwarnproject','selfscoredept','selfresultdept','selfwarndept');
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('82D0DB61BF2C4141BAC71290DE2EF1EF', 'selfscoreproject', '自评得分-项目', 'selfscoreproject', 'select
     to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value
FROM
    (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a
    on a.pro_code = s.pro_code where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('42B24123FF9B4AEA8B2EF6AC467B1C69', 'selfresultproject', '自评结论-项目', 'selfresultproject', 'select
    case
        when nvl(s.score,0) + nvl(a.bgtscore,0) >= 90 then ''优''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then ''良''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then ''中''
        when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差''
    end as value
FROM
    (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a
    on a.pro_code = s.pro_code where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('D0BF549E6B3940DDB5481EA204E5EF1F', 'selfwarnproject', '自评预警-项目', 'selfwarnproject', 'select
    case
        when nvl(s.score,0) = 0 then ''''
        when  (nvl(s.score,0)/90-a.bgtscore/10)/(nvl(s.score,0)/90)>0.05 then ''red''
        when a.amt3 = 0 then ''yellow''
        when  (a.amt3-a.amt4)/a.amt3>0.2 then ''yellow''
    end value
FROM
    (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code, nvl(sum(amt3), 0) amt3, nvl(sum(amt4), 0) amt4 from v_perf_t_selfprofund group by pro_code) a
    on a.pro_code = s.pro_code where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

--部门
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E02E94E0533315A8C0F50E', 'selfresultdept', '自评结论-部门', 'selfresultdept', 'select
    case
        when nvl(s.score,0) + nvl(a.bgtscore,0) >= 90 then ''优''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then ''良''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then ''中''
        when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差''
    end as value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E12E94E0533315A8C0F50E', 'selfscoredept', '自评得分-部门', 'selfscoredept', 'select
     to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E22E94E0533315A8C0F50E', 'selfwarndept', '自评预警-部门', 'selfwarndept', 'select
    case
        when nvl(s.score,0) = 0 then ''''
        when  (nvl(s.score,0)/90-a.bgtscore/10)/(nvl(s.score,0)/90)>0.05 then ''red''
        when a.amt3 = 0 then ''yellow''
        when  (a.amt3-a.amt4)/a.amt3>0.2 then ''yellow''
    end value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid, nvl(sum(amt3), 0) amt3, nvl(sum(amt4), 0) amt4 from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');
--自评补充信息规则(自评分规则分为部门和项目)--end--


--整改通知左侧树页签
delete from perf_t_systemset where paramcode = 'rectification';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('BD80EC9A5434B1DF69472FF6BE0E0342', 'rectification', '监控整改通左侧树页签知编制', '{"types":"program,dept","dept":"查看项目","program":""}', 'types为页签类型，可根据页签进行按钮隐藏显示', null, 3, 2016, '87', 1);

delete from PERF_FILETYPE t where bustype in('feedback','rectification');
insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3330D06B92F0CAA7E053B11FA8C03BDD', '001', '项目附件', null, '#', 1, 0, 1, 1, 'feedback', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4440D06B92EFCAA7E053B11FA8C03BDD', '001001', '项目整改反馈附件', null, '3330D06B92F0CAA7E053B11FA8C03BDD', 2, 1, 2, 1, 'feedback', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1110D06B92F0CAA7E053B11FA8C03BDD', '001', '项目附件', null, '#', 1, 0, 1, 1, 'rectification', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2220D06B92EFCAA7E053B11FA8C03BDD', '001001', '项目整改附件', null, '1110D06B92F0CAA7E053B11FA8C03BDD', 2, 1, 2, 1, 'rectification', null, null, 2016, '87');

--导出模板配置-列配置-表字段数据源枚举--start--
delete from perf_t_datasource where elementcode='PMKPICOLUMNTYPES';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('s', 's', '文本', null, null, 1, 0, 1, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('i', 'i', '整数', null, null, 1, 0, 2, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('f', 'f', '小数', null, null, 1, 0, 3, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('d', 'd', '日期', null, null, 1, 0, 4, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('amt', 'amt', '金额', null, null, 1, 0, 5, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('tree', 'tree', '下拉选项', null, null, 1, 0, 6, 'PMKPICOLUMNTYPES', 1, '20210714', '20210714', 2016, '87');
--导出模板配置-列配置-表字段数据源枚举--end--

--审核结论
delete from perf_t_datasource t where t.elementcode ='PMKPICONCLUSION';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '通过', null, null, null, null, 1, 'PMKPICONCLUSION', 1, '20201229', '20201229', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '不通过', null, null, null, null, 2, 'PMKPICONCLUSION', 1, '20201229', '20201229', 2016, '87');

delete from perf_t_systemset t where t.paramcode='PDMWFSTSTUSTOINDEXOPINION';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('C9A7EEAF7E75320EE0533315A8C03A7D', 'PDMWFSTSTUSTOINDEXOPINION', '根据流程状态判断项目指标审核意见是否可录入', '{wfstatus:''0''}', '根据工作了状态判断项目指标审核意见是否可修改', null, 31, 2016, '87', 1);

--绩效监控  预算执行预警（proguid改为pro_code）
delete from perf_t_warnset t where type in('bgttracewarn');
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DB8540E3EF9A46E0B82BC415F11CD0AD', 'bgttracewarn', '预算执行预警', 'bgttracewarn', 'select case when value < 60 then ''red'' when 60 <= value and value < 80 then ''yellow'' when 80 <= value then ''green'' end value from (select (select replace(bgtget,''%'','''')bgtget from v_perf_fund_project where  pro_code=''#pro_code#'')/((#month#/12)*100)*100 value from dual) a', '20210420190843', null, '2016', '87');

delete from perf_t_systemset t where t.paramcode='DEPTBGTAUDIT';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('BF8784FA3E6B9FD5E053B11FA8C0F2AD', 'DEPTBGTAUDIT', '预算流程状态', '{"bgtwfstatus":"011","deptwfstatus":"011","czwfstatus":""}', 'bgtwfstatus预算终审状态，deptwfstatus部门绩效目标终状态，czwfstatus处室待审核状态', 'pmkpi', 12, 2016, '87', 1);

