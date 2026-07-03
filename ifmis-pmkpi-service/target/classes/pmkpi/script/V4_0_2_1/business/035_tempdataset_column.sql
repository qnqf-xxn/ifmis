begin
--评分表维护列表字段  
 --财政评价自评 是否末节点不可编辑，是否合计隐藏(工作考核显示)
delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/tempdataset' and columncode ='ISLEAF';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/tempdataset', 'ISLEAF', '是否末节点', 14, 1, 0, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', '{type:''evaluatescore''}', null);

delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/tempdataset' and columncode ='ISTOTAL';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E07301PP077F8888', '/pmkpi/setting/tempdataset', 'ISTOTAL', '是否合计', 28, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', '{type:''workscore''}', null);

delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/tempdataset' and columncode ='ISEDIT';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F8888', '/pmkpi/setting/tempdataset', 'ISEDIT', '是否编辑', 28, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', '{type:''evaluatescore''}', null);

delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/tempdataset' and columncode ='ISADD';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F9999', '/pmkpi/setting/tempdataset', 'ISADD', '是否新增', 29, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', '{type:''evaluatescore''}', null);

