begin

delete from bus_t_dictable t where t.tablecode='PERF_T_MANCEOPEN';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2019', '87', 'PERF_T_MANCEOPEN', '绩效公开', null, 2, 1, 'PERF_T_MANCEOPEN', 'pmkpi', null, null, 1, null, 1, 1, 'V_PERF_T_MANCEOPEN', sysdate, null, null, null, '1');

delete from bus_t_diccolumn t where t.tablecode in('PERF_T_MANCEOPEN');

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2020', '87', sys_guid(), 'GUID', 'PERF_T_MANCEOPEN', 'GUID', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MAINGUID', '1', '2020', '87', sys_guid(), 'MAINGUID', 'PERF_T_MANCEOPEN', '关联ID', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2020', '87', sys_guid(), 'PRO_CODE', 'PERF_T_MANCEOPEN', '项目编码', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCYGUID', '1', '2020', '87', sys_guid(), 'AGENCYGUID', 'PERF_T_MANCEOPEN', '单位', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '0', 'ISOPEN', '1', '2020', '87', sys_guid(), 'ISOPEN', 'PERF_T_MANCEOPEN', '是否公开', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENAMT', '1', '2020', '87', sys_guid(), 'OPENAMT', 'PERF_T_MANCEOPEN', '公开金额', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENURL', '1', '2020', '87', sys_guid(), 'OPENURL', 'PERF_T_MANCEOPEN', '公开网址', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENREASON', '1', '2020', '87', sys_guid(), 'OPENREASON', 'PERF_T_MANCEOPEN', '不公开原因', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BUSTYPE', '1', '2020', '87', sys_guid(), 'BUSTYPE', 'PERF_T_MANCEOPEN', '业务类型', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092006', '61006100UEw5VQ8y', null, '0', 'CREATER', '1', '2020', '87', sys_guid(), 'CREATER', 'PERF_T_MANCEOPEN', '创建人', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2020', '87', sys_guid(), 'CREATETIME', 'PERF_T_MANCEOPEN', '创建时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'UPDATETIME', '1', '2020', '87', sys_guid(), 'UPDATETIME', 'PERF_T_MANCEOPEN', '创建时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '0', 'WFSTATUS', '1', '2020', '87', sys_guid(), 'WFSTATUS', 'PERF_T_MANCEOPEN', '工作流状态', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2020', '87', sys_guid(), 'WFID', 'PERF_T_MANCEOPEN', '工作流guid', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AUDITOR', '1', '2020', '87', sys_guid(), 'AUDITOR', 'PERF_T_MANCEOPEN', '审核人', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LASTUPDATETIME', '1', '2020', '87', sys_guid(), 'LASTUPDATETIME', 'PERF_T_MANCEOPEN', '最后操作时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2020', '87', sys_guid(), 'YEAR', 'PERF_T_MANCEOPEN', '年度', 'S', '4', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2020', '87', sys_guid(), 'PROVINCE', 'PERF_T_MANCEOPEN', '区划', 'S', '9', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2020', '87', sys_guid(), 'IS_DELETED', 'PERF_T_MANCEOPEN', '状态', 'N', '3', null, null, 1, null, sysdate);


delete from perf_t_datasource t where t.elementcode in('perfopen');

--insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
--values ('perfopen', '00', '全部', null, '00', 1, 0, 'perfopen', 1, '20201204', '20201204', 2020, '87', 1);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('01', '01', '年初项目绩效目标', null, '00', 2, 1, 'perfopen', 1, '20201204', '20201204', 2020, '87', 2);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('02', '02', '年中项目绩效目标', null, '00', 2, 1, 'perfopen', 1, '20201204', '20201204', 2020, '87', 3);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('03', '03', '自评项目', null, '00', 2, 1, 'perfopen', 1, '20201204', '20201204', 2020, '87', 4);

