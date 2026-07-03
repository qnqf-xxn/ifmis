
  i number;
begin

  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTTASK' and t.column_name='TASKCONTEXT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTTASK add taskcontext VARCHAR2(4000)';

  end if;

execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_DEPTTASK AS
SELECT
  t.*
FROM
  PERF_T_DEPTTASK t
WHERE
  year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
  AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
  
delete from bus_t_diccolumn t where t.tablecode IN('PERF_T_DEPTTASK') and t.columncode='TASKCONTEXT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TASKCONTEXT', '1', '2016', '87', '54E89421BF8E5DB0E063030011AC0845', 'TASKCONTEXT', 'PERF_T_DEPTTASK', 'ÈÎÎñÄÚÈÝ', 'S', '4000', null, 1, 1, null, sysdate);
