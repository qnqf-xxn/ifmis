
begin
UPDATE p#Busfw_t_Uieditform SET "TYPE" = 'tree',"NAME" = '姓名',"ISVISIABLE" = '1',"CONFIG" = '{"format":"#name"}' ,ISEDIT='1'  WHERE TABLECODE='V_PERF_EXPERTINIFO' and key='/pmkpi/setting/baseinfo/expertinifo/edit' and  COLUMNCODE='GUID';

UPDATE  p#Busfw_t_Uieditform SET  "TYPE" = 's', "ISVISIABLE" = '0'   WHERE TABLECODE='V_PERF_EXPERTINIFO' and key='/pmkpi/setting/baseinfo/expertinifo/edit' and  COLUMNCODE='NAME'; 

delete from   Bus_t_Diccolumn where TABLECODE='PERF_EXPERTINIFO' and COLUMNCODE='GUID';

INSERT INTO Bus_t_Diccolumn("DEID", "CSID", "EXP", "ISSYS", "DBCOLUMNCODE", "ISUSES", "YEAR", "PROVINCE", "COLUMNID", "COLUMNCODE", "TABLECODE", "NAME", "DATATYPE", "DATALENGTH", "SCALE", "VERSION", "NULLABLE", "DEFAULTVALUE", "DBVERSION") VALUES (NULL, 'PERFNAME', NULL, '1', 'GUID', '1', '2016', '87', '09152E25F7BA42B3BE561798A675FB75', 'GUID', 'PERF_EXPERTINIFO', '主键', 'S', '40', NULL, '1', '1', NULL, sysdate);

delete from  FASP_T_DICDSSOURCE where GUID='PERFNAME';

INSERT INTO FASP_T_DICDSSOURCE("GUID", "CODE", "ELEMENTCODE", "NAME", "STATUS", "CREATETIME", "STARTTIME", "ENDTIME", "YEAR", "PROVINCE", "CRC", "TYPEGUID", "SHOWSTRUCT", "SOURCETYPE", "DATASOURCE", "DBVERSION", "VERSION", "APPID") VALUES ('PERFNAME', 'NAME', 'NAME', '专家名称', '1', NULL, NULL, NULL, '2021', '87', NULL, NULL, NULL, '2', 'select (t.guid||''#''||t.CODE) as guid ,NAME as name,STATUS from FASP_T_CAUSER t  order by t.ordernum', NULL, NULL, 'pmkpi');



