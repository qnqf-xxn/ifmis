begin
  
DELETE FROM bus_t_diccolumn t 
WHERE t.tablecode='V_PERF_PROJECT_YEAR' 
and t.columncode in ('EXP_FUNC_CODE','GOV_BGT_ECO_CODE','APPLY_LINK','FISCAL_YEAR','FUND_TYPE_CODE',
'BUDGET_LEVEL_CODE','MANAGE_MOF_DEP_CODE','BGT_PMAN_ID','FOUND_TYPE_CODE','DEP_BGT_ECO_CODE',
'PRO_KIND_CODE','PROJECTKIND','PRO_CAT_CODE');


insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMPROJECTKINDEXTEND', null, '0', 'PROJECTKIND', '1', null, null, '68B1782E818F49AABCAC8BC532E1503F', 'PROJECTKIND', 'V_PERF_PROJECT_YEAR', '支出项目类别', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMVD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, 'D67F53894CBE4FA9E0535164A8C0F2A8', 'PRO_CAT_CODE', 'V_PERF_PROJECT_YEAR', '项目类别', 'S', '2', null, 1, 1, null, sysdate);


  
--
UPDATE p#Busfw_t_Uiqueryform t set t.name='项目名称' WHERE t.key='/pmkpi/yearprogram/query/list' and t.columncode='PRO_NAME';

DELETE FROM p#Busfw_t_Uiqueryform t WHERE t.key='/pmkpi/yearprogram/query/list' and t.columncode in ('EXP_FUNC_CODE','PRO_CODE','PRO_CAT_CODE');
insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('7EC3ED24F2A34BFFB10624870BAEAF99', '/pmkpi/yearprogram/query/list', 'PRO_CAT_CODE', '支出类别', 5, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('AA326A05729B4450A61E65B565DAD8C4', '/pmkpi/yearprogram/query/list', 'PRO_CODE', '项目编码', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null);


DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/yearprogram/query/list' and t.code='queryView';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF1A9123B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '查看项目', 1, 1, 'searchicon', 'yearprogramquery.queryView', null, '查看项目', 'pmkpi', 'queryView', null, null);

DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/yearprogram/query/edit' ;
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2452e9fa72be3a5ee9b4ca0864d3736y', '/pmkpi/yearprogram/query/edit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);


DELETE FROM p#Busfw_t_Uicolumn t WHERE t.key='/pmkpi/yearprogram/query/list' and t.COLUMNCODE in ('EXP_FUNC_CODE','PRO_CAT_CODE');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B1734D08A00749A59B0CAAF72FF994A0', '/pmkpi/yearprogram/query/list', 'PRO_CAT_CODE', '支出类别', 11, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);



DELETE FROM p#Busfw_t_Uitabpage t WHERE t.key='/pmkpi/yearprogram/query/edit' ;
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DABEC50F41374522A8939B5D0174F6A4', 'pmkpi', '/pmkpi/yearprogram/query/edit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''A298A7A14F70471A9B8FB1666AD6B2C3''}', null, '0', 'editform', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('015A930ED0C24C019E21C3DB5A79A73A', 'pmkpi', '/pmkpi/yearprogram/query/edit', '年度绩效目标', 'tabgoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'',action:''tlprotabgoal.save'',busguid:''C0B38427A5C119E4E053B11FA8C0573E''}', null, '0', 'iframetabgoal', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('653D386D95054982BB532CFD5D123C7A', 'pmkpi', '/pmkpi/yearprogram/query/edit', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/program/report/treeindex.page?showtab=1''}', null, '0', 'iframeindextable', null, null, null, null, null, null);



DELETE FROM p#Busfw_t_Uieditform t WHERE t.key='/pmkpi/yearprogram/query/edit' ;
insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B15BBD82E52243508B6EB5CE32EA42CD', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '版本号', 'VERSION', 0, null, 0, null, 795, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8DD2F282EF614D349E82CB73C23FED3F', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '建单人', 'CREATER', 0, null, 0, null, 360, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('292113B5C422411D8AB9815FD92B186C', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '流程状态', 'WFSTATUS', 0, null, 0, null, 380, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('623B1E4657694A9D98CEA9859C36C3F1', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 310, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DC58ED3672284897BE852DAF71D91A88', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '业务主键', 'GUID', 0, null, 0, null, 480, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('13F39E73BE36481A830EC60BF527E874', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '负责人电话', 'LEADER_TEL', 1, null, 0, null, 320, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3321A27983642E6B18585C6D4EAA057', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '负责人姓名', 'LEADER_NAME', 1, null, 0, null, 340, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('654CEA380DE64F5FBF8E9C6E96D0F755', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '负责人手机', 'LEADER_PHONE', 1, null, 0, null, 330, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4E378022420849F78F4883DCC7352D55', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '项目代码', 'PRO_CODE', 1, null, 0, null, 120, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D3A28291501D474A866EFB23E3D68D91', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 'tree', '项目类别', 'PRO_CAT_CODE', 1, null, 0, null, 122, null, null, 'pmkpi', 0, null, '{format:''#code-#name''}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3CE7137FEEAA428A89E280D2AE768BDD', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 'tree', '单位', 'AGENCY_CODE', 1, null, 0, null, 124, null, null, 'pmkpi', 0, null, '{format:''#code-#name''}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E200FC58ACB44C929746E4576D3D89B8', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '项目名称', 'PRO_NAME', 1, null, 0, null, 110, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A7B8FAD42D4A489B9490B74DC3BBFC6A', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '起始时间', 'PRO_START_YEAR', 1, null, 0, null, 130, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ADA610D52B1F4A7ABFED5C7BC0921FA2', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 'tree', '部门', 'DEPT_CODE', 0, '1', 0, null, 133, null, null, 'pmkpi', 0, null, '{"format":"#code-#name"}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E2DA8A92ED5844D0BE3E0D58B18F63C6', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 's', '审核人', 'AUDITOR', 0, null, 0, null, 420, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3634F1B5149D4BBFA7DB12D373A6FB82', '/pmkpi/yearprogram/query/edit', 'V_PERF_PROJECT_INFO', 'tree', '处室', 'FININTORGGUID', 1, null, 0, null, 128, null, null, 'pmkpi', 0, null, '{format:''#code-#name''}', null, null, null);


