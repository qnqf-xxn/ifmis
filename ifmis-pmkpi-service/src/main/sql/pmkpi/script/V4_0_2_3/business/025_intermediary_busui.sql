begin

--busui
--指派中介-按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluate/thirdevaluate/entrust';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4BA2E85FB7677B3E0533315A8C002FA', '/pmkpi/evaluate/thirdevaluate/entrust', '确认勾选', 1, 1, 'searchicon', 'evaluateentrustservice.sel', null, '确认勾选', 'pmkpi', 'sel', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4BA2E85FB7777B3E0533315A8C002FA', '/pmkpi/evaluate/thirdevaluate/entrust', '取消勾选', 1, 2, 'searchicon', 'evaluateentrustservice.canceldel', null, '取消勾选', 'pmkpi', 'canceldel', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4BA2E85FB7877B3E0533315A8C002FA', '/pmkpi/evaluate/thirdevaluate/entrust', '保存', 1, 6, 'searchicon', 'evaluateentrustservice.save', null, '保存', 'pmkpi', 'entrust', null, '{}');

--指派中介-已选中介
--UI表注册  
delete from p#busfw_t_uitable where key = '/pmkpi/evaluate/thirdevaluate/selentrust';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4BA6A9DB95F7584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'V_PERF_SELINTERMEDIARY', 100, 1, 0, null, null, 'pmkpi', null);
--展示列注册  
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/evaluate/thirdevaluate/selentrust';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4BA6A9DB9607584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4BA6A9DB9617584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'NAME', '机构名称', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4BA6A9DB9627584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'INSTITUTIONAL', '机构性质', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4BA6A9DB9637584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'CREDITNO', '信用等级', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4BA6A9DB9647584E0533315A8C0BB85', '/pmkpi/evaluate/thirdevaluate/selentrust', 'EVALUATENUM', '评价累计数', 5, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);





