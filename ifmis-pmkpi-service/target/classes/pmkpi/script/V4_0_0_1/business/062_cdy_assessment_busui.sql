begin


delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/assessment/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('71744DF6611C4D74875FAF8ACF937B96', '/pmkpi/setting/assessment/list', 'V_PERF_T_ASSESSMENTTEMP', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/assessment/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE885DC6855D469814', '/pmkpi/setting/assessment/list', 'OBLIGATE', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC62689EB81747298F1EDCC26D24DE47', '/pmkpi/setting/assessment/list', 'WEIGHT', '权重', 3, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D16BE33B81DF486FBB1609F69ACA6408', '/pmkpi/setting/assessment/list', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA889A9A7DB9426DAE575EA8A32EF11C', '/pmkpi/setting/assessment/list', 'POINTS', '评估要点', 4, 1, 1, 0, null, 0, null, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39C1152FC12A480C82D4B8614A942882', '/pmkpi/setting/assessment/list', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('29284FC3B1C5434CBB147C9BD779A00B', '/pmkpi/setting/assessment/list', 'NAME', '指标名称', 2, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/assessment/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B825B87423AD4C99BBDB09BEC2B036C3', '/pmkpi/setting/assessment/list', '保存', 1, 1, 'Keepicon', 'assessment.save', null, '保存', 'pmkpi', null, null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/assessment/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('867FEFD0095E4E48A441246454EF829B', '/pmkpi/program/assessment/list', 'V_PERF_T_ASSESSMENT', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/assessment/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC62689EB81747298F1EDCC26D24DE47', '/pmkpi/program/assessment/list', 'WEIGHT', '权重', 3, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EA7E2662515C43E89DEF134DB8F4EDF9', '/pmkpi/program/assessment/list', 'POINTS', '评估要点', 4, 1, 0, 0, null, 0, null, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('848EEB586F5B4AA89848E9D836530E99', '/pmkpi/program/assessment/list', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FD5F6538D5C54E83A1D7F8CE38468B8C', '/pmkpi/program/assessment/list', 'NAME', '指标名称', 2, 1, 0, 0, null, 0, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9FF9A9DDFAB4F7B853CFD374F387A11', '/pmkpi/program/assessment/list', 'SCORENUM', '评估得分', 6, 1, 1, 0, null, 1, null, null, null, null, null, 100, 0, 's', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/assessment/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('84443F7E319E4F28B112745946A63E0D', '/pmkpi/program/assessment/list', '保存', 1, 1, 'Keepicon', 'perfassessment.save', null, '保存', 'pmkpi', null, null, null);


