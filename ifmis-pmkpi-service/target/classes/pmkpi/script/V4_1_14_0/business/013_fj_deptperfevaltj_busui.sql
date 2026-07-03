begin

--wf
delete from p#busfw_t_dcworkflowplan t where guid ='2F17CE2458E2CA06E063089W1AAC5581';

insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE, PARTITIONTYPE)
values ('2F17CE2458E2CA06E063089W1AAC5581', 'V_PERF_T_DEPTPERFEVALTJ', 'V_PERF_T_DEPTPERFEVALTJ', '部门绩效评价情况(天津)', '1', '2016', '87', null, null, null, null, '20210421102117739', 'B876713347C31372A297A0234F30FFB8', '1');

--dic

--数据源PMKPIEVALTYPETJ
delete from fasp_t_dicdssource t where t.guid='PMKPIEVALTYPETJ';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIEVALTYPETJ', 'PMKPIEVALTYPETJ', 'PMKPIEVALTYPETJ', '评价方式', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"自行开展"},{guid:"2",code:"2",name:"委托第三方机构"}]', null, null, 'pmkpi');


delete from bus_t_dictable where tablecode = 'PERF_T_DEPTPERFEVALTJ';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_DEPTPERFEVALTJ', '部门绩效评价情况(天津)', '部门绩效评价情况(天津)', 2, 1, 'V_PERF_T_DEPTPERFEVALTJ', 'pmkpi', null, '0', 1, null, 1, 1, null, sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_T_DEPTPERFEVALTJ';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_DEPTPERFEVALTJ', '业务主键', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '61006100UEw5VQ8y', null, '1', 'CREATER', '1', '2016', '87', sys_guid(), 'CREATER', 'PERF_T_DEPTPERFEVALTJ', '创建人', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2016', '87', sys_guid(), 'CREATE_TIME', 'PERF_T_DEPTPERFEVALTJ', '创建时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATE_TIME', '1', '2016', '87', sys_guid(), 'UPDATE_TIME', 'PERF_T_DEPTPERFEVALTJ', '更新时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REPORT_TIME', '1', '2016', '87', sys_guid(), 'REPORT_TIME', 'PERF_T_DEPTPERFEVALTJ', '申报时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_DEPTPERFEVALTJ', '区划', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_DEPTPERFEVALTJ', '年度', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEPT_CODE', '1', '2016', '87', sys_guid(), 'DEPT_CODE', 'PERF_T_DEPTPERFEVALTJ', '部门编码', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEPT_NAME', '1', '2016', '87', sys_guid(), 'DEPT_NAME', 'PERF_T_DEPTPERFEVALTJ', '部门名称', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EVAL_PRO_NAME', '1', '2016', '87', sys_guid(), 'EVAL_PRO_NAME', 'PERF_T_DEPTPERFEVALTJ', '评价项目名称', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EVAL_YEAR', '1', '2016', '87', sys_guid(), 'EVAL_YEAR', 'PERF_T_DEPTPERFEVALTJ', '评价年度', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIAGENCYALLPAY', null, '1', 'AGENCYGUID', '1', '2016', '87', sys_guid(), 'AGENCYGUID', 'PERF_T_DEPTPERFEVALTJ', '预算单位', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', sys_guid(), 'FININTORGGUID', 'PERF_T_DEPTPERFEVALTJ', '业务科室', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EVAL_PRO_AMT', '1', '2016', '87', sys_guid(), 'EVAL_PRO_AMT', 'PERF_T_DEPTPERFEVALTJ', '评价项目金额', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EVAL_SCORE', '1', '2016', '87', sys_guid(), 'EVAL_SCORE', 'PERF_T_DEPTPERFEVALTJ', '评价分数', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIEVALTYPETJ', null, '1', 'EVAL_TYPE', '1', '2016', '87', sys_guid(), 'EVAL_TYPE', 'PERF_T_DEPTPERFEVALTJ', '评价方式', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INST_NAME', '1', '2016', '87', sys_guid(), 'INST_NAME', 'PERF_T_DEPTPERFEVALTJ', '机构名称', 'S', '4000', null, 1, 1, null, sysdate);


