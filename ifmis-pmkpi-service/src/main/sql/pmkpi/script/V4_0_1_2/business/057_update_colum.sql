 BEGIN 
 UPDATE p#Busfw_t_Uieditform SET COLUMNCODE='BUSI_TYPE_CODE'  WHERE key='/pmkpi/program/report/proindex'  and COLUMNCODE='BUSI_TYPE';
 UPDATE p#Busfw_t_Uieditform SET COLUMNCODE='BUSI_TYPE_CODE'  WHERE key='/pmkpi/program/report/protabgoal'  and COLUMNCODE='BUSI_TYPE';
 UPDATE p#Busfw_t_Uieditform SET COLUMNCODE='BUSI_TYPE_CODE'  WHERE KEY like '/pmkpi/%'  and COLUMNCODE='BUSI_TYPE' and APPID='pmkpi';
UPDATE p#BUSFW_T_UICOLUMN SET COLUMNCODE='BUSI_TYPE_CODE'  WHERE KEY like '/pmkpi/%'  and COLUMNCODE='BUSI_TYPE'; 
delete  from  Busfw_t_Uieditform where  KEY='/pmkpi/deptperformance/report/editindex'  and  COLUMNCODE='BUSI_TYPE_CODE';
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE") VALUES ('C3C44E9022A404BFE053B11FA8C05B6E', '/pmkpi/deptperformance/report/editindex', '', 's', '业务类型代码', 'BUSI_TYPE_CODE', '0', NULL, '49', NULL, '1', NULL, NULL, 'pmkpi', '0', NULL, '{}', NULL, NULL, NULL);
delete  from  Busfw_t_Uieditform where  key='/pmkpi/adjust/report/deptedit/goal'  and  COLUMNCODE='BUSI_TYPE_CODE';
INSERT INTO Busfw_t_Uieditform("GUID", "KEY", "TABLECODE", "TYPE", "NAME", "COLUMNCODE", "ISVISIABLE", "SHOWLEVEL", "REQUIREMENT", "DEFAULTVALUE", "ORDERNUM", "COLSPANNUM", "TEXTAREAROWS", "APPID", "ISEDIT", "LEVELCONTROL", "CONFIG", "FROMSOURCE", "BOTTOMCONTRL", "SETVALUE") VALUES ('B9D8BDAA8B64DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 's', '业务类型代码', 'BUSI_TYPE_CODE', '0', NULL, '1', NULL, '1', NULL, NULL, 'pmkpi', '1', NULL, '{}', NULL, NULL, NULL);








