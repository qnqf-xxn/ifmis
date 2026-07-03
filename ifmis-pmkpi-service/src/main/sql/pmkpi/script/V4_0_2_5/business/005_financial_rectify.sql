begin
  --财政评价成果上传、财政评价成果审核三个功能增加发起整改功能 按钮默认隐藏
delete from p#busfw_t_uifunction where key in('/pmkpi/evaluation/financial/resultupload','/pmkpi/evaluation/financial/resultaudit') and code ='rectify';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B99482100E0533315A8C01D6A', '/pmkpi/evaluation/financial/resultupload', '发起整改', 0, 10, 'searchicon', 'finevaluationresult.rectify', null, '发起整改', 'pmkpi', 'rectify', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B99492100E0533315A8C01D6A', '/pmkpi/evaluation/financial/resultaudit', '发起整改', 0, 10, 'searchicon', 'finevaluationresult.rectify', null, '发起整改', 'pmkpi', 'rectify', null, '{}');
