begin
  --项目绩效目标查询 通版 审核状态字段默认隐藏
delete from p#busfw_t_uicolumn where key in('/pmkpi/program/query/list') and columncode = 'WFSTATUS';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2DE4AF3A70A54E2FA67F84B8D8701BC0', '/pmkpi/program/query/list', 'WFSTATUS', '审核状态', 15, 0, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);
