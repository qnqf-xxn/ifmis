begin

delete from PERF_T_AUDITDEFINE where code ='checkTJdeptPerf';

insert into PERF_T_AUDITDEFINE (GUID, CODE, NAME, EXPLAIN, YEAR, AGENCYGUID, WFID, WFSTATUS, CREATER, CREATETIME, UPDATETIME, PROVINCE, ORDERNUM, STATUS, "procedure", AUDITDETYPE, ISALLTABLE, RECORDADOPT, CHECKFLAG, VIEWGUID, AUDITBEANID, REMARK, AUDITSQL)
values (sys_guid(), 'checkTJdeptPerf', '天津部门整体绩效保存送审校验', null, '2016', null, null, null, '97B322F7852048A8A47CB558039C144D', '20221104110817', '20221104110817', '87', null, 1, 'pkg_perf_checkperfindex.checkTJdeptPerf', 'procedure', null, 1, null, null, null, null, null);

delete from PERF_T_AUDITDEFINE where code ='checkTJdeptPerfReview';

insert into PERF_T_AUDITDEFINE (GUID, CODE, NAME, EXPLAIN, YEAR, AGENCYGUID, WFID, WFSTATUS, CREATER, CREATETIME, UPDATETIME, PROVINCE, ORDERNUM, STATUS, "procedure", AUDITDETYPE, ISALLTABLE, RECORDADOPT, CHECKFLAG, VIEWGUID, AUDITBEANID, REMARK, AUDITSQL)
values (sys_guid(), 'checkTJdeptPerfReview', '天津部门整体绩效资金处室审阅审校验', null, '2016', null, null, null, '97B322F7852048A8A47CB558039C144D', '20221104110817', '20221104110817', '87', null, 1, 'pkg_perf_checkperfindex.checkTJdeptPerfReview', 'procedure', null, 1, null, null, null, null, null);
