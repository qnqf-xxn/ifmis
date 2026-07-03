begin

delete from p#busfw_t_uicolumn t where t.guid in('B84E0D56D6127E46E0730100077F8888','B84E0D56D6127E46E0730100077F9999');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F8888', '/pmkpi/setting/tempdataset', 'ISEDIT', '是否编辑', 28, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F9999', '/pmkpi/setting/tempdataset', 'ISADD', '是否新增', 29, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

update p#busfw_t_uicolumn set columncode='OPERATION' where key = '/pmkpi/setting/tempdataset' and columncode = 'OPERATION';
update p#busfw_t_uicolumn set format='#name',issource='1',type='tree' where key='/pmkpi/setting/tempdataset' and columncode='ISLEAF';
update p#busfw_t_uicolumn set format='#code',issource='1',type='tree' where key='/pmkpi/setting/tempdataset' and columncode='BUSTYPE';
