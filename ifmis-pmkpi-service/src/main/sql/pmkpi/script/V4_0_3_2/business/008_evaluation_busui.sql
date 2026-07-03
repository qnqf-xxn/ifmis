begin
  
--事前绩效评估查询-导出项目附件   * filter = 'DE9176','DE9177'：DE9176-事前绩效评估报告（单位）、DE9177-事前绩效评估报告（财政）
delete from busfw_t_uifunction where key = '/pmkpi/seeting/evaluation/query' and code = 'batchPmExp';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', '导出项目附件', 0, 5, 'searchicon', 'evaluationquery.batchPmExp', null, '导出项目附件', 'pmkpi', 'batchPmExp', null, '{"zipname":"事前绩效评估附件","filter":"''DE9176'',''DE9177''"}');
