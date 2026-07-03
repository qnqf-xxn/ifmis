begin

--调整隐藏权重，调整后权重
delete from p#busfw_t_uicolumn where key = '/pmkpi/adjust/report/proedit/index' and columncode in('ADJUSTWEIGHT','WEIGHT');

insert into P#BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B24655E053B11FA8C02228', '/pmkpi/adjust/report/proedit/index', 'ADJUSTWEIGHT', '调整后权重', 17, 0, 1, 1, null, 0, null, null, null, null, null, 100, 0, 'f', null, null );

insert into P#BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B24655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'f', null, null);


