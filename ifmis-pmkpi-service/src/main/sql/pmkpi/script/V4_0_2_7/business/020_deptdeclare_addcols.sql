i number(3);
begin
  --监控主表添加字段  填报人
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='ENDYEAR';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(ENDYEAR NUMBER(4))';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view V_PERF_T_DEPTPERFDECLARE as
    select *
    from PERF_T_DEPTPERFDECLARE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  --注册字段
  delete from Bus_t_Diccolumn t where t.columncode = 'ENDYEAR' and t.tablecode = 'PERF_T_DEPTPERFDECLARE';
  
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, 'PMKPIDEPTPERFENDYEAR', null, '1', 'ENDYEAR', '1', '2016', '87', 'E0E85D48FE710E02E0535164A8C009B9', 'ENDYEAR', 'PERF_T_DEPTPERFDECLARE', '长期目标截止年份', 'N', '4', null, 1, 1, null, sysdate);
  ---注册数据源
  delete from Fasp_t_Dicdssource t where t.elementcode = 'PMKPIENDYEAR';
  
  insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
  values ('PMKPIDEPTPERFENDYEAR', 'PMKPIENDYEAR', 'PMKPIENDYEAR', '长期目标截止年份', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '1', '[{guid:"2022",code:"2022",name:"2022"},{guid:"2023",code:"2023",name:"2023"},{guid:"2024",code:"2024",name:"2024"},{guid:"2025",code:"2025",name:"2025"}]', null, 1, 'pmkpi');
