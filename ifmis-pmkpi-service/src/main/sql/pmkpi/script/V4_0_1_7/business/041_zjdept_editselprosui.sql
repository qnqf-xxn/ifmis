begin
  
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptZJformance/report/edit/selpros';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('C54A53885dd29FA125296EF5881610', '/pmkpi/deptZJformance/report/edit/selpros', '确定', 1, 1, 'Keepicon', 'pmkpideptselpros.savepros', null, '确定', 'pmkpi', null, null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('C54A5399562sf29FA125296EF5881610', '/pmkpi/deptZJformance/report/edit/selpros', '取消', 1, 2, 'Nofinishicon', 'pmkpideptselpros.close', null, '取消', 'pmkpi', null, null, null, '87', '2016');

delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/report/edit/selpros1';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('81D58CDF834F433990F688439FB9E951', '/pmkpi/deptZJformance/report/edit/selpros1', 'V_PERF_BGT_INDEXPRO', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/edit/selpros1';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C44D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C33D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_ID', '项目id', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C1127EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_CODE', '项目编码', 2, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C55D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_TOTAL_AMT', '金额', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C66D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros1', 'AGENCYGUID', '单位编码', 5, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/report/edit/selpros2';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('81D58CDF834F4DDS0F688439FB9E951', '/pmkpi/deptZJformance/report/edit/selpros2', 'V_PERF_BGT_INDEXPRO', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete FROM p#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/edit/selpros2';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F35670D47F86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros2', 'AGENCYGUID', '单位编码', 5, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F3493D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros2', 'PRO_TOTAL_AMT', '金额', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C91D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros2', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C88D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros2', 'PRO_ID', '项目id', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EDE78F34C77D47EF86A4CD6FDC5E4A65', '/pmkpi/deptZJformance/report/edit/selpros2', 'PRO_CODE', '项目编码', 2, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');
