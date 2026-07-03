begin

--表注册信息
delete from bus_t_dictable where tablecode ='PERF_T_MAJORPOLICY';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_MAJORPOLICY', '重大政策全生命周期绩效管理', '重大政策全生命周期绩效管理', 2, 1, 'PERF_T_MAJORPOLICY', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_MAJORPOLICY', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode ='PERF_T_MAJORPOLICY';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_MAJORPOLICY', '主键', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', sys_guid(), 'PRO_CODE', 'PERF_T_MAJORPOLICY', '项目编码', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_NAME', '1', '2016', '87', sys_guid(), 'PRO_NAME', 'PERF_T_MAJORPOLICY', '项目名称', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCY_CODE', '1', '2016', '87', sys_guid(), 'AGENCY_CODE', 'PERF_T_MAJORPOLICY', '单位', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIDEPT', null, '1', 'DEPT_CODE', '1', '2016', '87', sys_guid(), 'DEPT_CODE', 'PERF_T_MAJORPOLICY', '部门', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', sys_guid(), 'FININTORGGUID', 'PERF_T_MAJORPOLICY', '业务处室', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2016', '87', sys_guid(), 'CREATE_TIME', 'PERF_T_MAJORPOLICY', '创建时间', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATE_TIME', '1', '2016', '87', sys_guid(), 'UPDATE_TIME', 'PERF_T_MAJORPOLICY', '更新时间', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2016', '87', sys_guid(), 'IS_DELETED', 'PERF_T_MAJORPOLICY', '删除状态', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL1', '1', '2016', '87', sys_guid(), 'YEARCOL1', 'PERF_T_MAJORPOLICY', '本轮政策实施期起始年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL2', '1', '2016', '87', sys_guid(), 'YEARCOL2', 'PERF_T_MAJORPOLICY', '本轮政策实施期终止年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL3', '1', '2016', '87', sys_guid(), 'YEARCOL3', 'PERF_T_MAJORPOLICY', '上轮政策实施期起始年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL4', '1', '2016', '87', sys_guid(), 'YEARCOL4', 'PERF_T_MAJORPOLICY', '上轮政策实施期终止年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL5', '1', '2016', '87', sys_guid(), 'YEARCOL5', 'PERF_T_MAJORPOLICY', '最近开展到期绩效评价的年份', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL6', '1', '2016', '87', sys_guid(), 'YEARCOL6', 'PERF_T_MAJORPOLICY', '绩效评价覆盖的起始预算年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARCOL7', '1', '2016', '87', sys_guid(), 'YEARCOL7', 'PERF_T_MAJORPOLICY', '绩效评价覆盖的终止预算年度', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LINKMAN', '1', '2016', '87', sys_guid(), 'LINKMAN', 'PERF_T_MAJORPOLICY', '处室联系人', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFCOLOR', null, '1', 'WARN', '1', '2016', '87', sys_guid(), 'WARN', 'PERF_T_MAJORPOLICY', '到期评价预警', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', sys_guid(), 'ORDERNUM', 'PERF_T_MAJORPOLICY', '排序', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_MAJORPOLICY', '年度', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_MAJORPOLICY', '区划', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'VIOLATIONSNUM', '1', '2016', '87', sys_guid(), 'VIOLATIONSNUM', 'PERF_T_MAJORPOLICY', '认定违规数量', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'RECTIFICATIONNUM', '1', '2016', '87', sys_guid(), 'RECTIFICATIONNUM', 'PERF_T_MAJORPOLICY', '已整改数量', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID1', '1', '2016', '87', sys_guid(), 'SELFEVALGUID1', 'PERF_T_MAJORPOLICY', '近三年自评自评GUID1', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID2', '1', '2016', '87', sys_guid(), 'SELFEVALGUID2', 'PERF_T_MAJORPOLICY', '近三年自评自评GUID2', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID3', '1', '2016', '87', sys_guid(), 'SELFEVALGUID3', 'PERF_T_MAJORPOLICY', '近三年自评自评GUID3', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT1', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT1', 'PERF_T_MAJORPOLICY', '近三年自评自评结论1', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT2', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT2', 'PERF_T_MAJORPOLICY', '近三年自评自评结论2', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT3', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT3', 'PERF_T_MAJORPOLICY', '近三年自评自评结论3', 'S', '40', null, 1, 1, null, sysdate);


