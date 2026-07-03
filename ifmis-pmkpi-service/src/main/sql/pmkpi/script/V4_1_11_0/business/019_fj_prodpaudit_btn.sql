begin

--按钮
delete from p#busfw_t_uifunction where KEY = '/pmkpi/program/reportdp/audit' and CODE ='auditbatch';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/reportdp/audit', '批量审核', 0, 8, null, 'tlprogramauditdp.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}', '87', '2016', null, null);

delete from p#busfw_t_uifunction where KEY = '/pmkpi/program/reportdp/jxaudit' and CODE ='auditbatch';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/reportdp/jxaudit', '批量审核', 0, 8, null, 'jxauditdp.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}', '87', '2016', null, null);

