begin

--一般监控项目
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolist') and t.columncode in('BGTAMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'BGTAMT', '当年预算金额', 8, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 'amt', '{type:''waitaudit''}', null, null, null);

--重点监控项目
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolistimp') and t.columncode in('BGTAMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'BGTAMT', '当年预算金额', 8, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 'amt', '{type:''waitaudit''}', null, null, null);

--监控填报、审核
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/report') and t.columncode in('BUDGETAMOUNT','BGTAMT','EXECAMOUNT','PRO_TOTAL_AMT','EXECRATENUM');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'BUDGETAMOUNT', '年初预算数', 20, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'BGTAMT', '当年预算金额', 21, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'EXECAMOUNT', '全年执行数', 22, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'PRO_TOTAL_AMT', '项目总金额', 23, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 1, 'amt', '{type:''protrace''}', null, null, null);

--监控查询
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/query') and t.columncode in('BUDGETAMOUNT','BGTAMT','EXECAMOUNT','PRO_TOTAL_AMT','EXECRATENUM');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'BUDGETAMOUNT', '年初预算数', 20, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'BGTAMT', '当年预算金额', 21, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'EXECAMOUNT', '全年执行数', 22, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'PRO_TOTAL_AMT', '项目总金额', 23, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 1, 'amt', '{type:''protrace''}', null, null, null);
