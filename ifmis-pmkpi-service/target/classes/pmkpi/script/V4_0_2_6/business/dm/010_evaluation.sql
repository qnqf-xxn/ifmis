begin
  
  --左侧树页签
delete from perf_t_treetab where key in('/pmkpi/seeting/evaluation/query','/pmkpi/seeting/evaluation/audit','/pmkpi/seeting/evaluation/report');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1F735B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/query', 'dept', '部门整体', 0, '查看项目', 2, '2016', '87', 'DEA8CCDA52BD3F37E0533315A8C07D09', 'deptevaluationqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1F835B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/query', 'program', '项目支出', 1, null, 1, '2016', '87', 'DEA8A8BEF3143C0AE0533315A8C0D7DA', 'programevaluationqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1F935B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/audit', 'dept', '部门整体', 0, '查看项目', 2, '2016', '87', 'DEA8CCDA52BD3F37E0533315A8C07D09', 'deptevaluationaudithide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1FA35B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/audit', 'program', '项目支出', 1, null, 1, '2016', '87', 'DEA8A8BEF3143C0AE0533315A8C0D7DA', 'programevaluationaudithide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1FB35B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/report', 'dept', '部门整体', 0, '查看项目', 2, '2016', '87', 'DEA8CCDA52BD3F37E0533315A8C07D09', 'deptevaluationhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DEF9ABFAD1FC35B1E0533315A8C02EAA', '/pmkpi/seeting/evaluation/report', 'program', '项目支出', 1, null, 1, '2016', '87', 'DEA8A8BEF3143C0AE0533315A8C0D7DA', 'programevaluationhide');



  --附件类型
