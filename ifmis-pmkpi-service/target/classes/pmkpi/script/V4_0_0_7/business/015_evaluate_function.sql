begin
  
DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/evaluate/thirdevaluate/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'pmkpi_thirdevaluateservice', '{}', 'thirdevaluateservice', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'busdclefttree', '{w:true}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'busuidatatable', '{name:''事前绩效评估'',checkbox:true,title:''事前绩效评估'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/program/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator]}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/index', 'busfw.dataexport', '{}', 'dataexport1', 'pmkpi', null);


UPDATE P#busfw_t_Uifunction t set t.name='确认评估',t.title='确认评估' where t.key='/pmkpi/evaluate/thirdevaluate/index' and t.code='confirm' and t.guid='BC4E595CCE4D11C7E053B11FA8C0AD52';
UPDATE P#busfw_t_Uifunction t set t.name='取消评估',t.title='取消评估' where t.key='/pmkpi/evaluate/thirdevaluate/index' and t.code='unconfirm' and t.guid='BC4E595CCE4711C7E053B11FA8C0AD52';


UPDATE P#busfw_t_Uieditform t set t.ordernum='1' where t.key='/pmkpi/assessment/evaluate/audit' and t.columncode='AUDITTYPE' and t.guid='1FF75408D51A40CCB2FCF751CB17AE22';
UPDATE P#busfw_t_Uieditform t set t.ordernum='3' where t.key='/pmkpi/assessment/evaluate/audit' and t.columncode='OPINION' and t.guid='C9618B1F4DB446E9BE5EC1377A46A468';
UPDATE P#busfw_t_Uieditform t set t.ordernum='5',t.requirement='0' where t.key='/pmkpi/assessment/evaluate/audit' and t.columncode='OLDOPINION' and t.guid='54EE81489CE1489D8C6069A27123E875';
UPDATE P#busfw_t_Uieditform t set t.ordernum='7' where t.key='/pmkpi/assessment/evaluate/audit' and t.columncode='ISAUDIT' and t.guid='56B00CECBBB946CEBC07D00FECD1DB07';
