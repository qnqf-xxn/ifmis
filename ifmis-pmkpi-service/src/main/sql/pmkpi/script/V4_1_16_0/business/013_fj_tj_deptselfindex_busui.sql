begin

--dic
delete from bus_t_dictable where tablecode ='PERF_T_SELFPERFGOAL';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_SELFPERFGOAL', '自评目标表', '自评目标表', 2, 1, 'PERF_T_SELFPERFGOAL', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_SELFPERFGOAL', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode ='PERF_T_SELFPERFGOAL';


insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AGENCYGUID', '1', '2016', '87', sys_guid(), 'AGENCYGUID', 'PERF_T_SELFPERFGOAL', '单位', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATER', '1', '2016', '87', sys_guid(), 'CREATER', 'PERF_T_SELFPERFGOAL', '创建人', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2016', '87', sys_guid(), 'CREATETIME', 'PERF_T_SELFPERFGOAL', '新增时间', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', sys_guid(), 'GOALNAME', 'PERF_T_SELFPERFGOAL', '名称', 'S', '100', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_SELFPERFGOAL', '主键', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'MAINGUID', '1', '2016', '87', sys_guid(), 'MAINGUID', 'PERF_T_SELFPERFGOAL', '主单guid', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NDGOAL', '1', '2016', '87', sys_guid(), 'NDGOAL', 'PERF_T_SELFPERFGOAL', '年度目标', 'S', '4000', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', sys_guid(), 'ORDERNUM', 'PERF_T_SELFPERFGOAL', '排序', 'N', '4', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_SELFPERFGOAL', '区划', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'RATIO', '1', '2016', '87', sys_guid(), 'RATIO', 'PERF_T_SELFPERFGOAL', '权重比例', 'N', '6', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', sys_guid(), 'REMARK', 'PERF_T_SELFPERFGOAL', '指标说明', 'S', '2000', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', sys_guid(), 'UPDATETIME', 'PERF_T_SELFPERFGOAL', '修改时间', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WEIGHTSCORE', '1', '2016', '87', sys_guid(), 'WEIGHTSCORE', 'PERF_T_SELFPERFGOAL', '指标权重得分', 'N', '20', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_SELFPERFGOAL', '年度', 'S', '40', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARFLAG', '1', '2016', '87', sys_guid(), 'YEARFLAG', 'PERF_T_SELFPERFGOAL', '中长期标识', 'S', '1', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ZQGOAL', '1', '2016', '87', sys_guid(), 'ZQGOAL', 'PERF_T_SELFPERFGOAL', '中期目标', 'S', '4000', null, 1, 1, null,  sysdate);



insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_TARGET', '1', '2016', '87', sys_guid(), 'KPI_TARGET', 'PERF_T_SELFPERFGOAL', '年度绩效目标', 'S', '2000', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ACTUAL_COMP', '1', '2016', '87', sys_guid(), 'ACTUAL_COMP', 'PERF_T_SELFPERFGOAL', '实际完成情况', 'S', '2000', null, 1, 1, null,  sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEVIATIONANALY', '1', '2016', '87', sys_guid(), 'DEVIATIONANALY', 'PERF_T_SELFPERFGOAL', '偏差原因分析及改进措施', 'S', '2000', null, 1, 1, null,  sysdate);


--ui
delete from p#busfw_t_uitable where key ='/pmkpi/perfself/apply/editdept/tjgoal' and province = '87' and year = '2016';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'V_PERF_T_SELFPERFGOAL', 0, 1, 0, null, null, 'pmkpi', null, '87', '2016');

delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/editdept/tjgoal' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'KPI_TARGET', '年度绩效目标', 1, 1, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'ACTUAL_COMP', '实际完成情况', 2, 1, 1, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'DEVIATIONANALY', '偏差原因分析及改进措施', 3, 1, 1, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjgoal', 'WEIGHTSCORE', '指标得分', 4, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');


delete from p#busfw_t_uitable where key ='/pmkpi/perfself/apply/editdept/tjindex' and province = '87' and year = '2016';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'V_PERF_T_SELFPERFINDEX', 0, 1, 0, null, null, 'pmkpi', null, '87', '2016');

delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/editdept/tjindex' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'NAME', '指标名称', 2, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'COMPUTESIGN', '计算符号', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'INDEXVAL', '指标值', 4, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'ACTUALVALUE', '实际完成值', 5, 1, 1, 0, '0', 1, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'METERUNIT', '计量单位', 6, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'WEIGHT', '权重设定值', 7, 0, 0, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, null, 0, 'i', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'ACTUALWEIGHT', '分值', 8, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, null, 0, 'i', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'SCORE', '得分', 9, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, null, 0, 'i', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/tjindex', 'KPI_REMARK', '偏差原因分析及改进措施', 10, 1, 1, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null, '87', '2016');


delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/dept/edit' and code = 'tjselfindex' and province = '87' and year = '2016';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '指标完成情况(天津)', 'tjselfindex', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '指标完成情况(天津)', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfindextj.page?rationscore=2'||chr(38)||'qualscore=2'',action:''selfindexdepttj.save''}', null, '0', 'tjselfindexiframe', null, null, null, null, null, '87', '2016');


delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/query/index' and code = 'tjdeptexp' and province = '87' and year = '2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query/index', '导出部门整体支出绩效自评表(TJ)', 0, 32, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出部门整体支出绩效自评表(TJ)', 'pmkpi', 'tjdeptexp', null, '{tempatecode:''tjdeptselfevalxls''}', '87', '2016', null, null);

--页面配置节点

delete from perf_t_pagemenu where guid in('9D21872F4F85EF11AF5836FB444BB883');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('9D21872F4F85EF11AF5836FB444BB883', '9', '指标完成情况(天津)', '/pmkpi/perfself/apply/editdept/selfindextj', '22FDCF7957D5BCDB3786A391CB1F0811', 3, 1, 9, 1, '20260610105709', '20260610105709', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');


