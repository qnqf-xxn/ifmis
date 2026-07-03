begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/report/treeindex') and t.columncode='OPINION_REMARK';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C9A7EEAF7DB0320EE0533315A8C03A7D', '/pmkpi/program/report/treeindex', 'OPINION_REMARK', '审核意见', 51, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{"datalength":4000}', null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E87BEB6E7A9E43EF80C804621F49FCA1', '/pmkpi/deptperformance/report/perfindex', 'V_BGT_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perfindex') and t.columncode='OPINION_REMARK';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C9A7EEAF7E73320EE0533315A8C03A7D', '/pmkpi/deptperformance/report/perfindex', 'OPINION_REMARK', '审核意见', 51, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{"datalength":4000}', null);
