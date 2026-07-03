begin

--页面注册
delete from Bus_t_Pageconsole t where t.url='/pmkpi/setting/fundtemp';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/fundtemp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.fund.FundtempSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/setting/fundtemp';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/fundtemp', 'pmkpi_fundtemp', '{}', 'fundtemp', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/fundtemp', 'busuidatatable', '{name:''资金模板配置'',checkbox:true,title:''资金模板配置'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/fundtemp', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/fundtemp', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_fundtemp';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_fundtemp', '资金模板配置', null, '资金模板配置', '/pmkpi/setting/fund/fundtempservice.js', 'Ext.lt.pmkpi.fundtemp', 'pmkpi', 'pmkpi.setting.fund.FundtempSetService');


--页面组件

delete from p#busfw_t_Uifunction t where t.key='/pmkpi/setting/fundtemp';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D35C80F5758B4FBFBD6CF1CEF10E37BA', '/pmkpi/setting/fundtemp', '保存', 1, 1, 'searchicon', 'fundtemp.tablesave', null, '保存', 'pmkpi', 'tablesave', null, '{}');


delete from p#busfw_T_uitable t where t.key='/pmkpi/setting/fundtemp';
insert into busfw_T_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('3CF6531AB3CD45A693E26DB5F6DC27FE', '/pmkpi/setting/fundtemp', 'V_PERF_T_FUNDTEMP', 0, 0, 0, null, null, 'pmkpi', '{}');


delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/setting/fundtemp';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC406B5344A84419BDFD60116D3E2D1A', '/pmkpi/setting/fundtemp', 'CODE', '编码', 2, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DD7787BE25E1407DBFA1C1512F3231FA', '/pmkpi/setting/fundtemp', 'FUNDNAME', '资金名称', 8, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9B2CB6A9F31247FBA7F635E0C5666F81', '/pmkpi/setting/fundtemp', 'FUNDTYPE', '资金类型', 7, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB6FCA7EC44B45F580E02B7A66A9ECF2', '/pmkpi/setting/fundtemp', 'NAME', '名称', 3, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('500EA08B37364A0CB6354D6C678431C5', '/pmkpi/setting/fundtemp', 'QUERYSQL', '查询SQL', 4, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DEB7F39EDA294D38A8B791E49878E5AE', '/pmkpi/setting/fundtemp', 'SUMCOL', '行合计', 5, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

