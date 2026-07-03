begin


delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/report/proindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AC8DAC5CC1714FF98F33597062A1AA41', '/pmkpi/program/report/proindex', 'TARGETVALUE', '中期目标值', 4, 0, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('490A893F51CA495B9673847B241A891B', '/pmkpi/program/report/proindex', 'CZ', '操作', 10, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9B9EDBC004F94B1487F00942414C2E25', '/pmkpi/program/report/proindex', 'FINDEX', '一级指标', 1, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1EC42B484785448797A2AD22129B4CE4', '/pmkpi/program/report/proindex', 'INDEXVAL', '年度目标值', 5, 1, 1, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('43F617A737604357999DC1D85153B138', '/pmkpi/program/report/proindex', 'NAME', '三级指标', 3, 1, 0, 0, null, null, 1, null, null, null, null, 350, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7E8BAC514C4E4F15B582AE4F45F3EB5E', '/pmkpi/program/report/proindex', 'SINDEX', '二级指标', 2, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C7EE3BBF033E4209B13F2022C22D2E41', '/pmkpi/program/report/proindex', 'WEIGHT', '权重', 9, 1, 1, 1, null, null, 1, null, null, null, null, 100, 1, 'amt', null, null);