--ui
--01 填报页面
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperfevalTJ/report';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '保存', 1, 1, 'keepicon', 'deptperfevalTJ.save', null, '保存', 'pmkpi', 'save', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '新增', 1, 2, 'keepicon', 'deptperfevalTJ.addrow', null, '新增', 'pmkpi', 'addrow', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '删除', 1, 3, 'keepicon', 'deptperfevalTJ.delrows', null, '删除', 'pmkpi', 'delrows', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '送审', 1, 4, 'searchicon', 'deptperfevalTJ.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '取消送审', 1, 5, 'searchicon', 'deptperfevalTJ.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '审核情况', 1, 6, 'searchicon', 'deptperfevalTJ.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', '导出附件', 1, 10, 'searchicon', 'deptperfevalTJ.expfile', null, '导出附件', 'pmkpi', 'expfile', null, '{zipname:''''}', '87', '2016');


delete from p#busfw_t_uitabpage where key ='/pmkpi/deptperfevalTJ/report';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/report', '待送审', 'waitaudit', 1, 1, 'choosed', 'deptperfevalTJ.clickTabpage', 0, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '已送审', null, '保存,删除,新增,送审', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/report', '被退回', 'back', 1, 3, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '被退回', null, '取消送审,新增', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '曾经办', null, '保存,删除,新增,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uiqueryform where key='/pmkpi/deptperfevalTJ/report';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_PRO_NAME', '评价项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFEVALTJ', null, '87', '2016');


delete from p#busfw_t_uitable where key ='/pmkpi/deptperfevalTJ/report';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'V_PERF_T_DEPTPERFEVALTJ', 100, 0, 0, 'order by dept_code,create_time', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/deptperfevalTJ/report';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'GUID', '主键', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'DEPT_CODE', '部门代码', 1, 1, 0, 0, null, 1, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'DEPT_NAME', '预算部门', 2, 1, 0, 0, null, 1, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_PRO_NAME', '评价项目名称', 3, 1, 1, 0, null, 1, 1, null, null, null, null, 200, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_YEAR', '开展评价年度', 4, 1, 1, 0, null, 1, 0, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_PRO_AMT', '评价项目金额', 5, 1, 1, 0, null, 1, 0, null, null, null, null, 150, 0, 'amt', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_SCORE', '评价得分', 6, 1, 1, 0, null, 1, 0, null, '{unit: 1, dotname: 2, qfw: true}', null, null, 80, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'EVAL_TYPE', '评价方式', 7, 1, 1, 0, null, 1, 0, null, '#name', null, null, 80, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'INST_NAME', '机构名称', 8, 1, 1, 0, null, 0, 0, null, null, null, null, 180, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'FILE1', '附件（报告）', 9, 1, 1, 0, null, 0, 0, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'FILE2', '附件（指标体系评分表）', 10, 1, 1, 0, null,0, 0, null, null, null, null, 170, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'WFID', '流程ID', 91, 0, 0, 0, null, 0, 0, null, null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperfevalTJ/report', 'WFSTATUS', '流程状态', 92, 0, 0, 0, null, 0, 0, null, null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);


--02 审核页面
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperfevalTJ/audit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '审核', 1, 1, 'searchicon', 'deptperfevalTJ.wfAudit', null, '审核', 'pmkpi', 'audit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '取消审核', 1, 2, 'searchicon', 'deptperfevalTJ.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '退回', 1, 3, 'searchicon', 'deptperfevalTJ.wfAudit', null, '退回', 'pmkpi', 'back', null, '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '审核情况', 1, 6, 'searchicon', 'deptperfevalTJ.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/audit', '导出附件', 1, 10, 'searchicon', 'deptperfevalTJ.expfile', null, '导出附件', 'pmkpi', 'expfile', null, '{zipname:''''}', '87', '2016');


delete from p#busfw_t_uitabpage where key ='/pmkpi/deptperfevalTJ/audit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptperfevalTJ.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '已审核', null, '退回,审核', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/audit', '被退回', 'back', 1, 3, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperfevalTJ/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptperfevalTJ.clickTabpage', 0, '曾经办', null, '退回,审核,取消审核', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);


--03 查询页面
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperfevalTJ/query';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/query', '审核情况', 1, 6, 'searchicon', 'deptperfevalTJ.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/query', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperfevalTJ/query', '导出附件', 1, 10, 'searchicon', 'deptperfevalTJ.expfile', null, '导出附件', 'pmkpi', 'expfile', null, '{zipname:''''}', '87', '2016');
