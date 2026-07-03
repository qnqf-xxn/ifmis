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


