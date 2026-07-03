begin

--项目-自评指标权重增加一列权重设定值
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/perfself/apply/edit/selfindex' and columncode in('WEIGHT','WEIGHT1');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C211A2BA11E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'WEIGHT', '权重', 11, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C9B8B5C5E31D7C90E0533315A8C0D6A5', '/pmkpi/perfself/apply/edit/selfindex', 'WEIGHT1', '权重设定值', 10, 1, 0, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

--部门-自评指标权重增加一列权重设定值
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/perfself/apply/editdept/selfindex' and columncode in('WEIGHT','WEIGHT1');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex015', '/pmkpi/perfself/apply/editdept/selfindex', 'WEIGHT', '权重', 11, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('18573CA4AB454C52B3064D469210D878', '/pmkpi/perfself/apply/editdept/selfindex', 'WEIGHT1', '权重设定值', 10, 1, 0, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);


