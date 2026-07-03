i integer;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='KPIVALSOURCE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add KPIVALSOURCE VARCHAR2(40)';
  end if;
  SELECT count(1) into i FROM bus_t_Diccolumn t where t.tablecode = 'PM_PERF_INDICATOR' and t.columncode = 'KPIVALSOURCE';
  if i = 0 then
    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, 'KPIVALSOURCE', null, '1', 'KPIVALSOURCE', '1', '2021', '87', 'BA6A94194222D03FE053B11FA8C057C9', 'KPIVALSOURCE', 'PM_PERF_INDICATOR', '定量其他值', 'S', '40', null, 1, 0, null, sysdate);
  end if;
  
  SELECT count(*) into i FROM Busfw_t_Uieditform t where t.key = '/pmkpi/program/prjindex/editindex' and t.columncode = 'KPIVALSOURCE';
  if i =0 then
     insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
     values ('BA67A26DD9E23875E053B11FA8C0360D', '/pmkpi/program/prjindex/editindex', 'V_PM_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');
  end if;
  
  SELECT count(*) into i FROM Fasp_t_Dicdssource t where t.appid = 'pmkpi' and t.elementcode = 'KPIVALSOURCE';
  if i = 0 then
     insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
     values ('KPIVALSOURCE', 'KPIVALSOURCE', 'KPIVALSOURCE', '定量待定', '1', '20180424221721795', '20180424', null, '2019', '340000000', null, null, null, '1', '[{guid:"暂不确定",code:"1",name:"暂不确定"},{guid:"项目实际值",code:"2",name:"项目实际值"}]', null, 1, 'pmkpi');
  end if;
  
  execute immediate 'create or replace view v_pm_perf_indicator as
  select *
  from pm_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';