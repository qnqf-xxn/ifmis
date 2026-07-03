begin
 
--编辑区   
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/set/uieditformcols/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/uieditformcols/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'editpage', '{main:[datatable],footer:[toolbutton]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/set/uieditformcols/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uieditformcols/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uieditformcols/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uieditformcols/edit', 'busuidatatable', '{addrow:true,name:''编辑区'',edit:true,checkbox:true,title:''编辑区''}', 'datatable', 'pmkpi', null);


--按钮  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/set/uifunctioncols/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/uifunctioncols/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'uifunctionpage', '{main:[datatable],footer:[toolbutton]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/set/uifunctioncols/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uifunctioncols/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uifunctioncols/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uifunctioncols/edit', 'busuidatatable', '{addrow:true,name:''按钮编辑区'',edit:true,checkbox:true,title:''按钮编辑区''}', 'datatable', 'pmkpi', null);
  

--页签      
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/set/uitabcols/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/uitabcols/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'uitabpage', '{main:[datatable],footer:[toolbutton]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/set/uitabcols/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uitabcols/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uitabcols/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uitabcols/edit', 'busuidatatable', '{addrow:true,name:''页签编辑区'',edit:true,checkbox:true,title:''页签编辑区''}', 'datatable', 'pmkpi', null);



--查询区    
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/set/uiqueryformcols/edit'; 
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/uiqueryformcols/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'uiqueryform', '{main:[datatable],footer:[toolbutton]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/set/uiqueryformcols/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uiqueryformcols/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uiqueryformcols/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uiqueryformcols/edit', 'busuidatatable', '{addrow:true,name:''查询编辑区'',edit:true,checkbox:true,title:''查询编辑区''}', 'datatable', 'pmkpi', null);


--表格  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/set/uidatatablecols/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/uidatatablecols/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'uitable', '{main:[editform,datatable],footer:[toolbutton]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/set/uidatatablecols/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uidatatablecols/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uidatatablecols/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uidatatablecols/edit', 'buseditform', '{title:''表格基本信息''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/uidatatablecols/edit', 'busuidatatable', '{addrow:true,name:''表格列编辑区'',edit:true,checkbox:true,title:''表格列编辑区''}', 'datatable', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_uiset';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_uiset', '组件编辑', null, '组件编辑', '/pmkpi/setting/buspage/ui/uiservice.js', 'Ext.lt.pmkpi.uiservice', 'pmkpi', 'pmkpi.setting.buspage.ui.UiService');
 

DELETE FROM bus_t_Diccolumn t where t.tablecode='P#BUSFW_T_UITABPAGE' and t.columncode in ('COMPONENTKEY','COMPONENTCALLBACKFN','DEFAULTFILTER','COMPONENTID','COMPONENTCONFIG','COMPONENTSERVICEID','COMPONENTDRAW');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTKEY', '1', '2016', '87', 'BFFB5D877106FDC9E053B11FA8C0823E', 'COMPONENTKEY', 'P#BUSFW_T_UITABPAGE', 'COMPONENTKEY', 's', '255', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTCALLBACKFN', '1', '2016', '87', 'BFFB5D877107FDC9E053B11FA8C0823E', 'COMPONENTCALLBACKFN', 'P#BUSFW_T_UITABPAGE', 'COMPONENTCALLBACKFN', 's', '32', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'DEFAULTFILTER', '1', '2016', '87', 'BFFB5D877105FDC9E053B11FA8C0823E', 'DEFAULTFILTER', 'P#BUSFW_T_UITABPAGE', '默认值', 's', '500', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTID', '1', '2016', '87', 'BFFB5D877102FDC9E053B11FA8C0823E', 'COMPONENTID', 'P#BUSFW_T_UITABPAGE', '组件ID', 's', '100', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTCONFIG', '1', '2016', '87', 'BFFB5D877108FDC9E053B11FA8C0823E', 'COMPONENTCONFIG', 'P#BUSFW_T_UITABPAGE', 'COMPONENTCONFIG', 's', '500', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTSERVICEID', '1', '2016', '87', 'BFFB5D877104FDC9E053B11FA8C0823E', 'COMPONENTSERVICEID', 'P#BUSFW_T_UITABPAGE', 'COMPONENTSERVICEID', 's', '100', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTDRAW', '1', '2016', '87', 'BFFB5D877103FDC9E053B11FA8C0823E', 'COMPONENTDRAW', 'P#BUSFW_T_UITABPAGE', 'COMPONENTDRAW', 's', '32', null, 1, 1, null, sysdate);


