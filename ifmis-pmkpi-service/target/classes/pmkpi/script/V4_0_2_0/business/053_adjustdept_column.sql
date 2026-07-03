begin
--绩效目标调整  --部门整体指标调整合计行显示错误，不要向上合计
delete from p#busfw_t_uicolumn where key ='/pmkpi/adjust/report/deptedit/index' and columncode in('COMPUTESIGN','METERUNIT','ADJUSTINDEXVAL');
--部门
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCECFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'COMPUTESIGN', '计算符号', 9, 1, 0, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF3FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'METERUNIT', '计量单位', 11, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCE9FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'ADJUSTINDEXVAL', '调整后指标值', 11, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

--项目
delete from p#busfw_t_uicolumn where key ='/pmkpi/adjust/report/proedit/index' and columncode in('ADJUSTINDEXVAL');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C975E5A904F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/index', 'ADJUSTINDEXVAL', '调整后指标值', 11, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);
