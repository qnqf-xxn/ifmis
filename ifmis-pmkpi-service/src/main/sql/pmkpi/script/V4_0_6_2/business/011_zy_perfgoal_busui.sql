begin
  
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/hbprotabgoal' and columncode = 'RATIO';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/program/report/hbprotabgoal', 'RATIO', '指标权重比例(%)', 4, 0, 1, 0, null, 1, 1, null, '1', null, null, 200, 0, 'i', '{}', null, null, null,'87',2016);


delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/hbprogoal' and columncode in ('RATIO','WEIGHTSCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbprogoal', 'RATIO', '指标权重比例%', 2, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, null, null,'87',2016);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbprogoal', 'WEIGHTSCORE', '指标权重得分', 3, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, null, null,'87',2016);
