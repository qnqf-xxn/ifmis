begin
  
DELETE FROM Bus_t_Diccolumn t WHERE t.tablecode='V_PERF_PROJECT_YEAR' and t.columncode in ('CUR_AMT','REPLY_AMT','DIS_AMT','ADJ_AMT','APPLY_UP','BGTAMT');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'BGTAMT', '1', null, null, 'D0419BBF19D723B8E0533315A8C0fr23', 'BGTAMT', 'V_PERF_PROJECT_YEAR', '当年预算总额', 'N', null, null, 1, 1, null, sysdate);



DELETE FROM p#Busfw_t_Uicolumn t WHERE t.key='/pmkpi/yearprogram/query/list' and t.columncode in ('BGTAMT','PRO_TOTAL_AMT','APPLY_UP','CREATE_TIME','WFSTATUS');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FE23B8E2313315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'BGTAMT', '当年预算金额', 11, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FE23B8E0522215A8C0FC8D', '/pmkpi/yearprogram/query/list', 'PRO_TOTAL_AMT', '项目总金额', 10, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);


DELETE FROM p#Busfw_t_Uiqueryform t WHERE t.key='/pmkpi/yearprogram/query/list' and t.columncode in ('BGTAMT','PRO_TOTAL_AMT','YEAR','WFSTATUS','APPLY_UP');
insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('00419BBF196523B8E0533315A8C0890D', '/pmkpi/yearprogram/query/list', 'BGTAMT', '当年预算金额', 12, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{region:1}', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D0444BBF196523B8E0533315A8C0FC88', '/pmkpi/yearprogram/query/list', 'PRO_TOTAL_AMT', '项目总金额', 10, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{region:1}', null);



DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/yearprogram/query/list' and t.code in ('queryaudit','hbexpdocpf','hbexpdoc');
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD24E1BF09664095A3AA158E41237888', '/pmkpi/yearprogram/query/list', '导出目标批复表(河北)', 0, 10, 'searchicon', 'yearprogramquery.hbexpdoc', null, '导出目标批复表', 'pmkpi', 'hbexpdocpf', null, '{tempatecode:''hbprogoalandindexpf''}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD24E1BF09664095A3AA158E41237434', '/pmkpi/yearprogram/query/list', '导出项目支出表(河北)', 0, 12, 'searchicon', 'yearprogramquery.hbexpdoc', null, '导出项目支出表(河北)', 'pmkpi', 'hbexpdoc', null, '{tempatecode:''hbprogoalandindex''}');
