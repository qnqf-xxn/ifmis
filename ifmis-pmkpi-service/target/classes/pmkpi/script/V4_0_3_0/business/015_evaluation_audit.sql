begin
 
--编辑区注册
delete from p#busfw_t_uieditform where key ='/pmkpi/audit/index/evaluation';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/audit/index/evaluation', 'PERF_T_AUDITMAIN', 'textarea', null, 'REMARK', 1, null, 0, null, 3, 1, '6', 'pmkpi', 1, null, '{}', 0, 0, 0,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/audit/index/evaluation', 'PERF_T_EVALUATION', 'tree', '审核方式', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/audit/index/evaluation', 'PERF_T_EVALUATION', 'tree', '再 评 估', 'PINGGUTYPE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0,  null);


--表注册
delete from bus_t_diccolumn where tablecode ='PERF_T_EVALUATION' and columncode ='PINGGUTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PINGGUTYPE', null, '1', 'PINGGUTYPE', '1', '2020', '87', 'DF43FEFABBC47877E0533315A8C09890', 'PINGGUTYPE', 'PERF_T_EVALUATION', '再评估', 'S', '40', null, 1, 1, null, sysdate);


--注册数据源
delete from fasp_t_dicdssource t where code in( 'EVALUATIONAUDITTYPE','PINGGUTYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EVALUATIONAUDITTYPE', 'EVALUATIONAUDITTYPE', 'EVALUATIONAUDITTYPE', '事前绩效评估审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''evaluationaudittype'' and t.status =''1'' order by t.ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PINGGUTYPE', 'PINGGUTYPE', 'PINGGUTYPE', '再评估类型', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"否"},{guid:"1",code:"1",name:"是"}]', null, 1, 'pmkpi');


--审核类型数据源注册
delete from perf_t_datasource where elementcode = 'evaluationaudittype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '001', '通过', null, null, null, null, 1, 'evaluationaudittype', 1, '20201229', '20201229', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '002', '再评估', null, null, null, null, 2, 'evaluationaudittype', 0, '20201229', '20201229', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '不通过', null, null, null, null, 3, 'evaluationaudittype', 1, '20201229', '20201229', 2016, '87');

