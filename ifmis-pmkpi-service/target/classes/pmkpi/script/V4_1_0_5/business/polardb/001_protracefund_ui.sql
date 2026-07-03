BEGIN

delete from p#busfw_t_uitable t where key in('/pmkpi/program/trace/report/edit/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null,'2016','87');

delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/report/edit/fund';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'BGTGET', '预算执行率(%)', 9, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'f', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'AMT3', '调整后预算数', 7, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'AMT4', '预算执行数', 8, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'NAME', '资金来源', 1, 1, 0, 1, null, 0, 6, null, null, null, null, 150, 0, 's', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'AMT1', '年初预算', 5, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'AMT2', '调整预算数', 6, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/fund', 'AMT6', '预算执行数(其他)', 8, 1, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null,'2016','87');
