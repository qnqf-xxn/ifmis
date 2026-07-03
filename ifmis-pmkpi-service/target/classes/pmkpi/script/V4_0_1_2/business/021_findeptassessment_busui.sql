begin

delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/deptassessment');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD92FD882538170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'V_PERF_T_FINEVALUATION', 100, 0, null, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/deptassessment');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD882539170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'WFSTATUS', '审核状态', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253A170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253B170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'CODE', '单位编码', 3, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253C170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'NAME', '单位名称', 4, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253D170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'AGENCYGUID', '预算单位', 6, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253E170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'YEAR', '预算年度', 7, 1, 0, null, null, null, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD88253F170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'FININTORGGUID', '业务科室', 12, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD882540170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'CREATER', '填报人', 13, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD882541170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD92FD882542170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
