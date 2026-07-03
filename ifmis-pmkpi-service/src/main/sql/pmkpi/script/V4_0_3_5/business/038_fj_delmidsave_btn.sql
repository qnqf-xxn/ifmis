begin

--监控自评暂存和清除暂存按钮，默认隐藏
delete from P#BUSFW_T_UIFUNCTION where KEY = '/pmkpi/perfself/apply/edit';

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit', '暂存', 0, 0, 'Keepicon', 'tabfreamedit.midsave', null, '暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit', '清除暂存', 0, 1, 'Keepicon', 'tabfreamedit.delmidsave', null, '清除暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit', '保存', 1, 2, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit', '取消', 1, 3, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, null, null);

delete from P#BUSFW_T_UIFUNCTION where KEY = '/pmkpi/program/trace/report/edit';

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit', '暂存', 0, 0, 'Keepicon', 'tabfreamedit.midsave', null, '暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit', '清除暂存',0, 1, 'Keepicon', 'tabfreamedit.delmidsave', null, '清除暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit', '保存', 1, 2, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit', '取消', 1, 3, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, null, null);

delete from P#BUSFW_T_UIFUNCTION where KEY = '/pmkpi/trace/report/deptedit';

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit', '暂存', 0, 0, 'Keepicon', 'tabfreamedit.midsave', null, '暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit', '清除暂存', 0, 1, 'Keepicon', 'tabfreamedit.delmidsave', null, '清除暂存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit', '保存', 1, 2, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null, null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit', '取消', 1, 3, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, null, null);