delete from perf_filetype where bustype ='evaluatereport';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('DEF4883808AF4613E0533315A8C0BC2A', '001', '附件材料', null, '#', 1, 0, 1, 1, 'evaluatereport', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('DEF4883808B04613E0533315A8C0BC2A', '001001', '事前绩效评估结果单位盖章扫面件(单位上传)', null, 'DEF4883808AF4613E0533315A8C0BC2A', 2, 1, 2, 1, 'evaluatereport', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('DEF4883808B14613E0533315A8C0BC2A', '001002', '事前绩效再评估结果附件(业务处室上传)', null, 'DEF4883808AF4613E0533315A8C0BC2A', 2, 1, 3, 1, 'evaluatereport', null, null, 2016, '87');

--流程表
delete from p#busfw_t_dcworkflowplan where tablecode ='PERF_T_EVALUATION';
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('DEA8A8BEF3143C0AE0533315A8C0D7DA', 'PERF_T_EVALUATION', 'PERF_T_EVALUATION', '事前绩效评估申报（项目）', '1', '2016', '87', null, null, '事前绩效评估申报（项目）', null, '20210421102117739', 'B876713347C31372A297A0234F30FFB8');
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('DEA8CCDA52BD3F37E0533315A8C07D09', 'PERF_T_EVALUATION', 'PERF_T_EVALUATION', '事前绩效评估申报（部门）', '1', '2016', '87', null, null, '事前绩效评估申报（部门）', null, '20210421102117739', 'B876713347C31372A297A0234F30FFB8');

--审核定义视图
delete from perf_t_auditdefine where guid in('7D2AECE42BA4A572601AF1B013E5B976','1F5883C511D20B91C4C6E33ABEDAC191');
insert into perf_t_auditdefine (GUID, CODE, NAME, EXPLAIN, YEAR, AGENCYGUID, WFID, WFSTATUS, CREATER, CREATETIME, UPDATETIME, PROVINCE, ORDERNUM, STATUS, "procedure", AUDITDETYPE, ISALLTABLE, RECORDADOPT, CHECKFLAG, VIEWGUID, AUDITBEANID, REMARK, AUDITSQL)
values ('7D2AECE42BA4A572601AF1B013E5B976', '5', '事前绩效评估送审校验', '评估事项、评估结果必填', 2016, null, null, null, '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '20220516142736', '20220516164742', '87', null, 1, null, 'singletable', 0, 1, null, '71E1711A49ABC1479EE00E9882A932E1', null, 0, 'select * from  perf_audit_v_evaluation where #AUTHRULE# ');
insert into perf_t_auditdefine (GUID, CODE, NAME, EXPLAIN, YEAR, AGENCYGUID, WFID, WFSTATUS, CREATER, CREATETIME, UPDATETIME, PROVINCE, ORDERNUM, STATUS, "procedure", AUDITDETYPE, ISALLTABLE, RECORDADOPT, CHECKFLAG, VIEWGUID, AUDITBEANID, REMARK, AUDITSQL)
values ('1F5883C511D20B91C4C6E33ABEDAC191', '6', '事前绩效评估结果单位盖章附件', '事前绩效评估结果单位盖章扫描件必传', 2016, null, null, null, '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '20220516152907', '20220516165736', '87', null, 1, null, 'singletable', 1, 1, null, 'EAC38B1B85372276F200D403DD7D4B29', null, 0, 'select * from  perf_audit_v_evaluationfile where #AUTHRULE# ');

--自定义视图
delete from PERF_T_CUSTOMAUDITVIEW where code in('perf_audit_v_evaluation','perf_audit_v_evaluationfile');
insert into PERF_T_CUSTOMAUDITVIEW (GUID, CODE, NAME, CLASSIFY, CREATETIME, UPDATETIME, STATUS, YEAR, PROVINCE, APPID, CHECKSQL, REMARKBF, REMARK)
values ('71E1711A49ABC1479EE00E9882A932E1', 'perf_audit_v_evaluation', '事前绩效评估送审校验', null, '2022-05-16', null, 1, 2016, '87', null, 'select guid as busguid  from V_PERF_T_EVALUATION t  where t.result is null or t.items is null', null, null);

insert into PERF_T_CUSTOMAUDITVIEW (GUID, CODE, NAME, CLASSIFY, CREATETIME, UPDATETIME, STATUS, YEAR, PROVINCE, APPID, CHECKSQL, REMARKBF, REMARK)
values ('EAC38B1B85372276F200D403DD7D4B29', 'perf_audit_v_evaluationfile', '事前绩效评估结果单位盖章附件', null, '2022-05-16', '2022-05-16', 2, 2016, '87', null, 'select pf.BILLGUID as busguid from perf_filetype t
  left join (select *
               from v_PERF_FILE
              where BILLGUID = ''8F8FEFA7D43AA9A887DACDD9A5AC4C6B'') pf
    on t.guid = pf.filetype
 where t.bustype = ''evaluatereport'' and t.guid =''DEF4883808B04613E0533315A8C0BC2A''
 and filename is null', null, null);



--数据源
delete from perf_t_datasource where elementcode = 'evaluationaudittype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '001', '通过', null, null, null, null, 1, 'evaluationaudittype', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '002', '再评估', null, null, null, null, 2, 'evaluationaudittype', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '不通过', null, null, null, null, 3, 'evaluationaudittype', 1, '20201229', '20201229', 2016, '87');

delete fasp_t_dicdssource where guid in('EVALUATIONAUDITTYPE','PMKPIAUDITTYPECFG');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EVALUATIONAUDITTYPE', 'EVALUATIONAUDITTYPE', 'EVALUATIONAUDITTYPE', '事前绩效评估审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''evaluationaudittype'' order by t.ordernum', null, 1, 'pmkpi');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', '绩效审核流程配置', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"opinion",code:"opinion",name:"意见审核"},{guid:"nature",code:"nature",name:"四性审核"},{guid:"traceopinion",code:"traceopinion",name:"监控审核"},{guid:"evaluation",code:"evaluation",name:"评估审核"}]', sysdate, null, null);


--系统参数
delete from perf_t_systemset where paramcode ='EVALUATIONFILE';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('C3614485AC72AC5115B9FA2C8E3F25A2', 'EVALUATIONFILE', '控制事前绩效评估审核附件页面是否可编辑', '{"isedit":""}', '业务处审核岗，附件页面可编辑，业务处审核方法选择再评估时需要业务处上传附件', null, 3, 2016, '87', 1);
