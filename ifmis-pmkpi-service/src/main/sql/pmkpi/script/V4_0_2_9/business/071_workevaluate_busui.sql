begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/workevaluate/report/deptedit/score','/pmkpi/workevaluate/query/list') and t.columncode in('RATISCORE','SCORE','SELFSCORE','SCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/workevaluate/report/deptedit/score', 'RATISCORE', '评定分数', 5, 1, 1, 1, null, 0, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 30, 0, 'i', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/workevaluate/query/list', 'SCORE', '得分', 13, 1, 0, 0, null, 0, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 80, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/workevaluate/report/deptedit/score', 'SCORE', '分值', 2, 1, 0, 1, null, 0, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 30, 0, 'i', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/workevaluate/report/deptedit/score', 'SELFSCORE', '自评分数', 4, 1, 1, 1, null, 1, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 30, 0, 'i', null, null);
