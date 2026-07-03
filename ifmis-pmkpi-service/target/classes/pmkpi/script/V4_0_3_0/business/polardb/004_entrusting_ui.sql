begin

delete from p#busfw_t_uitable t where t.key = '/pmkpi/randomcomment/entrusting';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG,YEAR,PROVINCE)
values ('1DC8865E90EB4114842D3B97CE89C824', '/pmkpi/randomcomment/entrusting', 'V_PERF_INTERMEDIARYINFO', 100, 1, null, null, null, 'pmkpi', '{}','2016','87');

delete from p#busfw_t_uicolumn t where t.key = '/pmkpi/randomcomment/entrusting';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG,YEAR,PROVINCE)
values ('E05015B534EF468AAD945283B99C9811', '/pmkpi/randomcomment/entrusting', 'ADDRESS', '中介机构地址', 3, 1, 0, null, null, null, null, null, null, null, null, 400, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('FD9CA91600EE471A9A977F863B6B4343', '/pmkpi/randomcomment/entrusting', 'CODS', '统一社会信用代码', 2, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('B4FA6B0522F941DDBA4AAA19050BB64B', '/pmkpi/randomcomment/entrusting', 'NAME', '中介机构名称', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('199C76326302449D92F9FB444004BDA3', '/pmkpi/randomcomment/entrusting', 'LEGALPERSON', '法人', 4, 1, 0, null, null, null, null, null, null, null, null, 20, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('6DF434D9DE577196E053D100A8C0375C', '/pmkpi/randomcomment/entrusting', 'GUID', 'id', 6, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('B0CA42D3CB644242AA5EBB6830BD734F', '/pmkpi/randomcomment/entrusting', 'EDITPEOPLE', '联系人', 5, 1, 0, null, null, null, null, null, null, null, null, 20, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('59C0D4A2C35A4C959CD11D7F59F573FC', '/pmkpi/randomcomment/entrusting', 'TEL', '联系电话', 6, 1, 0, null, null, null, null, null, null, null, null, 20, 0, 's', '{}', '2016','87');


delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/entrusting';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values ('FBC972F006C14C7BBE41D9057784DAC9', '/pmkpi/randomcomment/entrusting', 'NAME', '中介机构名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_INTERMEDIARYINFO', null, null,'2016','87');


update fasp_t_dicdssource set datasource ='select guid as guid,guid as code,name as name,''#'' as superguid,1 as levelno,1 as isleaf from V_PERF_INTERMEDIARYINFO' where guid = 'MEACHGUID' 
