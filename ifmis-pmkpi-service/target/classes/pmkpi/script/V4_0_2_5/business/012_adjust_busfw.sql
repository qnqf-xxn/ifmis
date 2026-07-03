begin
  
delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/report/list' and guid = '4A6A71E59667BE6814B6CD93F5F4D92C';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('4A6A71E59667BE6814B6CD93F5F4D92C', '/pmkpi/program/report/list', 'PRO_CODE', 'ÏîÄ¿±àÂë', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', '{}', null);  
