begin

--财政评价项目确定-选择项目-展示列(隐藏传值)
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/list' and columncode in('PRO_START_YEAR','PRO_TERM','LEADER_NAME','LEADER_TEL','PRO_TOTAL_AMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/list', 'PRO_START_YEAR', '开始日期', 25, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/list', 'PRO_TERM', '项目期限', 26, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/list', 'LEADER_NAME', '项目负责人', 27, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/list', 'LEADER_TEL', '项目联系人', 28, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/list', 'PRO_TOTAL_AMT', '项目总金额', 29, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);

--部门评价成果申报-基本信息-隐藏字段：联系人电话、绩效类型
update p#busfw_t_uieditform set isvisiable = 0 where key = '/pmkpi/evaluation/deptreport/edit' and columncode in('LEADER_PHONE','CATEGORY');

--部门评价成果申报-评价成果上传-隐藏页签：项目附件
update p#busfw_t_uitabpage set isvisiable = 0 where key = '/pmkpi/evaluation/dept/result/edit' and code = 'profile';
