BEGIN

delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFEVALTASK' and dbcolumncode in ('IS_EXTRACT','EXTRACT_TYPE','IS_SUE','PROTYPE') ;

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EXTRACT_TYPE', null, '1', 'EXTRACT_TYPE', '1', '2021', '87', sys_guid(), 'EXTRACT_TYPE', 'PERF_T_SELFEVALTASK', '抽取类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '1', 'IS_EXTRACT', '1', '2024', '87', sys_guid(),'IS_EXTRACT', 'PERF_T_SELFEVALTASK', '是否抽取', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '1', 'IS_SUE', '1', '2024', '87', sys_guid(), 'IS_SUE', 'PERF_T_SELFEVALTASK', '是否下发', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PROTYPENX', null, '1', 'PROTYPE', '1', '2021', '87', sys_guid(), 'PROTYPE', 'PERF_T_SELFEVALTASK', '项目类型', 'S', '40', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_V_SELFEVALTASK' and dbcolumncode in ('IS_EXTRACT','EXTRACT_TYPE','IS_SUE','PROTYPE') ;


insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EXTRACT_TYPE', null, '1', 'EXTRACT_TYPE', '1', '2021', '87', sys_guid(), 'EXTRACT_TYPE', 'PERF_V_SELFEVALTASK', '抽取类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '1', 'IS_EXTRACT', '1', '2024', '87', sys_guid(), 'IS_EXTRACT', 'PERF_V_SELFEVALTASK', '是否抽取', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLINKED', null, '1', 'IS_SUE', '1', '2024', '87', sys_guid(), 'IS_SUE', 'PERF_V_SELFEVALTASK', '是否下发', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PROTYPENX', null, '1', 'PROTYPE', '1', '2021', '87', sys_guid(), 'PROTYPE', 'PERF_V_SELFEVALTASK', '项目类型', 'S', '40', null, 1, 1, null, sysdate);



delete from fasp_T_dicdssource where code = 'EXTRACT_TYPE' ;

insert into fasp_T_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EXTRACT_TYPE', 'EXTRACT_TYPE', 'EXTRACT_TYPE', '抽取类型', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"自动抽取"},{guid:"2",code:"2",name:"人工选取"}]', null, 1, 'pmkpi');

delete from fasp_T_dicdssource where code = 'PROTYPENX' ;

insert into fasp_T_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PROTYPENX', 'PROTYPENX', 'PROTYPENX', '项目类型（宁夏）', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"program",code:"program",name:"本级项目"},{guid:"programzy",code:"programzy",name:"中央对地方转移支付"},{guid:"programsx",code:"programsx",name:"自治区市县转移支付"}]', null, 1, 'pmkpi');



delete from perf_enum t where t.elementcode='FUNDMANAG';

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG01', '1', 'FUNDMANAG', '分配科学性', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG02', '2', 'FUNDMANAG', '下达及时性', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG03', '3', 'FUNDMANAG', '拨付合规性', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 3);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG04', '4', 'FUNDMANAG', '使用规范性', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 4);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG05', '5', 'FUNDMANAG', '执行准确性', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 5);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG06', '6', 'FUNDMANAG', '预算绩效管理情况', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 6);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FUNDMANAG07', '7', 'FUNDMANAG', '支出责任履行情况', '1', '20231031172948', '20241203100854', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 7);



delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFFUNDMANAG' ;

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2021', '87', sys_guid(), 'CODE', 'PERF_T_SELFFUNDMANAG', '编码', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COL1', '1', '2021', '87', sys_guid(), 'COL1', 'PERF_T_SELFFUNDMANAG', '情况说明', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COL2', '1', '2021', '87', sys_guid(), 'COL2', 'PERF_T_SELFFUNDMANAG', '存在问题', 'S', '4000', null, 1, 0, null,sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COL3', '1', '2021', '87', sys_guid(), 'COL3', 'PERF_T_SELFFUNDMANAG', '备用', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COL4', '1', '2021', '87', sys_guid(), 'COL4', 'PERF_T_SELFFUNDMANAG', '备用', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COL5', '1', '2021', '87', sys_guid(), 'COL5', 'PERF_T_SELFFUNDMANAG', '备用', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '61006100UEw5VQ8y', null, '1', 'CREATER', '1', '2021', '87', sys_guid(), 'CREATER', 'PERF_T_SELFFUNDMANAG', '创建人', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2021', '87', sys_guid(), 'CREATE_TIME', 'PERF_T_SELFFUNDMANAG', '创建时间', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2021', '87', sys_guid(), 'GUID', 'PERF_T_SELFFUNDMANAG', '主键', 'S', '32', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2021', '87', sys_guid(), 'IS_DELETED', 'PERF_T_SELFFUNDMANAG', '是否删除', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'MAINGUID', '1', '2021', '87', sys_guid(), 'MAINGUID', 'PERF_T_SELFFUNDMANAG', '自评主键', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2021', '87', sys_guid(), 'NAME', 'PERF_T_SELFFUNDMANAG', '名称', 'S', '500', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2021', '87', sys_guid(), 'PROVINCE', 'PERF_T_SELFFUNDMANAG', '区划', 'S', '9', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2021', '87', sys_guid(), 'PRO_CODE', 'PERF_T_SELFFUNDMANAG', '项目编码', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATE_TIME', '1', '2021', '87', sys_guid(), 'UPDATE_TIME', 'PERF_T_SELFFUNDMANAG', '更新时间', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2021', '87', sys_guid(), 'YEAR', 'PERF_T_SELFFUNDMANAG', '年度', 'S', '4', null, 1, 0, null, sysdate);


delete from perf_T_systemset where paramcode = 'perfselfrandom';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('1EB16F820E665273944AD01FE8AE3761', 'perfselfrandom', '绩效自评抽评数量百分比', '15', '绩效自评抽评数量百分比', null, 3, 2016, '87', 1);
