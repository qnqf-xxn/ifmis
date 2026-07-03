begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/query' and code = 'allFileExp';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('3915EBD6812419E4C5A98C267B18FCB1', '/pmkpi/evaluation/financial/query', '导出附件', 0, 7, 'searchicon', 'finevalquery.allFileExp', null, '导出附件', 'pmkpi', 'allFileExp', null, '{}', '87', '2016');

delete from p#busfw_t_uifunction t where key = '/pmkpi/evaluation/dept/resultquery' and code = 'allFileExp';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('9807B8AE6DD66CAD3ADAFE0FF774E1F5', '/pmkpi/evaluation/dept/resultquery', '导出附件', 0, 7, 'searchicon', 'deptevaluationresult.allFileExp', null, '导出附件', 'pmkpi', 'allFileExp', null, '{}', '87', '2016');
