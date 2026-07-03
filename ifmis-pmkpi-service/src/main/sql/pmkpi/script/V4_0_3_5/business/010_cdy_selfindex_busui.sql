begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/apply/edit/selfindex','/pmkpi/perfself/apply/editdept/selfindex') and t.COLUMNCODE in('OPINION_REMARK','AUDIT_SCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', 'AUDIT_SCORE', '核查分数', 20, 0, 0, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', 'OPINION_REMARK', '评审意见', 21, 0, 0, 0, '0', 0, 1, null, null, null, 0, 150, 0, 's', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', 'AUDIT_SCORE', '核查分数', 20, 0, 0, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', 'OPINION_REMARK', '评审意见', 21, 0, 0, 0, '0', 0, 1, null, null, null, 0, 150, 0, 's', '{}', null, null, null);

update p#busfw_t_uicolumn t set t.ordernum='30' where t.key in('/pmkpi/perfself/apply/edit/selfindex','/pmkpi/perfself/apply/editdept/selfindex') and t.columncode='FILE';
update p#busfw_t_uicolumn t set t.ordernum='31'where t.key in('/pmkpi/perfself/apply/edit/selfindex','/pmkpi/perfself/apply/editdept/selfindex') and t.columncode='FILENAME';

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/editdept/selfindex','/pmkpi/perfself/apply/edit/selfindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', '保存', 1, 1, 'Keepicon', 'selfindex.save', null, '保存', 'pmkpi', 'save', null, null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', '保存', 1, 1, 'Keepicon', 'selfindex.save', null, '保存', 'pmkpi', 'save', null, null, null, null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/apply/edit/selfindex','/pmkpi/perfself/apply/editdept/selfindex') and t.COLUMNCODE in('DEDUCT_SCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', 'DEDUCT_SCORE', '扣减分数', 11, 0, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', 'DEDUCT_SCORE', '扣减分数', 11, 0, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null, null, null);