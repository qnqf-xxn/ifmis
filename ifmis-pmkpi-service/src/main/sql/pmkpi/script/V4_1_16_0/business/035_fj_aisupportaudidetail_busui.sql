begin

--辅助审核页面列表-广西
delete from p#busfw_t_uitable where key in('/pmkpi/common/aisupportauditdetail/gx') and province = '87' and year = '2016';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'V_PERF_T_AISUPPORTAUDIDETAIL', null, 0, 0, null, null, 'pmkpi', null,'87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/common/aisupportauditdetail/gx' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'audit_type', '类目', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'audit_point', '指标', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'audit_standard', '审核标准', 3, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'audit_content', '审核细则', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 400, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'ispass', '是否通过', 5, 1, 0, 0, null,0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'nopass_indi', '原因', 6, 1, 0, 0, null,0, 1, null, null, null, null, 300, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail/gx', 'create_time', '审核时间', 7, 0, 0, 0, null,0, 1, null, null, null, null, 300, 0, 's', null, null,'87', '2016', null, null);



delete from p#busfw_t_uicolumn t where key ='/pmkpi/common/aisupportauditdetail' and columncode ='create_time' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'create_time', '审核时间', 7, 0, 0, 0, null,0, 1, null, null, null, null, 300, 0, 's', null, null,'87', '2016', null, null);