DELETE FROM bus_t_Diccolumn t where t.tablecode='BUSFW_T_UITABPAGE' and t.columncode in ('COMPONENTKEY','COMPONENTCALLBACKFN','DEFAULTFILTER','COMPONENTID','COMPONENTCONFIG','COMPONENTSERVICEID','COMPONENTDRAW');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTKEY', '1', '2016', '87', 'C024A30CA9962308E053B11FA8C0C3B1', 'COMPONENTKEY', 'BUSFW_T_UITABPAGE', 'COMPONENTKEY', 's', '255', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTCALLBACKFN', '1', '2016', '87', 'C024A30CA9982308E053B11FA8C0C3B1', 'COMPONENTCALLBACKFN', 'BUSFW_T_UITABPAGE', 'COMPONENTCALLBACKFN', 's', '32', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'DEFAULTFILTER', '1', '2016', '87', 'C024A30CA9992308E053B11FA8C0C3B1', 'DEFAULTFILTER', 'BUSFW_T_UITABPAGE', '默认值', 's', '500', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTID', '1', '2016', '87', 'C024A30CA99D2308E053B11FA8C0C3B1', 'COMPONENTID', 'BUSFW_T_UITABPAGE', '组件ID', 's', '100', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTCONFIG', '1', '2016', '87', 'C024A30CA9A02308E053B11FA8C0C3B1', 'COMPONENTCONFIG', 'BUSFW_T_UITABPAGE', 'COMPONENTCONFIG', 's', '500', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTSERVICEID', '1', '2016', '87', 'C024A30CA9A22308E053B11FA8C0C3B1', 'COMPONENTSERVICEID', 'BUSFW_T_UITABPAGE', 'COMPONENTSERVICEID', 's', '100', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COMPONENTDRAW', '1', '2016', '87', 'C024A30CA9A42308E053B11FA8C0C3B1', 'COMPONENTDRAW', 'BUSFW_T_UITABPAGE', 'COMPONENTDRAW', 's', '32', null, 1, 1, null, sysdate);

 
DELETE FROM bus_t_Diccolumn t where t.tablecode='BUSFW_T_UICOLUMN' and t.columncode in ('ISEDIT','ISSOURCE','ISVISIABLE','REQUIREMENT','TYPE');
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '87007Dzvfa09', null, '0', 'ISEDIT', '1', '2015', '87', '86659384A3EF5276E05357FE7B0AE3B9', 'ISEDIT', 'BUSFW_T_UICOLUMN', '是否可编辑', 'n', null, null, 1, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700I935L0bK', null, '0', 'ISSOURCE', '1', '2015', '87', '86659384A3F95276E05357FE7B0AE3B9', 'ISSOURCE', 'BUSFW_T_UICOLUMN', '是否有来源', 'n', '1', null, 1, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700I935L0bK', null, '0', 'ISVISIABLE', '1', '2015', '87', '86659384A3EE5276E05357FE7B0AE3B9', 'ISVISIABLE', 'BUSFW_T_UICOLUMN', '是否显示', 'n', null, null, 1, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700I935L0bK', null, '0', 'REQUIREMENT', '1', '2015', '87', '86659384A3F25276E05357FE7B0AE3B9', 'REQUIREMENT', 'BUSFW_T_UICOLUMN', '校验', 'n', null, null, 1, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700vKBAsP9B', null, '0', 'TYPE', '1', '2015', '87', '86659384A3FA5276E05357FE7B0AE3B9', 'TYPE', 'BUSFW_T_UICOLUMN', '来源类型', 's', '50', null, 1, 1, null, sysdate);

DELETE FROM bus_t_Diccolumn t where t.tablecode='BUSFW_T_UIQUERYFORM' and t.columncode='TYPE';
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700vKBAsP9B', null, '0', 'TYPE', '1', '2015', '87', '86659384A3BD5276E05357FE7B0AE3B9', 'TYPE', 'BUSFW_T_UIQUERYFORM', '类型', 's', '50', null, 1, 1, null, sysdate);
