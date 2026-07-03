begin

--监控指标增加展示列
--项目支出
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report/edit/indextarget' and columncode in('FILE','FILENAME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', 'FILE', '附件管理', 21, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', 'FILENAME', '附件材料', 22, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
--部门整体
delete from p#busfw_t_uicolumn where key = '/pmkpi/trace/report/deptedit/indextarget' and columncode in('FILE','FILENAME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', 'FILE', '附件管理', 21, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', 'FILENAME', '附件材料', 22, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);


--自评指标增加展示列
--项目支出
delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/selfindex' and columncode in('FILE','FILENAME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', 'FILE', '附件管理', 15, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', 'FILENAME', '附件材料', 16, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
--部门整体
delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/editdept/selfindex' and columncode in('FILE','FILENAME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', 'FILE', '附件管理', 14, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', 'FILENAME', '附件材料', 15, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

--监控指标增加展示列
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/report/list' and columncode = 'PROGUID';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'PROGUID', '项目主键', 21, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);