delete from fasp_t_dicdssource t where t.code='PERFOPEN';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFOPEN', 'PERFOPEN', 'PERFOPEN', '绩效公开类型', '1', null, null, null, '2020', '87', null, '201901', null, '2', 'select * from perf_t_datasource where elementcode=''perfopen'' ', null, 1, 'pmkpi');


-----------------------------------------------------------------------------------------

delete from bus_t_dictable t where t.tablecode='V_PERF_MANCEOPEN';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2019', '87', 'V_PERF_MANCEOPEN', '绩效公开视图', null, 2, 1, 'V_PERF_MANCEOPEN', 'pmkpi', null, null, 1, null, 1, 1, 'V_PERF_MANCEOPEN', sysdate, null, null, null, '1');

delete from bus_t_diccolumn t where t.tablecode in('V_PERF_MANCEOPEN');

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2020', '87', sys_guid(), 'GUID', 'V_PERF_MANCEOPEN', 'GUID', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MAINGUID', '1', '2020', '87', sys_guid(), 'MAINGUID', 'V_PERF_MANCEOPEN', '关联ID', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03026', '099003', null, '0', 'MANAGE_MOF_DEP_CODE', '1', '2020', '87', sys_guid(), 'MANAGE_MOF_DEP_CODE', 'V_PERF_MANCEOPEN', '处室', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'DEPT_CODE', '1', '2020', '87', sys_guid(), 'DEPT_CODE', 'V_PERF_MANCEOPEN', '部门', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCY_CODE', '1', '2020', '87', sys_guid(), 'AGENCY_CODE', 'V_PERF_MANCEOPEN', '单位', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09001', null, '0', 'PRO_KIND_CODE', '1', '2020', '87', sys_guid(), 'PRO_KIND_CODE', 'V_PERF_MANCEOPEN', '项目类型', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2020', '87', sys_guid(), 'PRO_CODE', 'V_PERF_MANCEOPEN', '项目编码', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_NAME', '1', '2020', '87', sys_guid(), 'PRO_NAME', 'V_PERF_MANCEOPEN', '项目名称', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MONEY', '1', '2020', '87', sys_guid(), 'MONEY', 'V_PERF_MANCEOPEN', '预算金额', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'XMLY', '1', '2020', '87', sys_guid(), 'XMLY', 'V_PERF_MANCEOPEN', '项目来源', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ISTBJX', '1', '2020', '87', sys_guid(), 'ISTBJX', 'V_PERF_MANCEOPEN', '是否填报绩效', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFOPEN', null, '0', 'PERFOPEN', '1', '2020', '87', sys_guid(), 'PERFOPEN', 'V_PERF_MANCEOPEN', '公开类型', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '0', 'ISOPEN', '1', '2020', '87', sys_guid(), 'ISOPEN', 'V_PERF_MANCEOPEN', '是否公开', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENAMT', '1', '2020', '87', sys_guid(), 'OPENAMT', 'V_PERF_MANCEOPEN', '公开金额', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENURL', '1', '2020', '87', sys_guid(), 'OPENURL', 'V_PERF_MANCEOPEN', '公开网址', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPENREASON', '1', '2020', '87', sys_guid(), 'OPENREASON', 'V_PERF_MANCEOPEN', '不公开原因', 'S', '20', 2, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '0', 'WFSTATUS', '1', '2020', '87', sys_guid(), 'WFSTATUS', 'V_PERF_MANCEOPEN', '工作流状态', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2020', '87', sys_guid(), 'WFID', 'V_PERF_MANCEOPEN', '工作流guid', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2020', '87', sys_guid(), 'YEAR', 'V_PERF_MANCEOPEN', '年度', 'S', '4', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2020', '87', sys_guid(), 'PROVINCE', 'V_PERF_MANCEOPEN', '区划', 'S', '9', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2020', '87', sys_guid(), 'IS_DELETED', 'V_PERF_MANCEOPEN', '状态', 'N', '3', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FININTORGGUID', '1', '2020', '87', sys_guid(), 'FININTORGGUID', 'V_PERF_MANCEOPEN', '处事', 'N', '3', null, null, 1, null, sysdate);
