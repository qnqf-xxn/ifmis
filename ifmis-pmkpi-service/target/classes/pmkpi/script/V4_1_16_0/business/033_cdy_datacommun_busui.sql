begin
  
delete from p#busfw_t_uitable t where t.key in('/pmkpi/perfself/pushdatacommunication') and t.province='87' and t.year='2016';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'V_PERF_SELFPRO_DATACOMMUN', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/pushdatacommunication') and t.province='87' and t.year='2016';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'PRO_CODE', '项目编码', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 180, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'NAME', '名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'DEPT_CODE', '预算部门', 3, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 6, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null, '87', '2016', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/perfself/pushdatacommunication') and t.province='87' and t.year='2016';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', 'AGENCYGUID', '预算单位', 3, 1, 'tree', null, 1, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/pushdatacommunication') and t.province='87' and t.year='2016';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/pushdatacommunication', '待推送', 'wait', 1, 1, 'choosed', 'perfselfdatacommun.clickTabpage', null, '待推送', 'datacommun=''2''', '取消送审', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/pushdatacommunication', '已推送', 'already', 1, 2, 'nomal', 'perfselfdatacommun.clickTabpage', null, '已推送', 'datacommun=''1''', 'add', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/pushdatacommunication') and t.province='87' and t.year='2016';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/pushdatacommunication', '推送', 1, 1, 'searchicon', 'perfselfdatacommun.add', null, '推送', 'pmkpi', 'add', null, null, '87', '2016', null, null);

delete from fw_t_jobdetail t where t.appid='pmkpi' and t.jobid='pmkpi.DataCommunicationTask';
insert into fw_t_jobdetail (JOBID, JOBNAME, CRONEXPRESSION, JOBCLASS, PROVINCE, YEAR, ENABLE, APPID, REMARK, NEXTTIME, LASTTIME, LASTCALLRESULT, LASTPROVIDER)
values ('pmkpi.DataCommunicationTask', '山西自评价数据中心交互', '0 0 23 * * ? *', 'gov.mof.fasp2.pmkpi.timetask.DataCommunicationTask#dataCommunication', null, null, '0', 'pmkpi', '默认每天23点执行一次', null, null, null, null);
