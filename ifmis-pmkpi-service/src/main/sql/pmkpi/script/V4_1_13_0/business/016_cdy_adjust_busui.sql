begin
  
--调整列表
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/adjust/report/list') and t.columncode in('ADJUSTSOURCE','DELWFSTATUS','DELOPINION','DELAUDITOPINION','CREATETIME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'ADJUSTSOURCE', '数据来源', 2, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{lefttabtype:''program''}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'DELWFSTATUS', '申请删除状态', 3, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{lefttabtype:''program''}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'DELOPINION', '申请删除意见', 4, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{lefttabtype:''program''}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'DELAUDITOPINION', '申请删除审批意见', 5, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{lefttabtype:''program''}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'CREATETIME', '填报时间', 14, 0, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 200, 0, 'd', null, null, '87', '2016', null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/report') and t.code in('delwaitaudit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/report', '删除目标调整申请', 'delwaitaudit', 0, 0, 'nomal', 'adjustreport.clickTabpage', 1, '删除目标调整申请', null, '调整,送审,取消送审,选择项目,删除项目', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/adjust/report') and t.code='canceldel';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report', '撤回删除申请', 0, 9, 'searchicon', 'adjustreport.canceldel', null, '撤回删除申请', 'pmkpi', 'canceldel', null, '{"delwfstatus":"1","type":"1"}', '87', '2016', null, null);

--调整指标
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/adjust/report/proedit/index') and t.columncode in('INDSOURCE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'INDSOURCE', '指标来源', 51, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

--调整审核意见
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/audit/adjdelopinion');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/adjdelopinion', 'BUSFW_T_DCWORKFLOWLOGS', 'textarea', '意见', 'REMARK', 1, null, 0, null, 1, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/audit/adjdelopinion');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/adjdelopinion', '确定', 1, 1, 'searchicon', 'auditopinion.adjdelconfirm', null, '确定', '确定', 'save', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/adjdelopinion', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', '取消', 'cancle', null, '{}', '87', '2016', null, null);

--删除审批审核
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/delaudit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/delaudit', '待审批', 'delaudit', 1, 1, 'choosed', 'adjustreport.clickTabpage', 1, '待审批', null, null, '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/delaudit', '已审批', 'delalreadyaudit', 1, 2, 'nomal', 'adjustreport.clickTabpage', 1, '已审批', null, '同意,不同意', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/adjust/delaudit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/delaudit', '同意', 1, 1, 'searchicon', 'adjustreport.canceldel', null, '同意', 'pmkpi', 'audit', null, '{"delwfstatus":"2","type":"1"}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/delaudit', '不同意', 1, 2, 'searchicon', 'adjustreport.canceldel', null, '不同意', 'pmkpi', 'cancelaudit', null, '{"delwfstatus":"3","type":"1"}', '87', '2016', null, null);

delete from perf_t_treetab t where t.key in('/pmkpi/adjust/delaudit');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/adjust/delaudit', 'program', '项目支出', 1, null, 1, '2016', '87', 'B9A12B5D94761164E053B11FA8C0460E', '4C8E8484BF909291E063030011ACCE72', null);


delete from fasp_t_dicdssource t where t.guid in('PERFADJUSTSOURCE','PERFADJUSTDELSOURCE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFADJUSTDELSOURCE', 'PERFADJUSTDELSOURCE', 'PERFADJUSTDELSOURCE', '绩效调整删除状态', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''PERFADJUSTDELSOURCE'' and t.status=1', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFADJUSTSOURCE', 'PERFADJUSTSOURCE', 'PERFADJUSTSOURCE', '绩效调整来源', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''PERFADJUSTSOURCE'' and t.status=1', null, 1, 'pmkpi');

delete from perf_t_datasource t where t.elementcode='PERFADJUSTSOURCE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '自行申请', null, '00', 1, 1, 1, 'PERFADJUSTSOURCE', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '项目内容变更', null, '00', 1, 1, 2, 'PERFADJUSTSOURCE', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '预算追加追减', null, '00', 1, 1, 3, 'PERFADJUSTSOURCE', 1, '20201204', '20201204', 2020, '87');

delete from perf_t_datasource t where t.elementcode='PERFADJUSTDELSOURCE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '审批中', null, '00', 1, 1, 1, 'PERFADJUSTDELSOURCE', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '审批通过', null, '00', 1, 1, 2, 'PERFADJUSTDELSOURCE', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '审批不通过', null, '00', 1, 1, 3, 'PERFADJUSTDELSOURCE', 1, '20201204', '20201204', 2020, '87');
