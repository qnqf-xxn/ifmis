 i integer;
begin
 select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_IMPEXPMAIN';
  if i=0 then
   execute immediate 'create table PERF_T_IMPEXPMAIN
(GUID           VARCHAR2(40) not null,
	CODE           VARCHAR2(100),
	NAME           VARCHAR2(100),
	PROVINCE       VARCHAR2(9) not null,
  YEAR           CHAR(4) not null,
	tablecode      VARCHAR2(100) not null,
	beanid          VARCHAR2(100) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(partition P87 values (''87'')
  ( subpartition P87_Y2016 values (''2016'')))';
execute immediate 'alter table PERF_T_IMPEXPMAIN add constraint PK_PERF_T_IMPEXPMAIN primary key (GUID, YEAR, PROVINCE)';
execute immediate 'create or replace view V_PERF_T_IMPEXPMAIN as
select *
  FROM PERF_T_IMPEXPMAIN T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';		
END IF;
delete BUS_T_DICCOLUMN where TABLECODE='PERF_T_IMPEXPMAIN';
--GUID
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_IMPEXPMAIN', NULL, 's', '40', NULL, '1', '0', NULL, SYSDATE);
--CODE
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'CODE', '1', '2016', '87', sys_guid(), 'CODE', 'PERF_T_IMPEXPMAIN', NULL, 's', '100', NULL, '1', '0', NULL, SYSDATE);
--NAME
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'NAME', '1', '2016', '87', sys_guid(), 'NAME', 'PERF_T_IMPEXPMAIN', NULL, 's', '100', NULL, '1', '0', NULL, SYSDATE);
--PROVINCE
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_IMPEXPMAIN', NULL, 'S','9',NULL, '1', '0', NULL, SYSDATE);
--tablecode
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'TABLECODE', '1', '2016', '87', sys_guid(), 'TABLECODE', 'PERF_T_IMPEXPMAIN', NULL, 'S','100',NULL, '1', '0', NULL, SYSDATE);
--BEANID
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'BEANID', '1', '2016', '87', sys_guid(), 'BEANID', 'PERF_T_IMPEXPMAIN', NULL, 'S','100',NULL, '1', '0', NULL, SYSDATE);
--YEAR
INSERT INTO BUS_T_DICCOLUMN("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, NULL, NULL, '0', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_IMPEXPMAIN', NULL, 'S','9',NULL, '1', '0', NULL, SYSDATE);
--编辑区注册
DELETE  Bus_t_Pageconsole where URL='/pmkpi/setting/impexp/impexpmianedit';
INSERT INTO Bus_t_Pageconsole("URL", "TEMPLATE", "PAGE", "JSLIB", "CSSLIB", "OBJLIB", "APPID", "CONSOLESERVICE", "METHOD", "CONFIG", "SUPCONSOLE", "REGION", "ISEXPAND") VALUES ('/pmkpi/setting/impexp/impexpmianedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', NULL, NULL, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.impexpsub.PerfTImpexpsubPage', 'editimpexp', '{main:[editform],footer:[toolbutton]}', NULL, NULL, NULL);
DELETE  Bus_t_Pageconsolecomconfig where URL='/pmkpi/setting/impexp/impexpmianedit';
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/setting/impexp/impexpmianedit', 'pmkpi_impexpmianedit', '{}', 'impexpmianedit', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/setting/impexp/impexpmianedit', 'buseditform', '{title:''模板类型操作'',tablecode:''V_PERF_T_IMPEXPMAIN'',iswf:''true''}', 'editform', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/setting/impexp/impexpmianedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', NULL);
DELETE  Bus_t_Pagecomponent where id='pmkpi_impexpmianedit';
INSERT INTO Bus_t_Pagecomponent("ID", "NAME", "TYPE", "REMARK", "JSLIB", "JSOBJECTNAME", "APPID", "SERVICE") VALUES ('pmkpi_impexpmianedit', '模板类型编辑', NULL, '模板类型编辑', '/pmkpi/setting/impexp/impexpmainedit.js', 'Ext.lt.pmkpi.impexpmainedit', 'pmkpi', 'pmkpi.setting.impexpsub.PerfTImpexpMainEditService');
DELETE  p#Busfw_t_Uifunction where KEY='/pmkpi/setting/impexp/impexpmianedit';
INSERT INTO Busfw_t_Uifunction("GUID", "KEY", "NAME", "ISVISIABLE", "ORDERNUM", "CLASSNAME", "ACTION", "DISABLED", "TITLE", "APPID", "CODE", "PARAM", "CONFIG", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', '取消', '1', '2', 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', NULL, '取消', 'pmkpi', 'cancle', NULL, NULL, '87', '2016');
INSERT INTO Busfw_t_Uifunction("GUID", "KEY", "NAME", "ISVISIABLE", "ORDERNUM", "CLASSNAME", "ACTION", "DISABLED", "TITLE", "APPID", "CODE", "PARAM", "CONFIG", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', '保存', '1', '1', 'Keepicon', 'impexpmianedit.infosave', NULL, '保存', 'pmkpi', 'infosave', NULL, NULL, '87', '2016');
DELETE  p#Busfw_t_Uieditform where KEY='/pmkpi/setting/impexp/impexpmianedit';
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 's', '主键', 'GUID', '0', NULL, '0', NULL, '40', NULL, NULL, 'pmkpi', '1', NULL, '{}', '0', '1', NULL, '87', '2016');
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 's', '模板编码', 'CODE', '1', NULL, '1', NULL, '100', NULL, NULL, 'pmkpi', '1', NULL, '{}', '0', '1', NULL, '87', '2016');
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 's', '模板名称', 'NAME', '1', NULL, '1', NULL, '100', NULL, NULL, 'pmkpi', '1', NULL, '{}', '0', '1', NULL, '87', '2016');
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 's', '表名', 'TABLECODE', '1', NULL, '1', NULL, '100', NULL, NULL, 'pmkpi', '1', NULL, '{}', '0', '1', NULL, '87', '2016');
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE", "PROVINCE", "YEAR") VALUES (sys_guid(), '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 's', 'BEANID', 'BEANID', '1', NULL, '1', NULL, '100', NULL, NULL, 'pmkpi', '1', NULL, '{}', '0', '1', NULL, '87', '2016');