delete from bus_t_dictable where tablecode ='V_PERF_PROJECT_SELFRESULT';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'V_PERF_PROJECT_SELFRESULT', '重大政策全生命周期绩效选择项目', '重大政策全生命周期绩效选择项目', 2, 1, 'V_PERF_PROJECT_SELFRESULT', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_PROJECT_SELFRESULT', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode ='V_PERF_PROJECT_SELFRESULT';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ADJSTATUS', '1', null, null, sys_guid(), 'ADJSTATUS', 'V_PERF_PROJECT_SELFRESULT', '调整状态', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCYGUID', '1', null, null, sys_guid(), 'AGENCYGUID', 'V_PERF_PROJECT_SELFRESULT', '单位信息', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'PDMAGENCYALL', null, '0', 'AGENCY_CODE', '1', null, null, sys_guid(), 'AGENCY_CODE', 'V_PERF_PROJECT_SELFRESULT', '单位代码', 'S', '21', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092006', '61006100UEw5VQ8y', null, '0', 'AUDITOR', '1', null, null, sys_guid(), 'AUDITOR', 'V_PERF_PROJECT_SELFRESULT', '审核人', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMTRAIN', null, '0', 'CEN_TRA_PRO_CODE', '1', null, null, sys_guid(), 'CEN_TRA_PRO_CODE', 'V_PERF_PROJECT_SELFRESULT', '上级转移支付项目代码', 'S', '21', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '61006100UEw5VQ8y', null, '0', 'CREATER', '1', null, null, sys_guid(), 'CREATER', 'V_PERF_PROJECT_SELFRESULT', '建单人', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'DEPT_CODE', '1', null, null, sys_guid(), 'DEPT_CODE', 'V_PERF_PROJECT_SELFRESULT', '部门代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09004', null, '0', 'DEP_AUD_OPINION_CODE', '1', null, null, sys_guid(), 'DEP_AUD_OPINION_CODE', 'V_PERF_PROJECT_SELFRESULT', '部门审核意见', 'S', '1', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBLANK', null, '0', 'DIRECTFUNDS', '1', null, null, sys_guid(), 'DIRECTFUNDS', 'V_PERF_PROJECT_SELFRESULT', '直达资金标识', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09002', null, '0', 'DISTRI_TYPE_CODE', '1', null, null, sys_guid(), 'DISTRI_TYPE_CODE', 'V_PERF_PROJECT_SELFRESULT', '分配方式', 'S', '1', null, 1, 0, '1', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMDRAFTTEMPLATEDIC', null, '0', 'DRAFT_TEMPLATE_CODE', '1', null, null, sys_guid(), 'DRAFT_TEMPLATE_CODE', 'V_PERF_PROJECT_SELFRESULT', '编报模板代码', 'S', '32', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE05004', 'VD10004', null, '0', 'EXP_FUNC_CODE', '1', null, null, sys_guid(), 'EXP_FUNC_CODE', 'V_PERF_PROJECT_SELFRESULT', '支出功能分类科目代码', 'S', '7', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', null, null, sys_guid(), 'FININTORGGUID', 'V_PERF_PROJECT_SELFRESULT', '财政处室', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FROMGUID', '1', null, null, sys_guid(), 'FROMGUID', 'V_PERF_PROJECT_SELFRESULT', '来源guid', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMFUNCRESP', null, '0', 'FUN_RES_CODE', '1', null, null, sys_guid(), 'FUN_RES_CODE', 'V_PERF_PROJECT_SELFRESULT', '职能职责代码', 'S', '20', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', null, null, sys_guid(), 'GUID', 'V_PERF_PROJECT_SELFRESULT', '业务主键', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISHISTORY', '1', null, null, sys_guid(), 'ISHISTORY', 'V_PERF_PROJECT_SELFRESULT', '是否历史数据', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISPUBLISH', '1', null, null, sys_guid(), 'ISPUBLISH', 'V_PERF_PROJECT_SELFRESULT', '是否发布', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_ATTACH', '1', null, null, sys_guid(), 'IS_ATTACH', 'V_PERF_PROJECT_SELFRESULT', '是否填报附件', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_BGT', '1', null, null, sys_guid(), 'IS_BGT', 'V_PERF_PROJECT_SELFRESULT', '是否纳入', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_CAPTIAL_CONS_PRO', '1', null, null, sys_guid(), 'IS_CAPTIAL_CONS_PRO', 'V_PERF_PROJECT_SELFRESULT', '是否基建项目', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_DELETED', '1', null, null, sys_guid(), 'IS_DELETED', 'V_PERF_PROJECT_SELFRESULT', '是否删除', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_DIVIDE_PRO', '1', null, null, sys_guid(), 'IS_DIVIDE_PRO', 'V_PERF_PROJECT_SELFRESULT', '是否收转支项目', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_END', '1', null, null, sys_guid(), 'IS_END', 'V_PERF_PROJECT_SELFRESULT', '是否终止', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_FROMUP', '1', null, null, sys_guid(), 'IS_FROMUP', 'V_PERF_PROJECT_SELFRESULT', '是否来源上级', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_GOVPUR', '1', null, null, sys_guid(), 'IS_GOVPUR', 'V_PERF_PROJECT_SELFRESULT', '是否填报采购', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_OTHER_EDIT', '1', null, null, sys_guid(), 'IS_OTHER_EDIT', 'V_PERF_PROJECT_SELFRESULT', '是否代编', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_PERFORM', '1', null, null, sys_guid(), 'IS_PERFORM', 'V_PERF_PROJECT_SELFRESULT', '是否填报绩效', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_SCIENTIFIC', '1', null, null, sys_guid(), 'IS_SCIENTIFIC', 'V_PERF_PROJECT_SELFRESULT', '是否科研项目', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_THIN', '1', null, null, sys_guid(), 'IS_THIN', 'V_PERF_PROJECT_SELFRESULT', '是否细化', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_TO_DOWN', '1', null, null, sys_guid(), 'IS_TO_DOWN', 'V_PERF_PROJECT_SELFRESULT', '是否对下项目', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_TRACK', '1', null, null, sys_guid(), 'IS_TRACK', 'V_PERF_PROJECT_SELFRESULT', '是否追踪', 'N', '1', null, 1, 1, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_URGENT', '1', null, null, sys_guid(), 'IS_URGENT', 'V_PERF_PROJECT_SELFRESULT', '是否紧急项目', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_USESET', '1', null, null, sys_guid(), 'IS_USESET', 'V_PERF_PROJECT_SELFRESULT', '是否设置使用范围', 'N', '1', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_WAIT_DIVIDE', '1', null, null, sys_guid(), 'IS_WAIT_DIVIDE', 'V_PERF_PROJECT_SELFRESULT', '是否待安排项目', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'LASTAUDIT', '1', null, null, sys_guid(), 'LASTAUDIT', 'V_PERF_PROJECT_SELFRESULT', '是否终审', 'N', '22', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LASTUPDATETIME', '1', null, null, sys_guid(), 'LASTUPDATETIME', 'V_PERF_PROJECT_SELFRESULT', '时间戳', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEADER_NAME', '1', null, null, sys_guid(), 'LEADER_NAME', 'V_PERF_PROJECT_SELFRESULT', '负责人姓名', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEADER_PHONE', '1', null, null, sys_guid(), 'LEADER_PHONE', 'V_PERF_PROJECT_SELFRESULT', '负责人手机', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEADER_TEL', '1', null, null, sys_guid(), 'LEADER_TEL', 'V_PERF_PROJECT_SELFRESULT', '负责人电话', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'MANAGE_DEPT_CODE', '1', null, null, sys_guid(), 'MANAGE_DEPT_CODE', 'V_PERF_PROJECT_SELFRESULT', '主管部门代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03026', '099003', null, '1', 'MANAGE_MOF_DEP_CODE', '1', null, null, sys_guid(), 'MANAGE_MOF_DEP_CODE', 'V_PERF_PROJECT_SELFRESULT', '主管处室代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MID_PLAN_YEAR', '1', null, null, sys_guid(), 'MID_PLAN_YEAR', 'V_PERF_PROJECT_SELFRESULT', '中期规划年度', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09005', null, '0', 'MOF_AUD_OPINION_CODE', '1', null, null, sys_guid(), 'MOF_AUD_OPINION_CODE', 'V_PERF_PROJECT_SELFRESULT', '**审核意见', 'S', '1', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03026', '099003', null, '1', 'MOF_DEP_CODE', '1', null, null, sys_guid(), 'MOF_DEP_CODE', 'V_PERF_PROJECT_SELFRESULT', '财政内部机构代码', 'S', '6', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD08001', null, '1', 'MOF_DIV_CODE', '1', null, null, sys_guid(), 'MOF_DIV_CODE', 'V_PERF_PROJECT_SELFRESULT', '**区划代码', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL1', '1', null, null, sys_guid(), 'N_COL1', 'V_PERF_PROJECT_SELFRESULT', '备用1', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL2', '1', null, null, sys_guid(), 'N_COL2', 'V_PERF_PROJECT_SELFRESULT', '备用2', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL3', '1', null, null, sys_guid(), 'N_COL3', 'V_PERF_PROJECT_SELFRESULT', '备用3', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL4', '1', null, null, sys_guid(), 'N_COL4', 'V_PERF_PROJECT_SELFRESULT', '备用4', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL5', '1', null, null, sys_guid(), 'N_COL5', 'V_PERF_PROJECT_SELFRESULT', '备用5', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL6', '1', null, null, sys_guid(), 'N_COL6', 'V_PERF_PROJECT_SELFRESULT', '备用6', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL7', '1', null, null, sys_guid(), 'N_COL7', 'V_PERF_PROJECT_SELFRESULT', '备用7', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'N_COL8', '1', null, null, sys_guid(), 'N_COL8', 'V_PERF_PROJECT_SELFRESULT', '备用8', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ORDERNO1', '1', null, null, sys_guid(), 'ORDERNO1', 'V_PERF_PROJECT_SELFRESULT', '单位排序', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ORDERNO2', '1', null, null, sys_guid(), 'ORDERNO2', 'V_PERF_PROJECT_SELFRESULT', '部门排序', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ORDERNO3', '1', null, null, sys_guid(), 'ORDERNO3', 'V_PERF_PROJECT_SELFRESULT', '处室排序', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ORDERNO4', '1', null, null, sys_guid(), 'ORDERNO4', 'V_PERF_PROJECT_SELFRESULT', '预算排序', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMPROJECTKINDEXTEND', null, '0', 'PROJECTKIND', '1', null, null, sys_guid(), 'PROJECTKIND', 'V_PERF_PROJECT_SELFRESULT', '支出项目类别', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_BGTREVIEW', '1', null, null, sys_guid(), 'PRO_BGTREVIEW', 'V_PERF_PROJECT_SELFRESULT', '**评审意见', 'S', '2000', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMVD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, sys_guid(), 'PRO_CAT_CODE', 'V_PERF_PROJECT_SELFRESULT', '项目类别', 'S', '4', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', null, null, sys_guid(), 'PRO_CODE', 'V_PERF_PROJECT_SELFRESULT', '项目代码', 'S', '21', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_DEPREVIEW', '1', null, null, sys_guid(), 'PRO_DEPREVIEW', 'V_PERF_PROJECT_SELFRESULT', '部门评审意见', 'S', '2000', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_DESC', '1', null, null, sys_guid(), 'PRO_DESC', 'V_PERF_PROJECT_SELFRESULT', '项目概述', 'S', '2000', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PROGRADE', null, '1', 'PRO_GRADE', '1', null, null, sys_guid(), 'PRO_GRADE', 'V_PERF_PROJECT_SELFRESULT', '项目排序', 'N', '9', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_ID', '1', null, null, sys_guid(), 'PRO_ID', 'V_PERF_PROJECT_SELFRESULT', '项目主键', 'S', '38', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_LEV', '1', null, null, sys_guid(), 'PRO_LEV', 'V_PERF_PROJECT_SELFRESULT', '项目级次', 'S', '2', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMDICPROJECTLEVONE', null, '0', 'PRO_LEVONE_CODE', '1', null, null, sys_guid(), 'PRO_LEVONE_CODE', 'V_PERF_PROJECT_SELFRESULT', '一级项目编码', 'S', '21', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_LEVONE_ID', '1', null, null, sys_guid(), 'PRO_LEVONE_ID', 'V_PERF_PROJECT_SELFRESULT', '一级项目主键', 'S', '38', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_LEVONE_NAME', '1', null, null, sys_guid(), 'PRO_LEVONE_NAME', 'V_PERF_PROJECT_SELFRESULT', '一级项目名称', 'S', '180', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_NAME', '1', null, null, sys_guid(), 'PRO_NAME', 'V_PERF_PROJECT_SELFRESULT', '项目名称', 'S', '180', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PROPHASE', null, '0', 'PRO_PHASE', '1', null, null, sys_guid(), 'PRO_PHASE', 'V_PERF_PROJECT_SELFRESULT', '是否年初项目', 'S', '2', null, 1, 0, '1', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09006', null, '0', 'PRO_SOURCE_CODE', '1', null, null, sys_guid(), 'PRO_SOURCE_CODE', 'V_PERF_PROJECT_SELFRESULT', '项目来源代码', 'S', '1', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBDGYEAR', null, '0', 'PRO_START_YEAR', '1', null, null, sys_guid(), 'PRO_START_YEAR', 'V_PERF_PROJECT_SELFRESULT', '起始时间', 'S', '4', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMPROTERM', null, '0', 'PRO_TERM', '1', null, null, sys_guid(), 'PRO_TERM', 'V_PERF_PROJECT_SELFRESULT', '项目期限', 'S', '8', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_TOTAL_AMT', '1', null, null, sys_guid(), 'PRO_TOTAL_AMT', 'V_PERF_PROJECT_SELFRESULT', '项目总额', 'N', '20', 2, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMTRASTATUS', null, '0', 'PRO_TRA_STATUS', '1', null, null, sys_guid(), 'PRO_TRA_STATUS', 'V_PERF_PROJECT_SELFRESULT', '项目转移状态', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBLANK', null, '0', 'QKSFBS', '1', null, null, sys_guid(), 'QKSFBS', 'V_PERF_PROJECT_SELFRESULT', '扶贫标识', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'SCOI_INVEST_FUND', '1', null, null, sys_guid(), 'SCOI_INVEST_FUND', 'V_PERF_PROJECT_SELFRESULT', '其中：社会投入资金', 'N', '20', 2, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBDGYEAR', null, '0', 'SETUP_YEAR', '1', null, null, sys_guid(), 'SETUP_YEAR', 'V_PERF_PROJECT_SELFRESULT', '设立年度', 'S', '4', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'STORE_PHASE', '1', null, null, sys_guid(), 'STORE_PHASE', 'V_PERF_PROJECT_SELFRESULT', '储备阶段', 'S', '2', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBLANK', null, '0', 'SUBSIDY', '1', null, null, sys_guid(), 'SUBSIDY', 'V_PERF_PROJECT_SELFRESULT', '是否补贴到人到企业', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'SUB_AGENCY_NAME', '1', null, null, sys_guid(), 'SUB_AGENCY_NAME', 'V_PERF_PROJECT_SELFRESULT', '下级单位名称', 's', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD08001', null, '0', 'SUB_MOF_DIV_CODE', '1', null, null, sys_guid(), 'SUB_MOF_DIV_CODE', 'V_PERF_PROJECT_SELFRESULT', '下级区划编码', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'VD00010', null, '0', 'TRAOBJ_AGENCY_CODE', '1', null, null, sys_guid(), 'TRAOBJ_AGENCY_CODE', 'V_PERF_PROJECT_SELFRESULT', '去向单位代码', 'S', '21', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'UPDATE_TIME', '1', null, null, sys_guid(), 'UPDATE_TIME', 'V_PERF_PROJECT_SELFRESULT', '更新时间', 'S', '14', null, 1, 0, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMPAVOUCHER', null, '0', 'VCHTYPEID', '1', null, null, sys_guid(), 'VCHTYPEID', 'V_PERF_PROJECT_SELFRESULT', '凭证号', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'VERSION', '1', null, null, sys_guid(), 'VERSION', 'V_PERF_PROJECT_SELFRESULT', '版本号', 'S', '38', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'VERSION_NAME', '1', null, null, sys_guid(), 'VERSION_NAME', 'V_PERF_PROJECT_SELFRESULT', '版本说明', 'S', '400', null, 1, 1, '0', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'V_COL1', '1', null, null, sys_guid(), 'V_COL1', 'V_PERF_PROJECT_SELFRESULT', '备用1', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZDZXSX', null, '0', 'V_COL10', '1', null, null, sys_guid(), 'V_COL10', 'V_PERF_PROJECT_SELFRESULT', '备用10', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZDZXSX', null, '0', 'V_COL11', '1', null, null, sys_guid(), 'V_COL11', 'V_PERF_PROJECT_SELFRESULT', '备用11', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZC', null, '0', 'V_COL12', '1', null, null, sys_guid(), 'V_COL12', 'V_PERF_PROJECT_SELFRESULT', '备用12', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZCTK', null, '0', 'V_COL13', '1', null, null, sys_guid(), 'V_COL13', 'V_PERF_PROJECT_SELFRESULT', '备用13', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBDGYEAR', null, '0', 'V_COL14', '1', null, null, sys_guid(), 'V_COL14', 'V_PERF_PROJECT_SELFRESULT', '备用14', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'V_COL15', '1', null, null, sys_guid(), 'V_COL15', 'V_PERF_PROJECT_SELFRESULT', '备用15', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL16', '1', null, null, sys_guid(), 'V_COL16', 'V_PERF_PROJECT_SELFRESULT', '备用16', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL17', '1', null, null, sys_guid(), 'V_COL17', 'V_PERF_PROJECT_SELFRESULT', '备用17', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL18', '1', null, null, sys_guid(), 'V_COL18', 'V_PERF_PROJECT_SELFRESULT', '备用18', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL19', '1', null, null, sys_guid(), 'V_COL19', 'V_PERF_PROJECT_SELFRESULT', '备用19', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL2', '1', null, null, sys_guid(), 'V_COL2', 'V_PERF_PROJECT_SELFRESULT', '备用2', 'N', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL20', '1', null, null, sys_guid(), 'V_COL20', 'V_PERF_PROJECT_SELFRESULT', '备用20', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL21', '1', null, null, sys_guid(), 'V_COL21', 'V_PERF_PROJECT_SELFRESULT', '备用21', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL22', '1', null, null, sys_guid(), 'V_COL22', 'V_PERF_PROJECT_SELFRESULT', '备用22', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL23', '1', null, null, sys_guid(), 'V_COL23', 'V_PERF_PROJECT_SELFRESULT', '备用23', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL24', '1', null, null, sys_guid(), 'V_COL24', 'V_PERF_PROJECT_SELFRESULT', '备用24', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL25', '1', null, null, sys_guid(), 'V_COL25', 'V_PERF_PROJECT_SELFRESULT', '备用25', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL26', '1', null, null, sys_guid(), 'V_COL26', 'V_PERF_PROJECT_SELFRESULT', '备用26', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL27', '1', null, null, sys_guid(), 'V_COL27', 'V_PERF_PROJECT_SELFRESULT', '备用27', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL28', '1', null, null, sys_guid(), 'V_COL28', 'V_PERF_PROJECT_SELFRESULT', '备用28', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL29', '1', null, null, sys_guid(), 'V_COL29', 'V_PERF_PROJECT_SELFRESULT', '备用29', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'V_COL3', '1', null, null, sys_guid(), 'V_COL3', 'V_PERF_PROJECT_SELFRESULT', '备用3', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'V_COL30', '1', null, null, sys_guid(), 'V_COL30', 'V_PERF_PROJECT_SELFRESULT', '备用30', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'bdg002', null, '0', 'V_COL4', '1', null, null, sys_guid(), 'V_COL4', 'V_PERF_PROJECT_SELFRESULT', '备用4', 'N', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'bdg003', null, '0', 'V_COL5', '1', null, null, sys_guid(), 'V_COL5', 'V_PERF_PROJECT_SELFRESULT', '备用5', 'N', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'V_COL6', '1', null, null, sys_guid(), 'V_COL6', 'V_PERF_PROJECT_SELFRESULT', '备用6', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'V_COL7', '1', null, null, sys_guid(), 'V_COL7', 'V_PERF_PROJECT_SELFRESULT', '备用7', 'N', '300', null, 1, 0, '2', sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZDZXSX', null, '0', 'V_COL8', '1', null, null, sys_guid(), 'V_COL8', 'V_PERF_PROJECT_SELFRESULT', '备用8', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMZDZXSX', null, '0', 'V_COL9', '1', null, null, sys_guid(), 'V_COL9', 'V_PERF_PROJECT_SELFRESULT', '备用9', 'S', '300', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WFID', '1', null, null, sys_guid(), 'WFID', 'V_PERF_PROJECT_SELFRESULT', '流程编码', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092004', '099076', null, '0', 'WFSTATUS', '1', null, null, sys_guid(), 'WFSTATUS', 'V_PERF_PROJECT_SELFRESULT', '流程状态', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMBLANK', null, '0', 'ZDZJJQPT', '1', null, null, sys_guid(), 'ZDZJJQPT', 'V_PERF_PROJECT_SELFRESULT', '是否直达资金及其地方对应安排', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID1', '1', '2016', '87', sys_guid(), 'SELFEVALGUID1', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评GUID1', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID2', '1', '2016', '87', sys_guid(), 'SELFEVALGUID2', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评GUID2', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALGUID3', '1', '2016', '87', sys_guid(), 'SELFEVALGUID3', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评GUID3', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT1', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT1', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评结论1', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT2', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT2', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评结论2', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFEVALRESULT3', '1', '2016', '87', sys_guid(), 'SELFEVALRESULT3', 'V_PERF_PROJECT_SELFRESULT', '近三年自评自评结论3', 'S', '40', null, 1, 1, null, sysdate);

