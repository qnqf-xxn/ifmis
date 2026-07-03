begin

delete from fasp_t_dicdssource t where t.guid='VIEWCODE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('VIEWCODE', 'VIEWCODE', 'VIEWCODE', '审核定义视图表', '1', null, null, null, '2016', '87', null, null, '1', '2', 'select t.guid,t.name,t.code,1 as status from v_perf_t_customauditview t', sysdate, 1, 'pmkpi');


delete from fasp_t_dicdssource where guid in ('LINES','EVALUATEMODE','JXFUNDTYPE','EVALUATETYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('LINES', 'LINES', 'LINES', '线上线下', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''LINES'' order by t.ordernum', null, null, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('JXFUNDTYPE', 'JXFUNDTYPE', 'JXFUNDTYPE', '项目资金性质', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''FUNDTYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EVALUATETYPE', 'EVALUATETYPE', 'EVALUATETYPE', '评价类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''EVALUATETYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EVALUATEMODE', 'EVALUATEMODE', 'EVALUATEMODE', '评价组织实施方式', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''EVALUATEMODE'' order by t.ordernum', null, null, 'pmkpi');



delete from perf_enum where elementcode in ('LINES','EVALUATEMODE','FUNDTYPE','EVALUATETYPE');
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATETYPE01', '01', 'EVALUATETYPE', '政策评价', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATETYPE02', '02', 'EVALUATETYPE', '项目评价', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDTYPE01', '01', 'FUNDTYPE', '一般公共预算', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDTYPE02', '02', 'FUNDTYPE', '政府性基金', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDTYPE03', '03', 'FUNDTYPE', '国有资本经营预算', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 3);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEMODE01', '01', 'EVALUATEMODE', '自评', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEMODE02', '02', 'EVALUATEMODE', '委托第三方', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('LINES01', '01', 'LINES', '部门预算', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('LINES02', '02', 'LINES', '对下转移支付', '1', '20230213103427', '20230213103427', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

--自评价-结转项目待办配置
delete from perf_pendingtask t where key in('/pmkpi/perfself/transfer/apply','/pmkpi/perfself/transfer/audit');
insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('F5AA38A38F254FE7E0533315A8C0CB44', '/pmkpi/perfself/transfer/apply', '结转项目绩效自评填报--被退回', 1, '87', 2016, '{agency: "treeroot",
bustype: "transprogram",
isleaf: "0",
leftmenuid: "F4A40680B92B7C1BE0533315A8C03265",
menuid: "F4A40680B92B7C1BE0533315A8C03265",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 'back', '1', 'pmkpi.perfSelf.PerfSelfApplyBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('F5AA38A38F264FE7E0533315A8C0CB44', '/pmkpi/perfself/transfer/audit', '结转项目绩效自评审核--待审核', 1, '87', 2016, '{agency: "treeroot",
isleaf: "0",
leftmenuid: "F4A40680B92F7C1BE0533315A8C03265",
lefttabtype: "transprogram",
menuid: "F4A40680B92F7C1BE0533315A8C03265",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', null, '1', 'pmkpi.perfSelf.PerfSelfAuditBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('F5AA38A38F244FE7E0533315A8C0CB44', '/pmkpi/perfself/transfer/apply', '结转项目绩效自评填报--待送审', 1, '87', 2016, '{agency: "treeroot",
bustype: "transprogram",
isleaf: "0",
leftmenuid: "F4A40680B92B7C1BE0533315A8C03265",
menuid: "F4A40680B92B7C1BE0533315A8C03265",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', null, '1', 'pmkpi.perfSelf.PerfSelfApplyBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('F5AA38A38F274FE7E0533315A8C0CB44', '/pmkpi/perfself/transfer/audit', '结转项目绩效自评审核--被退回', 1, '87', 2016, '{agency: "treeroot",
isleaf: "0",
leftmenuid: "F4A40680B92F7C1BE0533315A8C03265",
lefttabtype: "transprogram",
menuid: "F4A40680B92F7C1BE0533315A8C03265",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 'back', '1', 'pmkpi.perfSelf.PerfSelfAuditBOTX', 'getVodSql');

--指标库工作流
update perf_t_treetab t set t.leftwfid='2F62B0E1A972408B8330D3653F836522' where t.key in('/pmkpi/index/audit','/pmkpi/indexlib/deptlist');

--展示页签数量关闭
update perf_t_systemset t set t.paramvalue='2' where t.paramcode='isShowTabPendingTask';


--权限中间表改为分区视图 v_pmkpi_t_uservagency
delete from pmkpi_t_datarule where guid in ('uservagency','uservbusoffice','uservbackoffice');
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservagency', '用户对单位权限(设置中间表)', 'pub', ' exists (select 1 from v_pmkpi_t_uservagency agen where agen.agency = ruletable.agencyguid and agen.userguid = ''#curruser#'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservbusoffice', '用户对处室权限(设置中间表)', 'pub', ' exists (select 1 from v_pmkpi_t_uservagency agen where agen.agency = ruletable.finintorgguid and agen.userguid = ''#curruser#'') ', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservbackoffice', '用户对资金归口处室权限(设置中间表)', 'pub', ' exists (select 1 from v_pmkpi_t_uservagency agen where agen.agency = ruletable.finintorgguid and agen.userguid = ''#curruser#'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);


--财政评价项目审核页面leftmenuid配置修改（之前配置的是成果审核页面leftmenuid）
update perf_t_treetab set leftmenuid = 'programfinaudithide' where key = '/pmkpi/evaluation/financial/audit' and code = 'program';
update perf_t_treetab set leftmenuid = 'deptfinaudithide' where key = '/pmkpi/evaluation/financial/audit' and code = 'dept';