begin

delete from p#busfw_t_uicolumn t where key in ('/pmkpi/majorpolicy/evalindex','/pmkpi/majorpolicy/selrpro') and COLUMNCODE = 'AGENCY_CODE';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'AGENCY_CODE', '单位编码', 98, 0, 0, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'AGENCY_CODE', '单位编码', 98, 0, 0, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);
