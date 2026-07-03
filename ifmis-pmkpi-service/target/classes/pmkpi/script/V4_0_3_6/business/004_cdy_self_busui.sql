begin

--自评任务布置
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/taskmanage') and t.COLUMNCODE in('CREATER','CREATETIME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'CREATER', '布置人', 20, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'CREATETIME', '布置时间', 21, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 'd', '{}', null, null, null);

--自评填报、审核、查询
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/query') and t.columncode in('BUDGETAMOUNT','BGTAMT','EXECAMOUNT','PRO_TOTAL_AMT','EXECRATENUM');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'BUDGETAMOUNT', '年初预算数', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'BGTAMT', '当年预算数', 7, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'EXECAMOUNT', '全年执行数', 8, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PRO_TOTAL_AMT', '项目总金额', 9, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 1, 'amt', '{type:''program''}', null, null, null);